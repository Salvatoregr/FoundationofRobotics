%%Plot degli ellissodi tramite function

function [] = PLOT_ELLISSOIDE(robot, q, n)
figure;
subplot (1,2,1);
title ('Velocity manipulablity ellipsoid: ');
grid on;
robot.vellipse(q, '2d', 'r');
axis equal
J = robot.jacob0(q); %Jacobiano geometrico tenendo conto delle trasformazioni dovute dalla terna base all'end eff.
                     %jacob0 è una funzione del tool di Peter Cork
J_t = J(1:2,1:2);
w = sqrt(det(J_t*(J_t')));
disp(J_t)
disp(det(J_t*(J_t')))

fprintf('w = %.3f\n', w)
J = J(1:2,1:2);     %Prendo solo le prime due righe che corrispondo a teta 1 teta2 visto che sono loro a far
%muovere l'end effector nello spazio x-y e questi 
s = svd(J);
meas = s(end)/s(1);
fprintf("q%i index: %f \n",n,meas);

subplot (1,2,2);
title ('Force manipulablity ellipsoid: ');
grid on;
robot.fellipse(q, '2d', 'b');
axis equal

disp('Press any key to continue')
pause();
close all;

end