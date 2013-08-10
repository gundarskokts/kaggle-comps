
% Download the image package if don't have it yet  
% Follow http://www.gnu.org/software/octave/doc/interpreter/Installing-and-Removing-Packages.html
% pkg install D:\Octave\image-1.0.15.tar.gz to install if needed 

%% Initialization
clear ; close all; clc

% Load Training Data
fprintf('Loading Data ...\n')

trainDataSaved = 1; % change this value to toggle between data already being loaded vs not 
					% could be passed on command line for a better solution 

if (trainDataSaved == 0) % if data is not saved, load from csv 
	TrainData = csvread ('D:\Personal\Kaggle\Digits\train.csv'); % this is the original training data 
	save ("-binary", "TrainData.bin", "TrainData"); 
else % load the saved bin file 
	load('TrainData.bin'); 
endif 

randomN = rand(); 
randomNo = randomN * 60 - 30; % makes the random rotation angle be in range -30, 30 

m = size(TrainData, 1)-1; 
n = size(TrainData, 2); 

% Rotated matrix will be the same size as the original data matrix 
rotatedMtrx = zeros(m, n); 

for i=2:size(TrainData, 1) % drop the first row as it is empty 
	testImage = reshape (TrainData(i, 2:end), 28, 28); % need to pass a 28x28 matrix as opposed to a vector 
	rotateSample = imrotate (testImage, randomNo, "nearest", "crop"); % actual rotate command 
		
	newElement = (rotateSample(:))'; 
	rotatedMtrx(i, 1) = TrainData(i, 1); % this is the training data so the actual value is the same (keep it from original data) 
	rotatedMtrx(i, 2:end) = newElement; % concatenate rotated matrix values with 1st column of TrainData 
endfor 

pause; 

save ("-binary", "rotatedMtrx.bin", "rotatedMtrx"); 

