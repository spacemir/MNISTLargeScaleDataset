%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       Script for reading and inspecting one of the MNISTLargeScale datasets
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

path = '<add_path>';

% This specific dataset contains scale variations in the range [1,4] 
% relative the original MNIST dataset
filename = 'mnist_large_scale_tr50000_vl10000_te10000_outsize112-112_sctr1p000-4p000_scte1p000-4p000.h5'

fprintf('\nRead the HDF5 dataset:\n %s\n\n', '/Users/yjansson/IRF_datasets/MNIST_scaled_renamed_for_upload/mnist_large_scale_te10000_outsize112-112_sctr0p500_scte0p500.h5')


% Read in the training, test and validation sets
x_train = h5read(strcat(path,filename),'/x_train');
x_test = h5read(strcat(path,filename),'/x_test');
x_val = h5read(strcat(path,filename),'/x_val');

y_train = h5read(strcat(path,filename),'/y_train');
y_test = h5read(strcat(path,filename),'/y_test');
y_val = h5read(strcat(path,filename),'/y_val');


% Note that since Matlab uses column-major (Fortran-style) order, 
% whereas the HDF5 standard uses row-major (C-style) order the data of 
% the shape [n_samples, xsize, ysize, channels] in the HDF5 file
% will be read into matlab arrays of the shape [channels, ysize, xsize, n_samples] 

s = size(x_train);
fprintf('x_train size: \t [%d, %d, %d, %d]\n', s(1), s(2), s(3), s(4))
s = size(y_train);
fprintf('y_train size: \t [%d, %d]\n\n', s(1), s(2))

s = size(x_test);
fprintf('x_test size: \t [%d, %d, %d, %d]\n', s(1), s(2), s(3), s(4))
s = size(y_test);
fprintf('y_test size: \t [%d, %d]\n\n', s(1), s(2))

s = size(x_val);
fprintf('x_val size: \t [%d, %d, %d, %d]\n', s(1), s(2), s(3), s(4))
s = size(y_val);
fprintf('y_val size: \t [%d, %d]\n\n', s(1), s(2))

fprintf('Dataset range: \t [%.2f, %.2f]\n', min(x_train(:)), max(x_train(:))) 


% One might wish to transpose the images before viewing them
% since the x and y axis will otherwise be flipped (see comment above about
% the Matlab vs HDF5 order of arrays)
x_train = permute(x_train, [1,3,2,4]);

%% Plot some of the images

nrows = 6;
ncols = 6;

images = x_train; 
labels = y_train;

figure('position',[50 50 800,800])
im = 1;
for i = 1:nrows
    for j = 1:ncols
        subplot(nrows, ncols, im)
        % 
        imagesc(squeeze(images(1,:,:, im)))
        title(labels(im))
        set(gca,'XTick',[], 'YTick', [])
        im = im + 1;
    end
end
colormap('gray')
