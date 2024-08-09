 %%Ellissoidi di forza e velocità

q_test1 = [0      -pi/2          0.3  0];
q_test2 = [0      pi*5/4           0.3  0];
q_test3 = [0      pi*1/30        0.3  0];    %Vicino alla singolarità 0° [Tutto steso]
q_test4 = [0      pi*98/100      0.3  0];
q_test5 = [0      pi*99.99/100    0.3  0];   % Vicino alla singolarità 180° [Tutto piegato su sè stesso]

PLOT_ELLISSOIDE(SCARA, q_test1,1);

PLOT_ELLISSOIDE(SCARA, q_test2,2);

PLOT_ELLISSOIDE(SCARA, q_test3,3);

PLOT_ELLISSOIDE(SCARA, q_test4,5);

PLOT_ELLISSOIDE(SCARA, q_test5,6);