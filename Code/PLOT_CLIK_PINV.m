% • PLOT CLIK PSEUDOINVERSA

time = 0:0.001:(size(xd_click.Data,1)-1)*0.001;
LineWidth = 1.2;
FontSize = 15;

% x_d - x_e
click_err = figure('Position', get(0, 'Screensize'));
subplot(2,1,1);
plot(time,xd_click.Data(:,1:2) - xe_click.Data(:,1:2),'LineWidth',LineWidth);
title('Errore posizione spazio operativo');
ylabel('Errore posizione [m]');xlabel('time [s]');
legend('$y_d(t) - y_e(t)$','$z_d(t) - z_e(t)$','Interpreter','latex','FontSize',FontSize);
grid on

subplot(2,1,2);
plot(time,xd_click.Data(:,3) - xe_click.Data(:,3),'LineWidth',LineWidth);
title('Errore orientamento spazio operativo');
ylabel('Errore orientamento [rad]');xlabel('time [s]');
legend('$\theta_d(t) - \theta_e(t)$','Interpreter','latex','FontSize',FontSize);
grid on

% norma( x_d - x_e )
click_norm_err = figure('Position', get(0, 'Screensize')); 
plot(norma_error_p_click,'LineWidth',LineWidth);
title('Norma errore traiettoria spazio operativo');
ylabel('Errore posizione [m] ed orientamento  [rad]');xlabel('time [s]');
legend('$\|\textbf{p}_d(t) - \textbf{p}_e(t)\|$','Interpreter','latex','FontSize',FontSize);
grid on

% q, dq
click_q_dq = figure('Position', get(0, 'Screensize')); 
subplot(2,1,1);
plot(q_click,'LineWidth',LineWidth);
title('Posizione spazio dei giunti');
ylabel('$\textbf{q}(t)$ [rad]','Interpreter','latex');xlabel('t [s]');
legend('$q_1(t)$','$q_2(t)$','$q_3(t)$','$q_4(t)$','Interpreter','latex','FontSize',FontSize);
grid on

subplot(2,1,2); 
plot(dq_click,'LineWidth',LineWidth);
title('Velocità spazio dei giunti');
ylabel('$\dot{\textbf{q}}(t)$ [rad/s]','Interpreter','latex');xlabel('t [s]');
legend('$q_1(t)$','$q_2(t)$','$q_3(t)$','$q_4(t)$','Interpreter','latex','FontSize',FontSize);
grid on


saveas(click_norm_err,'click_norm_err','png');
saveas(click_err,'click_err','png');


% w(q)
click_W = figure('Position', get(0, 'Screensize')); 

subplot(2,1,1);
plot(w_CLIK,'LineWidth',LineWidth);
grid on; hold on;
plot([0 w_CLIK.length/1000],w_CLIK.median*ones(1,2), '-');
title('Misura di manipolabilità CLICK con inversa dello Jacobiano');
ylabel('$w(\textbf{q}(t))$','Interpreter','latex');xlabel('$t \:\: [s]$','Interpreter','latex');


subplot(2,1,2); 
plot(w_PINV,'LineWidth',LineWidth);
grid on; hold on;
plot([0 w_PINV.length/1000],w_PINV.median*ones(1,2), '-');
title('Misura di manipolabilità CLICK con pseudo-inversa dello Jacobiano');
ylabel('$w(\textbf{q}(t))$','Interpreter','latex');xlabel('$t \:\: [s]$','Interpreter','latex');


saveas(click_W,'click_W','png');