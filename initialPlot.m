function f = initialPlot(x0, obstacle, laneWidth, lanes)
% Create figure
f = figure;

% Plot the Ego vehicle.
carLength = 5;
carWidth = 2;
X0 = x0(1);
Y0 = x0(2);
plot(X0, Y0, 'gx');  % Plot the initial position of the Ego vehicle
hold on; grid on;
% Draw a rectangle representing the Ego vehicle
rectangle('Position', [X0 - carLength/2, Y0 - carWidth/2, carLength, carWidth]);

% Plot the static obstacle.
plot(obstacle.X, obstacle.Y, 'rx');  % Plot the position of the obstacle
% Draw a rectangle representing the obstacle
rectangle('Position', [obstacle.rrX, obstacle.rrY, obstacle.Length, obstacle.Width]);

% Plot the safe zone around the obstacle.
rectangle('Position', [obstacle.rrSafeX, obstacle.rrSafeY, ...
    (obstacle.safeDistanceX) * 2, (obstacle.safeDistanceY) * 2], ...
    'LineStyle', '--', 'EdgeColor', 'r');

% Plot the lanes.
% Plotting two horizontal dashed lines representing the lanes
X = [0; 50; 100];
Y = [2; 2; 2];
line(X, Y, 'LineStyle', '--', 'Color', 'b');
X = [0; 50; 100];
Y = [-2; -2; -2];
line(X, Y, 'LineStyle', '--', 'Color', 'b');

% Reset the axis to show the entire scene.
axis([0 100 -laneWidth * lanes / 2 laneWidth * lanes / 2]);
xlabel('X');
ylabel('Y');
title('Obstacle Avoidance Maneuver');
