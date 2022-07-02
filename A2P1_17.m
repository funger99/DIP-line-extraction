%% Q1 part a
im = imread('airport.tif');
figure;
imshow(im);

%% Q1 part b

map = edge(im,'sobel',0.15,'nothinning');
figure, imshow(map);

%% Q1 part c

% compute hough transform
[H, T, R] = hough(map,'rhoResolution',2,'thetaResolution',0.5);
% display variable H as an image
figure, imshow(imadjust(mat2gray(H)), 'XData', T, 'YData', R)
hold on;
axis on;
daspect('auto')
xlabel('\theta')
ylabel('\rho')

%% Q1 part d

% find 2 most significant peaks
peaks = houghpeaks(H,2,'Threshold',0.75*max(H(:)),'NHoodsize',[21 21]);
% plot them on the hough transform
plot(T(peaks(:,2)),R(peaks(:,1)),'s','color','yellow');

%% Q1 part e

lines = houghlines(map,T,R,peaks,'FillGap',25);
% display the original runway image
figure;
imshow(im);
hold on;
% hold onto the runway image and superimpose the yellow lines
for k = 1:length(lines)
    xy = [lines(k).point1; lines(k).point2]
    % connect the endpoints of the lines associated with the peaks
    plot(xy(:,1), xy(:,2), 'linewidth', 3, 'color', 'yellow')
end

