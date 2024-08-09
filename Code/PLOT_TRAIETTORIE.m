%% PLOT DELLE TRAIETTORIE

% Plot pe

tempo=time(1:end-1);

plotPe=figure();

subplot(3,1,1);   
hold on; grid on;
plot (tempo, pe(:,1));
xlabel('tempo[s]');ylabel('x');
title('End-Effector Position');

subplot(3,1,2);   
hold on; grid on;
plot (tempo, pe(:,2));
xlabel('tempo[s]');ylabel('y');

subplot(3,1,3);   
hold on;  grid on;
plot (tempo, pe(:,3));
xlabel('tempo[s]');ylabel('z');

      
% Plot dpe
plotPed=figure();

subplot(3,1,1);   
hold on; grid on;
plot (tempo, dpe(:,1));
xlabel('tempo[s]');ylabel('x');
title('End-Effector Velocity');

subplot(3,1,2);   
hold on; grid on;
plot (tempo, dpe(:,2));
xlabel('tempo[s]');ylabel('y');

subplot(3,1,3);   
hold on; grid on;
plot (tempo, dpe(:,3));
xlabel('tempo[s]');ylabel('z');

% Plot ddpe
% (la motivazione degli impulsi nell'accelerazione p.180 siciliano)
plotPedd=figure();

subplot(3,1,1);   
hold on; grid on;
plot (tempo, ddpe(:,1));
xlabel('tempo[s]');ylabel('x');
title('Accelerazione end-effector');

subplot(3,1,2);   
hold on; grid on;
plot (tempo, ddpe(:,2));
xlabel('tempo[s]');ylabel('y');

subplot(3,1,3);   
hold on; grid on;
plot (tempo, ddpe(:,3));
xlabel('tempo[s]');ylabel('z');


% Plot traiettoria

x_point = P(:,1);
y_point = P(:,2);
z_point = P(:,3);

x_trajectory = pe(:,1);
y_trajectory = pe(:,2);
z_trajectory = pe(:,3);

% 3D
plotTrj3D=figure();

plot3(x_point, y_point, z_point, 'om');
hold on;
plot3(x_trajectory, y_trajectory, z_trajectory, '-b');
title('Traiettoria 3D');
xlabel('x');ylabel('y');zlabel('z');
hold off; grid on;

plotTrj3D2=figure();

plot3(x_point, y_point, z_point, '--sg');
hold on;
plot3(x_trajectory, y_trajectory, z_trajectory, '-b');
title('Traiettoria 3D');
xlabel('x');ylabel('y');zlabel('z');
hold off; grid on;


% 2D
plotTrj2D=figure();

plot(x_point, y_point, 'om');
hold on;
plot(x_trajectory,y_trajectory);


title('Traiettoria 2D');
xlabel('x');ylabel('y');
hold off; grid on;grid on;

plotTrj2D2=figure();

plot(x_point, y_point, '--sg');
hold on;
stairs(x_trajectory,y_trajectory);


title('Traiettoria 2D');
xlabel('x');ylabel('y');
hold off; grid on;