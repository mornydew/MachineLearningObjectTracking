function [mask] = makeMask(N, innerRadius, outerRadius, centerx, centery)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Author: Manuel Bedrossian
% Date Created: 2017.08.18
% Date Last Modified: 2017.08.18
%
% This function creates a mask of 0's and 1's to be used in the frequency
% filtering of images (ifft(mask) gets convolved with an image)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[x, y] = meshgrid((1:N(1)), (1:N(2)));
mask = zeros(N(1), N(2));
mask((x-centerx).^2 + (y-centery).^2 < outerRadius^2) = 1;
mask((x-centerx).^2 + (y-centery).^2 < innerRadius^2) = 0;

imagesc(mask)
axis equal; axis([0 2048 0 2048]); colormap gray
drawnow