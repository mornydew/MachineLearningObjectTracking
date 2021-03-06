function [ Dout ] = cropEdges( D,cropSize )
%This function takes as input a data set D and cropSize where
%0<cropSize<1.It crops the edges of the images in data set D, 
%by cropSize amount, and returns the cropped version of the image as Dout.

dim1 = size(D,1);
dim2 = size(D,2);

Dout(:,:,:,:) = D(cropSize:dim1-cropSize,cropSize:dim2-cropSize,:,:);