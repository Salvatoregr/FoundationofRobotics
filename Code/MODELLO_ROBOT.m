%% Modello del Robot

l1 = 0.25;
l2 = 0.25;
ml1 = 20;   %Massa dal giunto 1 al giunto 2 (non si considera quello della base)
ml2 = ml1;
ml3 = 10;
ml4 = 0; 
ml = [ml1 ml2 ml3 ml4];

Il1 = 4;
Il2 = Il1;
Il3 = 0;
Il4 = 1;
Il = [Il1 Il2 Il3 Il4];

mm = zeros(1,4);

%Costanti di trasmissione meccanica 
kr1 = 1;
kr2 = kr1;
kr3 = 50;
kr4 = 20;
kr = [kr1 kr2 kr4 kr4];

Im1 = 0.01;
Im2 = Im1;
Im3 = 0.005;
Im4 = 0.001;
Im = [Im1 Im2 Im3 Im4];

Fm1= 0.00005;
Fm2 = Fm1;
Fm3 = 0.01;
Fm4 = 0.005;
Fm = [Fm1 Fm2 Fm3 Fm4];


param_esatti (1) = ml1;
param_esatti (2) = Il1;
param_esatti (3) = Im1;
param_esatti (4) = Fm1;

param_esatti (5) = ml2;
param_esatti (6) = Il2;
param_esatti (7) = Im2;
param_esatti (8) = Fm2;

param_esatti (9) = ml3;
param_esatti (10) = Il3;
param_esatti (11) = Im3;
param_esatti (12) = Fm3;

param_esatti (13) = ml4;   
param_esatti (14) = Il4;
param_esatti (15) = Im4;
param_esatti (16) = Fm4;

theta1 = 0;
theta2 = 0;
theta3 = 0;
theta4 = 0;

d0 = 1;
d1 = 0;
d2 = 0;
d3 = 0;
d4 = 0;

alpha1 = 0;
alpha2 = pi;
alpha3 = 0;
alpha4 = 0;

a1 = 0.5;
a2 = 0.5;
a3 = 0;
a4 = 0;


q = [0 0 0 0]';


L1 = Revolute('d', d1, 'a', a1, 'alpha', alpha1);
L2 = Revolute('d', d1, 'a', a2, 'alpha', alpha2);
L3 = Prismatic('theta', d1, 'a', a3, 'alpha', alpha3);
L3.qlim = [0 1];
L4 = Revolute('d', d1, 'a', a4, 'alpha', alpha4);
SCARA = SerialLink ([L1, L2, L3, L4], 'name', 'SCARA');
SCARA.base = transl(0, 0, 1);
SCARA.tool = rpy2tr([pi/2 0 0],'xyz');

%SCARA.plot([0 0 0 0], 'workspace', [-3 11 -11 11 0 10]);
%SCARA.teach