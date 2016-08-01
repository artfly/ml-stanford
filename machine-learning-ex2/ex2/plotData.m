function plotData(X, y)
%PLOTDATA Plots the data points X and y into a new figure 
%   PLOTDATA(x,y) plots the data points with + for the positive examples
%   and o for the negative examples. X is assumed to be a Mx2 matrix.

% Create New Figure
figure; hold on;

% ====================== YOUR CODE HERE ======================
% Instructions: Plot the positive and negative examples on a
%               2D plot, using the option 'k+' for the positive
%               examples and 'ko' for the negative examples.
%



indOnes = find(y==1);
indZeroes = find(y==0);
plot(X(indZeroes, 2), X(indZeroes, 1), 'ro');
plot(X(indOnes, 2), X(indOnes, 1), 'b+');






% =========================================================================



hold off;

end
