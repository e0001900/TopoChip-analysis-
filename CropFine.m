%% For SunM topochips cropping
% created by Chan Way Dec 2016
% Outcome: coarsely cropped images replaced by finely cropped images

clc; clear; close all

%% Variables to adjust
imtype = 'png'; % 'png', 'tif', etc;
rotH = 1; % angle between top edge and horizontal line in deg, range:(-45,45]
fromBorder = 0.4; % ratio of image from borders to find edges
areaA = 0.4; % ratio of the roi to image size

%% Choose files
dirIn = uigetdir('','Choose the folder that contains all the coarsely cropped images');
tic % start timer
f = filesep; % file separator
images = dir([dirIn f '*.' imtype]); % specs for original image
manualCrop = zeros(length(images),1); % manual cropping check

%% Morphological structuring elements
rotV = atand(tand(rotH+90)); % perpendicular to rotH
rotA = 2; % rotation allowance

SE = strel('disk',1); % for dilation
SEh = strel('line',20,rotH); % for horizontal lines
SEv = strel('line',20,rotV); % for vertical lines

%% Loop using parfor for speed
parfor i = 1:length(images)
    fprintf('Processing image %i/%i...\n',i,length(images))
    I = imread([dirIn f images(i).name]);
    
    %% Process image
    [m,n] = size(I);
    
    % initiate parameters
    lineT = [0 1 0]; % y=0; ax+by+c=0; [a b c]
    lineB = [0 1 -m]; % y=m; ax+by+c=0; [a b c]
    lineL = [1 0 0]; % x=0; ax+by+c=0; [a b c]
    lineR = [1 0 -n]; % x=n; ax+by+c=0; [a b c]
    rhoT = 0; % distance between origin and top edge
    rhoB = m; % distance between origin and bottom edge
    rhoL = 0; % distance between origin and left edge
    rhoR = n; % distance between origin and right edge
    
    % find edges
    Edge = edge(I,'canny');
    EdgeH = imopen(Edge,SEh); % find horizontal edges
    EdgeV = imopen(Edge,SEv); % find vertical edges
    Edge = EdgeH + EdgeV;
    Edge = imdilate(Edge,SE);
    % figure, imshow(Edge)
    
    % hough transform to find lines
    [H,theta,rho] = hough(Edge);
    P = houghpeaks(H,20);
    lines = houghlines(Edge,theta,rho,P,'FillGap',40,'MinLength',10);
    figure, imshow(I), hold on
    
    for k = 1:length(lines)
        xy = [lines(k).point1; lines(k).point2];
        % plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
        
        % line in the form of ax+by+c=0
        a = xy(1,2) - xy(2,2);
        b = xy(2,1) - xy(1,1);
        c = -a*xy(1,1) - b*xy(1,2);
        lineTemp = [a b c];
        
        if abs(-lines(k).theta-rotV) < rotA || ... % lines.theta and rotV are on opposite angle coordinate (mirror)
                abs(-lines(k).theta-atan2d(-tand(rotV),-1)) < rotA % check horizontal
            if abs(lines(k).rho)<m*fromBorder && abs(lines(k).rho)>rhoT % check top edge
                lineT = lineTemp;
                rhoT = abs(lines(k).rho);
            elseif abs(lines(k).rho)>n*(1-fromBorder) && abs(lines(k).rho)<rhoB % check bottom edge
                lineB = lineTemp;
                rhoB = abs(lines(k).rho);
            end
        elseif abs(-lines(k).theta-rotH) < rotA || ... % lines.theta and rotH are on opposite angle coordinate (mirror)
                abs(-lines(k).theta-atan2d(-tand(rotH),-1)) < rotA % check vertical
            if abs(lines(k).rho)<n*fromBorder && abs(lines(k).rho)>rhoL % check left edge
                lineL = lineTemp;
                rhoL = abs(lines(k).rho);
            elseif abs(lines(k).rho)>n*(1-fromBorder) && abs(lines(k).rho)<rhoR % check right edge
                lineR = lineTemp;
                rhoR = abs(lines(k).rho);
            end
        end
    end
    % Solve [a b]*[x;y]=c for line interceptions
    TL = ([lineT(1:2);lineL(1:2)]\-[lineT(3);lineL(3)])'; % top left corner
    TR = ([lineT(1:2);lineR(1:2)]\-[lineT(3);lineR(3)])'; % top right corner
    BL = ([lineB(1:2);lineL(1:2)]\-[lineB(3);lineL(3)])'; % bottom left corner
    BR = ([lineB(1:2);lineR(1:2)]\-[lineB(3);lineR(3)])'; % bottom right corner
    h = impoly(gca,[TL;TR;BR;BL]); % roi
    
    %% Mask out roi and save the image
    Mask = createMask(h);
    if sum(sum(Mask))>m*n*areaA
        location = find(Mask==0);
        I(location) = 0;
        imwrite(I,[dirIn f images(i).name],imtype)
    else
        manualCrop(i) = 1;
    end
    close
end
toc % stop timer
if sum(manualCrop)==0
    fprintf('Fine Cropping Done!\n')
else
    fprintf('Manual cropping required:\n')
    for j = 1:length(manualCrop)
        if manualCrop
            fprintf('%s\n',images(j).name)
        end
    end
end
