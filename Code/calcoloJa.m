function x = calcoloJa(q)

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



L1 = Revolute('d', d1, 'a', a1, 'alpha', alpha1);
L2 = Revolute('d', d1, 'a', a2, 'alpha', alpha2);
L3 = Prismatic('theta', d1, 'a', a3, 'alpha', alpha3);
L3.qlim = [0 1];
L4 = Revolute('d', d1, 'a', a4, 'alpha', alpha4);
SCARA = SerialLink ([L1, L2, L3, L4], 'name', 'SCARA');
SCARA.base = transl(0, 0, 1);
SCARA.tool = rpy2tr([pi/2 0 0],'xyz');

y=SCARA.jacob0(q,'eul');
end