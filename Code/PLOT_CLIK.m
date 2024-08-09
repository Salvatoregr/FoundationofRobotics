% • Plot grafici CLIK

time = 0:0.001:(size(xd_click.Data,1)-1)*0.001;
LineWidth = 1.2;
FontSize = 15;

% x_d - x_e
click_err = figure('Position', get(0, 'Screensize'));
subplot(2,1,1);
plot(time,xd_click.Data(:,1:3) - xe_click.Data(:,1:3),'LineWidth',LineWidth);
title('Position Error in the Operational Space');
ylabel('Position Error [m]');xlabel('time [s]');
legend('$x_d(t) - x_e(t)$','$y_d(t) - y_e(t)$','$z_d(t) - z_e(t)$','Interpreter','latex','FontSize',FontSize);
grid on

subplot(2,1,2);
plot(time,xd_click.Data(:,3) - xe_click.Data(:,3),'LineWidth',LineWidth);
title('Orientation Error in th Operational Space');
ylabel('Orientation Error  [rad]');xlabel('time [s]');
legend('$\theta_d(t) - \theta_e(t)$','Interpreter','latex','FontSize',FontSize);
grid on

% norma( x_d - x_e )
click_norm_err = figure('Position', get(0, 'Screensize')); 
plot(norma_error_p_click,'LineWidth',LineWidth);
title('Norm of the trajectory error in the Operational Space');
ylabel('Position Error [m] and Orientation  [rad]');xlabel('time [s]');
legend('$\|\textbf{p}_d(t) - \textbf{p}_e(t)\|$','Interpreter','latex','FontSize',FontSize);
grid on


% q, dq
click_q_dq = figure('Position', get(0, 'Screensize')); 
subplot(2,1,1);
plot(q_click,'LineWidth',LineWidth);
title('Position in the Joint Space');
ylabel('$\textbf{q}(t)$ [rad]','Interpreter','latex');xlabel('$t \:\: [s]$','Interpreter','latex');
legend('$q_1(t)$','$q_2(t)$','$q_3(t)$','$q_4(t)$','Interpreter','latex','FontSize',FontSize);
grid on

subplot(2,1,2); 
plot(dq_click,'LineWidth',LineWidth);
title('Velocity in the Joint Space');
ylabel('$\dot{\textbf{q}}(t)$ [rad/s]','Interpreter','latex');xlabel('$t \:\: [s]$','Interpreter','latex');
legend('$\dot{q}_1(t)$','$\dot{q}_2(t)$','$\dot{q}_3(t)$','$\dot{q}_4(t)$','Interpreter','latex','FontSize',FontSize);
grid on

name_CLIK = 'sec_ord';

saveas(click_norm_err,strcat('click_',name_CLIK,'_norm_err'),'png');
saveas(click_err,strcat('click_',name_CLIK,'_err'),'png');