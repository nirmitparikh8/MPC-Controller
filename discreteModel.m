function [Ad, Bd, Cd, Dd, U, Y, X, DX] = discreteModel(Ts, x, u)

% Define continuous-time linear model from Jacobian of the nonlinear model.
carLength = 5;  % Length of the car
theta = x(3);   % Heading angle of the car
V = x(4);       % Speed of the car
delta = u(2);   % Steering angle change

% Continuous-time state-space matrices
Ac = [0, 0, -V * sin(theta), cos(theta);
      0, 0, V * cos(theta), sin(theta);
      0, 0, 0, tan(delta) / carLength;
      0, 0, 0, 0];
Bc = [0, 0;
      0, 0;
      0, (V * (tan(delta)^2 + 1)) / carLength;
      0.5, 0];
Cc = eye(4);  % Output matrix
Dc = zeros(4, 2);  % Feedthrough matrix

% Generate discrete-time model using zero-order hold (ZOH)
[Ad, Bd] = adasblocks_utilDicretizeModel(Ac, Bc, Ts);

% Discrete-time state-space matrices
Cd = Cc;
Dd = Dc;

% Nominal conditions for discrete-time plant
X = x;  % Initial state
U = u;  % Input
Y = x;  % Initial output (same as initial state)
DX = Ad * x + Bd * u - x;  % State change

