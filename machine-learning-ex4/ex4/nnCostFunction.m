function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%

X_biased = [ones(size(X, 1), 1), X];
Hidden = sigmoid(Theta1 * X_biased');

Hidden_biased = [ones(size(Hidden, 2), 1), Hidden'];

prediction = sigmoid(Hidden_biased * Theta2');

outrange = 1:size(prediction, 2);
y_unrolled = outrange(ones(size(y, 1), 1), :) == y;

J = - y_unrolled .* log(prediction) - (1 - y_unrolled) .* log(1 - prediction);
Theta1_nonbiased = Theta1(:, 2:size(Theta1, 2));
Theta2_nonbiased = Theta2(:, 2:size(Theta2, 2));
regularization = sum(sum(Theta1_nonbiased .* Theta1_nonbiased)) +  sum(sum(Theta2_nonbiased .* Theta2_nonbiased));
J = sum(sum(J, 1)) / m + lambda * regularization / (2 * m);




a_1 = 0;
hidden = 0;
delta_3 = 0;
delta_2 = 0;
delta_sum_1 = 0;
delta_sum_2 = 0;
for t=1:m
	a_1 = [1, X(t, :)];
	hidden = [1, sigmoid(a_1 * Theta1')];
	prediction = sigmoid(hidden * Theta2');
	y_unrolled = outrange == y(t);
	delta_3 = prediction - y_unrolled;
	delta_2 = delta_3 * Theta2 .* [1, sigmoidGradient(a_1 * Theta1')];
	delta_2 = delta_2(2:end);
	Theta1_grad += delta_2' * a_1;
	Theta2_grad += delta_3' * hidden;
end

Theta1_grad /= m;
Theta2_grad /= m;
Theta1_grad(:, 2:end) += lambda * Theta1(:, 2:end) / m;
Theta2_grad(:, 2:end) += lambda * Theta2(:, 2:end) / m;






% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
