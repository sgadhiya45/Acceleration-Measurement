x = load('LOG00267.txt');
calib_1 = 2793;
calib_2 = 8641;
s_trip = x(180:806);
k0 = 9.81/(calib_2 - calib_1);
k1 = -calib_1 * k0;
acc = k0 * x(265:415,1) + k1;
ds_trip = k0 * x(180:806) + k1;
ds_trip_g = ds_trip - 9.81;
acc = acc - 9.81 ;
dtvel = acc * 0.1;
vel = cumsum(dtvel);

%%%er = transpose (linspace (0,-0.1,150)) ;
%vel_corrected = vel(1:150,1) - er;
%dtdist = vel_corrected*0.1;
%dist = cumsum(dtdist);
%time1 = linspace(0,150*.1,150);
% Check the size of vel to understand its dimensions
disp(size(vel));

% Ensure vel has enough elements before accessing vel(1:150,1)
if numel(vel) >= 150
    er = transpose(linspace(0, -0.1, 150));
    
    % Correct vel_corrected calculation to match dimensions
    vel_corrected = vel(1:150) - er;
    
    dtdist = vel_corrected * 0.1;
    dist = cumsum(dtdist);
    time1 = linspace(0, 150 * 0.1, 150);

    % Plotting code
    figure(1);
    plot(x);
    title('Acceleration Raw Data for All Trips');
    xlabel('Time(s)');
    ylabel('Raw data from acceleration Sensor');
    grid;

    % Other figure plotting codes go here...
    figure(2);
plot(acc);
title('Acceleration Data while travelling upwards');
xlabel('Time(s)');
ylabel('Acceleration(m/s^2)');
grid;

figure(3);
plot(vel);
hold on;
plot(vel_corrected);
line([0 151], [0 -0.105], 'Color', 'green');
hold off;
title('Velocity with drift, drift error, and corrected velocity graph for a single trip');
xlabel('Time(s)');
ylabel('Velocity(m/s)');

grid;

figure(4);
plot(dist);
title('Distance data measured by the acceleration sensor (Height of the floor) ');
xlabel('Time(s)');
ylabel('Distance(m)');
grid;

figure(5);
plot(acc);
hold on;
plot(vel_corrected);
hold on;
plot(dist);
hold off;
title('Comparision of Acceleration, Velociry and Distance');
xlabel('Time(s)');
ylabel('Acceleration(m/s^2), Velocity(m/s), Distance(m)');
grid;

figure(6);
plot(s_trip);
title('Acceleration Raw Data for All Trips');
xlabel('Time(s)');
ylabel('Acceleration(m/s^2)');
grid;

figure(7);
plot(ds_trip);
title('Acceleration Caliberated Data for a single trip');
xlabel('Time(s)');
ylabel('Acceleration(m/s^2)');
grid;

figure(8);
plot(ds_trip_g);
title('Acceleration Caliberated Data with 1g offset removed for a single trip');
xlabel('Time(s)');
ylabel('Acceleration(m/s^2)');
else
    disp("Error: vel does not have enough elements for vel(1:150)!");
end



