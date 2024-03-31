function [xdot, y] = continuousModel(x, u)

carLength = 5;  % Length of the car
theta = x(3);   % Heading angle of the car
V = x(4);       % Speed of the car
delta = u(2);   % Steering angle change

% Define the state-space matrices
A = [0, 0, -V * sin(theta), cos(theta);
     0, 0, V * cos(theta), sin(theta);
     0, 0, 0, tan(delta) / carLength;
     0, 0, 0, 0];
B = [0, 0;
     0, 0;
     0, (V * (tan(delta)^2 + 1)) / carLength;
     0.5, 0];
C = eye(4);     % Output matrix
D = zeros(4, 2);  % Feedthrough matrix

% Compute the derivative of the state vector
xdot = A * x + B * u;

% Compute the output of the system
y = C * x + D * u;
