function detection = detectObstacles(x, obstacle, laneWidth)
% Detect when the vehicle sees an obstacle.

% Initialize ego car position
egoX = x(1);
egoY = x(2);

% Compute distance to the obstacle
dist2Obstacle = sqrt((obstacle.X - egoX)^2 + (obstacle.Y - egoY)^2);

% Check if the distance to the obstacle is less than the detection distance
flagCloseEnough = (dist2Obstacle < obstacle.DetectionDistance);

% Check if the ego car is within the same lane as the obstacle
flagInLane = (abs(obstacle.Y - egoY) < 2 * laneWidth);

% Determine if the vehicle detects the obstacle
detection = (flagCloseEnough && (egoX < obstacle.frSafeX) && flagInLane);
