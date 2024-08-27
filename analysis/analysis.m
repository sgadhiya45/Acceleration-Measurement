% Created: Aug. 2022, Sumit Gadhiya

% Load the acceleration data from the text file
data = load('LOG00223.txt');

% Calibration values for the sensor
calib_1 = 2793;  % Lower calibration bound
calib_2 = 8641;  % Upper calibration bound

% Extract a specific trip segment from the data (from index 180 to 806)
trip_segment = data(180:806);

% Calculate the scale factor (k0) and offset (k1) for converting raw data to acceleration
k0 = 9.81 / (calib_2 - calib_1);  % Scale factor to convert to m/s^2
k1 = -calib_1 * k0;  % Offset for zero calibration

% Calculate acceleration during a specific time segment
acceleration = k0 * data(265:415, 1) + k1;

% Apply the same calibration to the entire trip segment
calibrated_trip = k0 * data(180:806) + k1;

% Adjust the calibrated data to remove the 1g (gravity) offset
calibrated_trip_g = calibrated_trip - 9.81;

% Remove gravity from the calculated acceleration
acceleration = acceleration - 9.81;

% Integrate acceleration to calculate velocity (assuming a sample time of 0.1s)
dt_vel = acceleration * 0.1;
velocity = cumsum(dt_vel);  % Cumulative sum to integrate

% Check the size of the velocity vector
disp(size(velocity));

% Ensure there are enough data points before proceeding with drift correction
if numel(velocity) >= 150
    % Create a linear error vector to correct drift in the first 150 data points
    drift_error = transpose(linspace(0, -0.1, 150));
    
    % Apply drift correction to the velocity
    velocity_corrected = velocity(1:150) - drift_error;
    
    % Integrate corrected velocity to calculate distance
    dt_distance = velocity_corrected * 0.1;
    distance = cumsum(dt_distance);
    
    % Create a time vector for plotting (assuming 0.1s sample time)
    time_vector = linspace(0, 150 * 0.1, 150);

    % Plot raw acceleration data for all trips
    figure(1);
    plot(data);
    title('Acceleration Raw Data for All Trips');
    xlabel('Time (s)');
    ylabel('Raw Data from Acceleration Sensor');
    grid on;

    % Plot calibrated acceleration data during upward travel
    figure(2);
    plot(acceleration);
    title('Acceleration Data During Upward Travel');
    xlabel('Time (s)');
    ylabel('Acceleration (m/s^2)');
    grid on;

    % Plot velocity and corrected velocity with drift error
    figure(3);
    plot(velocity);
    hold on;
    plot(velocity_corrected);
    line([0, 151], [0, -0.105], 'Color', 'green');
    hold off;
    title('Velocity with Drift, Drift Error, and Corrected Velocity for a Single Trip');
    xlabel('Time (s)');
    ylabel('Velocity (m/s)');
    grid on;

    % Plot calculated distance based on corrected velocity
    figure(4);
    plot(distance);
    title('Distance Measured by Acceleration Sensor (Height of the Floor)');
    xlabel('Time (s)');
    ylabel('Distance (m)');
    grid on;

    % Comparison plot: Acceleration, Corrected Velocity, and Distance
    figure(5);
    plot(acceleration);
    hold on;
    plot(velocity_corrected);
    plot(distance);
    hold off;
    title('Comparison of Acceleration, Velocity, and Distance');
    xlabel('Time (s)');
    ylabel('Acceleration (m/s^2), Velocity (m/s), Distance (m)');
    grid on;

    % Plot raw acceleration data for the specific trip segment
    figure(6);
    plot(trip_segment);
    title('Acceleration Raw Data for Specific Trip Segment');
    xlabel('Time (s)');
    ylabel('Acceleration (m/s^2)');
    grid on;

    % Plot calibrated acceleration data for the specific trip
    figure(7);
    plot(calibrated_trip);
    title('Calibrated Acceleration Data for Specific Trip');
    xlabel('Time (s)');
    ylabel('Acceleration (m/s^2)');
    grid on;

    % Plot calibrated acceleration data with 1g offset removed
    figure(8);
    plot(calibrated_trip_g);
    title('Calibrated Acceleration Data with 1g Offset Removed for Specific Trip');
    xlabel('Time (s)');
    ylabel('Acceleration (m/s^2)');
    grid on;

else
    % Display an error message if the velocity data is insufficient
    disp("Error: 'velocity' does not have enough elements for vel(1:150)!");
end
