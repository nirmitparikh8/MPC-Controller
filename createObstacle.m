function obstacle = createObstacle(obstacle)
% Generate obstacle and safe zone geometry.

% Compute coordinates for the corners of the obstacle

% Front left corner
obstacle.flX = obstacle.X + obstacle.Length / 2;
obstacle.flY = obstacle.Y + obstacle.Width / 2;

% Front right corner
obstacle.frX = obstacle.X + obstacle.Length / 2;
obstacle.frY = obstacle.Y - obstacle.Width / 2;

% Rear left corner
obstacle.rlX = obstacle.X - obstacle.Length / 2;
obstacle.rlY = obstacle.flY;

% Rear right corner
obstacle.rrX = obstacle.X - obstacle.Length / 2;
obstacle.rrY = obstacle.frY;

% Compute coordinates for the corners of the safe zone

% Front left corner of safe zone
obstacle.flSafeX = obstacle.X + obstacle.safeDistanceX; 
obstacle.flSafeY = obstacle.Y + obstacle.safeDistanceY;

% Front right corner of safe zone
obstacle.frSafeX = obstacle.X + obstacle.safeDistanceX;
obstacle.frSafeY = obstacle.Y - obstacle.safeDistanceY;

% Rear left corner of safe zone
obstacle.rlSafeX = obstacle.X - obstacle.safeDistanceX; 
obstacle.rlSafeY = obstacle.flSafeY;

% Rear right corner of safe zone
obstacle.rrSafeX = obstacle.X - obstacle.safeDistanceX;
obstacle.rrSafeY = obstacle.frSafeY;
