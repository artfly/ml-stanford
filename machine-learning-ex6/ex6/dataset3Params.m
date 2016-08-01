function [C, sigma] = dataset3Params(X, y, Xval, yval)
%EX6PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = EX6PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

predictions = 0;
model = 0;
minerror = intmax;
curerror = 0;
C_cur = 0.01;
sigma_cur = 0.01;
while C_cur <= 30
	sigma_cur = 0.01;
	while sigma_cur <= 30
		model = svmTrain(X, y, C_cur, @(x1, x2) gaussianKernel(x1, x2, sigma_cur));
		predictions = svmPredict(model, Xval);
		curerror = mean(double(predictions ~= yval));
		if minerror > curerror
			minerror = curerror;
			C = C_cur;
			sigma = sigma_cur;
		end
		sigma_cur *= 3;
	end
	C_cur *= 3;
end





% =========================================================================

end
