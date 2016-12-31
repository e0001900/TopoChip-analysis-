%% For SunM topochips cropping
% created by Chan Way Dec 2016
% Outcome: finely cropped images will be stored in a folder

clc; clear; close all

%% Variables to adjust
rotH = -1; % angle between top edge and horizontal line in deg, range:(-45,45], recomended:(-20 20]
areaROI = 0.5; % expected ratio of the roi area to image area
fromBorder = 0.3; % distance of image from borders to find edges divided by image length
areaTol = 0.1; % area tolerance, ratio of the image area
Ph = 1; % channel number of phase contrast

%% Choose files
dirIn = uigetdir('','Choose the folder that contains all the coarsely cropped images');
tic % start timer
f = filesep; % file separator
imtype = 'tif'; % only works with tif
images = dir([dirIn f '*.' imtype]); % specs for original image

dirOut = [dirIn f 'FineCropped'];
mkdir(dirOut);

manualCrop = zeros(length(images),1); % initialize manual cropping check

%% Morphological structuring elements
rotV = atand(tand(rotH+90)); % perpendicular to rotH
rotTol = 2.5; % rotation tolerance

SE = strel('disk',1); % for dilation
SEh = strel('line',20,rotH); % for horizontal lines
SEv = strel('line',20,rotV); % for vertical lines

%% Initializing tiff info
info = imfinfo([dirIn f images(1).name]);
tags.ImageLength = info(1).Height;
tags.ImageWidth = info(1).Width;
tags.Photometric = Tiff.Photometric.MinIsBlack;
tags.BitsPerSample = info(1).BitDepth;
tags.PlanarConfiguration = Tiff.PlanarConfiguration.Chunky;
tags.Software = 'MATLAB';

%% Loop using parfor for speed
parfor i = 1:length(images)
    fprintf('Processing image %i/%i...\n',i,length(images))
    tr = Tiff([dirIn f images(i).name],'r');
    setDirectory(tr,Ph)
    I = read(tr);
    
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
    lineCheck = zeros(1,4); % check if the edge is the border of the image
    
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
        
        if abs(-lines(k).theta-rotV) < rotTol || ... % lines.theta and rotV are on opposite angle coordinate (mirror)
                abs(-lines(k).theta-atan2d(-tand(rotV),-1)) < rotTol % check horizontal
            if abs(lines(k).rho)<m*fromBorder && abs(lines(k).rho)>rhoT % check top edge
                lineT = lineTemp;
                rhoT = abs(lines(k).rho);
                lineCheck(1) = 1;
            elseif abs(lines(k).rho)>n*(1-fromBorder) && ...
                    abs(lines(k).rho)<rhoB % check bottom edge
                lineB = lineTemp;
                rhoB = abs(lines(k).rho);
                lineCheck(2) = 1;
            end
        elseif abs(-lines(k).theta-rotH) < rotTol || ... % lines.theta and rotH are on opposite angle coordinate (mirror)
                abs(-lines(k).theta-atan2d(-tand(rotH),-1)) < rotTol % check vertical
            if abs(lines(k).rho)<n*fromBorder && abs(lines(k).rho)>rhoL % check left edge
                lineL = lineTemp;
                rhoL = abs(lines(k).rho);
                lineCheck(3) = 1;
            elseif abs(lines(k).rho)>n*(1-fromBorder) && ...
                    abs(lines(k).rho)<rhoR % check right edge
                lineR = lineTemp;
                rhoR = abs(lines(k).rho);
                lineCheck(4) = 1;
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
    if abs(sum(sum(Mask))-m*n*areaROI) < m*n*areaTol && all(lineCheck)
        tw = Tiff([dirOut f images(i).name],'w');
        writeTiffStackMask(Mask,tr,tw,tags)
        close(tw)
    else
        manualCrop(i) = 1;
    end
    close(tr)
    close
end
toc % stop timer

%% Manual cropping
manualCropCheck = sum(manualCrop);
if manualCropCheck
    ques = sprintf(['Would you like to proceed with manual cropping ' ...
        'for %i image(s)?'],manualCropCheck);
    choice = questdlg(ques,'Manual Cropping Required','Yes','No','Yes');
    switch choice
        case 'Yes'
            k = 0;
            fprintf(['\nDraw ROI on the image displayed '...
                'and double click on ROI\n'])
            for i = 1:length(manualCrop)
                if manualCrop(i)
                    k = k + 1;
                    fprintf('Manual Cropping %i/%i...\n',k,manualCropCheck)
                    
                    tr = Tiff([dirIn f images(i).name],'r');
                    setDirectory(tr,Ph)
                    I = read(tr);
                    imshow(I)
                    h = impoly; % interactive polygon drawing
                    wait(h); % wait for double click on roi
                    Mask = createMask(h);
                    tw = Tiff([dirOut f images(i).name],'w');
                    writeTiffStackMask(Mask,tr,tw,tags)
                    close(tr)
                    close(tw)
                    close
                end
                fprintf('Fine Cropping Done!\n')
            end
        case 'No'
            fprintf(['\nPlease adjust the parameters\n' ...
                'OR call +65 8670 5358 for technical support\n'])
            manualCropIm = {images(manualCrop).name}';
            save([dirIn f 'ManualCrop'],'dirIn','dirOut','manualCropIm',...
                '-v4')
    end
else
    fprintf('\nFine Cropping Done!\n')
end
