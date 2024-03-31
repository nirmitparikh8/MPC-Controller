function [E, F, G, constraintSlope, constraintIntercept] = computeObstacleConstraints(x, detection, obstacle, laneWidth, lanes)
% Compute custom constraints for the obstacle.

% Initialize ego car position
egoX = x(1);
egoY = x(2);

% Compute constraints only if an obstacle is detected. Otherwise, set
% constraint to lower road boundary (the inactive constraint).
if detection
    % Compute slope between ego car and safe zone corner
    slope = ((obstacle.rlSafeY - egoY) / (obstacle.rlSafeX - egoX));
    
    % If ego car is to the left of the obstacle
    if (egoX <= obstacle.rlSafeX)
        % If the ego car is already in the adjacent lane, use the safety
        % zone as the constraint.
        if (egoY > obstacle.rlSafeY)
            constraintSlope = 0;
            constraintIntercept = obstacle.rlSafeY;
        else
            % The ego car must be above the line formed from the ego car to
            % the safe zone corner for left passing.
            constraintSlope = tan(atan2(slope, 1));
            constraintIntercept = obstacle.rlSafeY - constraintSlope * obstacle.rlSafeX;
        end
    % If the ego car is parallel to the obstacle, use the safety zone as
    % the constraint.
    elseif ((egoX > obstacle.rlSafeX) && (egoX <= obstacle.flX))
        constraintSlope = 0;
        constraintIntercept = obstacle.rlSafeY; 
    % If the ego car has passed the obstacle, use the inactive constraint
    % to go back to the center lane.
    else 
        constraintSlope = 0;
        constraintIntercept = -laneWidth * lanes / 2;
    end
else
    % If no obstacle detected, use the lower road boundary as the constraint
    constraintSlope = 0;
    constraintIntercept = -laneWidth * lanes / 2;
end

% Define constraint matrices.
E = [0 0; 0 0; 0 0]; % Empty matrix
F = [0 1 0 0; 0 -1 0 0; constraintSlope -1 0 0]; % Constraint matrix for velocity and steering
G = [laneWidth * lanes / 2; laneWidth * lanes / 2; -1 * constraintIntercept]; % Constraint matrix for position
