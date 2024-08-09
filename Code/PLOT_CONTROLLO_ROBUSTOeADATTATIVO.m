% • PLOT CONTROLLO ROBUSTO e ADATTATIVO

close all;
%name_contr = 'robust';
name_contr = 'adaptative';

time = 0:0.001:(size(out.xd.Data,1)-1)*0.001;
LineWidth = 1.2;
FontSize = 15;


% x_d - x_e
err = figure('Position', get(0, 'Screensize'));
subplot(2,1,1);
plot(time,out.xd.Data(:,1:3) - out.xe.Data(:,1:3),'LineWidth',LineWidth);
title('Errore posizione spazio operativo');
ylabel('Errore posizione [m]');xlabel('time [s]');
legend('$x_d(t) - x_e(t)$','$y_d(t) - y_e(t)$','$z_d(t) - z_e(t)$','Interpreter','latex','FontSize',FontSize);
grid on

subplot(2,1,2);
plot(time,out.xd.Data(:,4) - out.xe.Data(:,4),'LineWidth',LineWidth);
title('Errore orientamento spazio operativo');
ylabel('Errore orientamento [rad]');xlabel('time [s]');
legend('$\theta_d(t) - \theta_e(t)$','Interpreter','latex','FontSize',FontSize);
grid on

% q, dq
q_dq_ddq = figure('Position', get(0, 'Screensize')); 
subplot(3,1,1);
plot(out.q,'LineWidth',LineWidth);
title('Posizione spazio dei giunti');
ylabel('$\textbf{q}(t)$ [rad]','Interpreter','latex');xlabel('$t \:\: [s]$','Interpreter','latex');
legend('$q_1(t)$','$q_2(t)$','$q_3(t)$','$q_4(t)$','Interpreter','latex','FontSize',FontSize);
grid on

subplot(3,1,2); 
plot(out.dq,'LineWidth',LineWidth);
title('Velocità spazio dei giunti');
ylabel('$\dot{\textbf{q}}(t)$ [rad/s]','Interpreter','latex');xlabel('$t \:\: [s]$','Interpreter','latex');
legend('$\dot{q}_1(t)$','$\dot{q}_2(t)$','$\dot{q}_3(t)$','$\dot{q}_4(t)$','Interpreter','latex','FontSize',FontSize);
grid on

subplot(3,1,3); 
plot(out.ddq,'LineWidth',LineWidth);
title('Accelerazione spazio dei giunti');
ylabel('$\ddot{\textbf{q}}(t)$ [rad/s]','Interpreter','latex');xlabel('$t \:\: [s]$','Interpreter','latex');
legend('$\ddot{q}_1(t)$','$\ddot{q}_2(t)$','$\ddot{q}_3(t)$','$\ddot{q}_4(t)$','Interpreter','latex','FontSize',FontSize);
grid on

% norma( x_d - x_e )
norm_err = figure('Position', get(0, 'Screensize')); 
plot(out.norm_error,'LineWidth',LineWidth);
%title('Norma errore traiettoria spazio operativo');
title('Norm of the trajectory error in the Operative Space');
ylabel('Errore posizione [m] ed orientamento[rad]');xlabel('time [s]');
legend('$\|\textbf{p}_d(t) - \textbf{p}_e(t)\|$','Interpreter','latex','FontSize',FontSize);
grid on

% coppia 
coppia = figure('Position', get(0, 'Screensize')); 
title('Coppie ai giunti azione di controllo');

subplot(2,1,1);
plot(time,out.torque.Data(:,1:2),'LineWidth',LineWidth);
hold on
plot(time,out.torque.Data(:,4),'LineWidth',LineWidth);
title('Coppie ai giunti rotoidali');
ylabel('coppie ai giunti rotoidali','Interpreter','latex');xlabel('$t \:\: [s]$','Interpreter','latex');
legend('$\tau_1(t)$','$\tau_2(t)$','$\tau_4(t)$','Interpreter','latex','FontSize',FontSize);
grid on

subplot(2,1,2);
plot(time,out.torque.Data(:,3),'LineWidth',LineWidth);
title('Coppie ai giunti prismatici');
ylabel('coppie ai giunti prismatici','Interpreter','latex');xlabel('$t \:\: [s]$','Interpreter','latex');
legend('$\tau_3(t)$','Interpreter','latex','FontSize',FontSize);
grid on

saveas(norm_err,strcat(name_contr,'_norm_err'),'png');
saveas(err,strcat(name_contr,'_err'),'png');
saveas(q_dq_ddq,strcat(name_contr,'_q_dq_ddq'),'png');
%saveas(coppia,strcat(name_contr,'_torque'),'png');