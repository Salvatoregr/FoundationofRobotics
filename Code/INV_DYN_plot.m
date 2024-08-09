%  PLOT CONTROLLO OPERATIVO INVERSE DYNAMICS
close all;
%name_contr = 'robust';
%name_contr = 'adaptative';
name_contr = 'inversedynamics';

time = out.torque.time;
LineWidth = 1.2;
FontSize = 15;

%% Coppia
figure(1)
subplot(2,1,1);
hold on
plot(out.torque.time,out.torque.signals.values(1,:));
plot(out.torque.time,out.torque.signals.values(2,:));
plot(out.torque.time,out.torque.signals.values(4,:));
hold off
title('Coppie ai giunti rotoidali');
ylabel('coppie ai giunti rotoidali','Interpreter','latex');xlabel('$t \:\: [s]$','Interpreter','latex');
legend('$\tau_1(t)$','$\tau_2(t)$','$\tau_4(t)$','Interpreter','latex','FontSize',FontSize);
grid on

subplot(2,1,2);
plot(out.torque.time,out.torque.signals.values(3,:));
title('Coppie ai giunti prismatici');
ylabel('coppie ai giunti prismatici','Interpreter','latex');xlabel('$t \:\: [s]$','Interpreter','latex');
legend('$\tau_3(t)$','Interpreter','latex','FontSize',FontSize);
grid on


%% Posizione, Velocità e Accelerazione dei Giunti
figure(2)
subplot(3,1,1);
hold on
plot(time,out.q.signals.values(:,1));
plot(time,out.q.signals.values(:,2));
plot(time,out.q.signals.values(:,3));
plot(time,out.q.signals.values(:,4));
title('Positions in Joint Space');
ylabel('$\textbf{q}(t)$ [rad]','Interpreter','latex');xlabel('$t \:\: [s]$','Interpreter','latex');
legend('$q_1(t)$','$q_2(t)$','$q_3(t)$','$q_4(t)$','Interpreter','latex','FontSize',FontSize);
grid on

subplot(3,1,2);
hold on
plot(time,out.dq.signals.values(:,1));
plot(time,out.dq.signals.values(:,2));
plot(time,out.dq.signals.values(:,3));
plot(time,out.dq.signals.values(:,4));
title('Velocities in the Joint Space');
ylabel('$\dot{\textbf{q}}(t)$ [rad/s]','Interpreter','latex');xlabel('$t \:\: [s]$','Interpreter','latex');
legend('$\dot{q}_1(t)$','$\dot{q}_2(t)$','$\dot{q}_3(t)$','$\dot{q}_4(t)$','Interpreter','latex','FontSize',FontSize);
grid on

subplot(3,1,3);
hold on
plot(time,out.ddq.signals.values(:,1));
plot(time,out.ddq.signals.values(:,2));
plot(time,out.ddq.signals.values(:,3));
plot(time,out.ddq.signals.values(:,4));
title('Accelerazione spazio dei giunti');
ylabel('$\ddot{\textbf{q}}(t)$ [rad/s]','Interpreter','latex');xlabel('$t \:\: [s]$','Interpreter','latex');
legend('$\ddot{q}_1(t)$','$\ddot{q}_2(t)$','$\ddot{q}_3(t)$','$\ddot{q}_4(t)$','Interpreter','latex','FontSize',FontSize);
grid on

%% Errore Posizione e Orientamento
figure(3)
subplot(2,1,1);
hold on
plot(time,out.err_pos.signals.values(:,1));
plot(time,out.err_pos.signals.values(:,2));
plot(time,out.err_pos.signals.values(:,3));
title('Position Error in the Operational Space');
ylabel('Position Error [m]');xlabel('time [s]');
legend('$x_d(t) - x_e(t)$','$y_d(t) - y_e(t)$','$z_d(t) - z_e(t)$','Interpreter','latex','FontSize',FontSize);
grid on

subplot(2,1,2);
hold on
plot(time,out.err_pos.signals.values(:,4));
title('Orientation Error in the Operational Space');
ylabel('Orientation Error [rad]');xlabel('time [s]');
legend('$\theta_d(t) - \theta_e(t)$','Interpreter','latex','FontSize',FontSize);
grid on

%% Norma Errore
figure(4)
plot(time,out.norma_error_p_click.signals.values);
title('Norm of the trajectory error in the Operative Space');
ylabel('Errore posizione [m] ed orientamento[rad]');xlabel('time [s]');
legend('$\|\textbf{p}_d(t) - \textbf{p}_e(t)\|$','Interpreter','latex','FontSize',FontSize);
grid on
