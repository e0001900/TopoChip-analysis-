%% used for SunM topochips cropping
% created by Chan Way Dec 2016
% Outcome: coarsely cropped images replaced by 16 bit finely cropped images

clc; clear; close all

%% variables to adjust
imtype = 'png'; %'png', 'tif', etc;

%% loading file
dirIn = uigetdir('','Choose the folder that contains all the coarsely cropped images');

f = filesep; % file separator
images = dir([dirIn f '*.' imtype]); % specs for original image

%%
for i = 1:length(images)
    fprintf('Processing image %i/%i...\n',i,length(images))
    I = imread([dirIn f images(i).name]);
    [m,n] = size(I);
    Edge = edge(I,'canny'); % find edges
    [H,theta,rho] = hough(Edge); % hough transform to find lines
    P = houghpeaks(H,50);
    lines = houghlines(Edge,theta,rho,P,'FillGap',40,'MinLength',20);
    figure, imshow(I), hold on
    
    T = [0 0 n 0]; % top side end points
    B = [0 m n m]; % bottom side end points
    L = [0 0 0 m]; % left side end points
    R = [n 0 n m]; % right side end points
    lineT = [0 1 0]; % y=0
    lineB = [0 1 -m]; % y=m
    lineL = [1 0 0]; % x=0
    lineR = [1 0 -n]; % x=n
    for k = 1:length(lines)
        xy = [lines(k).point1; lines(k).point2];
        % plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
        
        % line in the form of ax+by+c=0 and expand the line to image borders
        a = xy(1,2)-xy(2,2);
        b = xy(2,1)-xy(1,1);
        c = -a*xy(1,1)-b*xy(1,2);
        lineTemp = [a b c];
        points = lineToBorderPoints(lineTemp,[m n]);
        
        % check for sides
        if points(2)<m/2 && points(4)<m/2
            if points(2)>T(2) || points(4)>T(4)
                T = points;
                lineT = lineTemp;
            end
        elseif points(2)>m/2 && points(4)>m/2
            if  points(2)<B(2) || points(4)<B(4)
                B = points;
                lineB = lineTemp;
            end
        elseif points(1)<n/2 && points(3)<n/2
            if  points(1)>L(1) || points(3)>L(3)
                L = points;
                lineL = lineTemp;
            end
        elseif points(1)>n/2 && points(3)>n/2
            if  points(1)<R(1) || points(3)<R(3)
                R = points;
                lineR = lineTemp;
            end
        end
    end
    TL = ([lineT(1:2);lineL(1:2)]\-[lineT(3);lineL(3)])'; % top left corner
    TR = ([lineT(1:2);lineR(1:2)]\-[lineT(3);lineR(3)])'; % top right corner
    BL = ([lineB(1:2);lineL(1:2)]\-[lineB(3);lineL(3)])'; % bottom left corner
    BR = ([lineB(1:2);lineR(1:2)]\-[lineB(3);lineR(3)])'; % bottom right corner
    % plot(T([1,3]),T([2,4]),'LineWidth',2,'Color','red')
    % plot(B([1,3]),B([2,4]),'LineWidth',2,'Color','red')
    % plot(L([1,3]),L([2,4]),'LineWidth',2,'Color','red')
    % plot(R([1,3]),R([2,4]),'LineWidth',2,'Color','red')
    % plot(TL(1),TL(2),'x','LineWidth',2,'Color','yellow')
    % plot(TR(1),TR(2),'x','LineWidth',2,'Color','yellow')
    % plot(BL(1),BL(2),'x','LineWidth',2,'Color','yellow')
    % plot(BR(1),BR(2),'x','LineWidth',2,'Color','yellow')
    h = impoly(gca,[TL;TR;BR;BL]); % roi
    Mask = createMask(h);
    Cropped = uint16(I).*uint16(Mask);
    % figure;imshow(Cropped)
    
    imwrite(Cropped,[dirIn f images(i).name],imtype)
    close
end
fprintf('Fine Cropping Done!\n')