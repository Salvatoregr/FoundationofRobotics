% • MODELLO DINAMICO DEL MANIPOLATORE

syms q_1 q_2 q_3 q_4 real;
sym q_sym real;
q_sym = [q_1 q_2 q_3 q_4]';

syms qd_sym [4 1] real;
%temporaneo!!!!!!
% qd_sym = ones(4,1, 'sym');

syms qdd_sym [4 1] real;
%temporaneo!!!!!!
% qdd_sym = ones(4,1, 'sym');

Jpl = sym('j_%d_', [3, 4, 4], 'real');
Jol = sym('j_%d_', [3, 4, 4], 'real');
Jpm = sym('j_%d_', [3, 4, 4], 'real');
Jom = sym('j_%d_', [3, 4, 4], 'real');

syms B C cijk real;

B = zeros(4, 4, 'sym');
C = zeros(4, 4, 'sym');


% Calcolo Jpl
Jpl1 = [-1*l1*sin(q_1) 0 0 0;
           l1*cos(q_1) 0 0 0;
               0      0 0 0];
           
Jpl2 = [-1*a1*sin(q_1)-l2*sin(q_1+q_2)  -1*l2*sin(q_1+q_2)  0  0;
           a1*cos(q_1)+l2*cos(q_1+q_2)     l2*cos(q_1+q_2)  0  0;
                   0                         0              0  0];

Jpl3 = zeros(3,4, 'sym');

Jpl4 = [-1*a1*sin(q_1)-a2*sin(q_1+q_2)  -1*a2*sin(q_1+q_2)  0  0;
           a1*cos(q_1)+a2*cos(q_1+q_2)     a2*cos(q_1+q_2)  0  0;
                   0                         0              1  0];
     

       
Jpl(:,:,1) = Jpl1;
Jpl(:,:,2) = Jpl2;
Jpl(:,:,3) = Jpl3;
Jpl(:,:,4) = Jpl4;


% Calcolo Jol
Jol1 = zeros(3, 4, 'sym'); Jol1(end,1)=1;
Jol2 = Jol1; Jol2(end,2)=1;
Jol3 = zeros(3, 4, 'sym');
Jol4 = Jol2; Jol4(end,4)=1;

Jol(:,:,1) = Jol1;
Jol(:,:,2) = Jol2;
Jol(:,:,3) = Jol3;
Jol(:,:,4) = Jol4;


% Calcolo Jpm
Jpm1 = zeros(3, 4, 'sym');

Jpm2 = [ -1*a1*sin(q_1)  0  0  0;
            a1*cos(q_1)  0  0  0;
                0       0  0  0];
            
Jpm3 = [ -1*a1*sin(q_1) - a2*sin(q_1+q_2)  0  0  0;
            a1*cos(q_1) + a2*cos(q_1+q_2)  0  0  0;
                       0                0  0  0];
                   
Jpm4 = [ -1*a1*sin(q_1) - a2*sin(q_1+q_2)  0  0  0;
            a1*cos(q_1) + a2*cos(q_1+q_2)  0  0  0;
                       0                0  1  0];

Jpm(:,:,1) = Jpm1;
Jpm(:,:,2) = Jpm2;
Jpm(:,:,3) = Jpm3;
Jpm(:,:,4) = Jpm4;


% Calcolo Jom
Jom1 = zeros(3, 4, 'sym'); Jom1(end,:) = [kr1 0 0 0];
Jom2 = zeros(3, 4, 'sym'); Jom2(end,:) = [1 kr2 0 0];
Jom3 = zeros(3, 4, 'sym'); Jom3(end,:) = [1 1 kr3 0];
Jom4 = zeros(3, 4, 'sym'); Jom4(end,:) = [1 1 0 kr4];

Jom(:,:,1) = Jom1;
Jom(:,:,2) = Jom2;
Jom(:,:,3) = Jom3;
Jom(:,:,4) = Jom4;


% Calcolo B
for i = 1:4
   
    B = B + (ml(i) * Jpl(:,:,i)' * Jpl(:,:,i)) ...
          + (Jol(:,:,i)' * Il(i) * Jol(:,:,i)) ...
          + (mm(i) * Jpm(:,:,i)' * Jpm(:,:,i)) ...
          + (Jom(:,:,i)' * Im(i) * Jom(:,:,i));
    
end
B = simplify(B);


% Calcolo C
for i= 1:4
    for j= 1:4
        for k= 1:4
            
            cijk = 0.5 * ( diff(B(i,j),q_sym(k)) + diff(B(i,k),q_sym(j)) - diff(B(j,k),q_sym(i)));
            C(i,j) = C(i,j) + cijk*qd_sym(k); %sommatoria su k
            
        end
    end
end
C = simplify (C);


% Calcolo Fv : Fv = diag(Fm);
  for i= 1:4
      Fv(i)=Fm(i)*(kr(i))^2;
  end
Fv = diag(Fv);

% Calcolo g
g = [0  0  9.81*(ml(4))  0]';

% tau
tau = B*qdd_sym + C*qd_sym + Fv*qd_sym + g;
tau = simplify(tau);

% n
n = C*qd_sym + Fv*qd_sym + g;
n = simplify(n);