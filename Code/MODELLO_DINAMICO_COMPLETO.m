% • MODELLO DINAMICO COMPLETO DEL MANIPOLATORE

syms q_1 q_2 q_3 q_4 real;
sym q_sym real;
q_sym = [q_1 q_2 q_3 q_4]';

syms qd_1 qd_2 qd_3 qd_4 real;
sym qd_sym real;
qd_sym = [qd_1 qd_2 qd_3 qd_4]';

syms qdd_1 qdd_2 qdd_3 qdd_4 real;
sym qdd_sym real;
qdd_sym = [qdd_1 qdd_2 qdd_3 qdd_4]';

%l'ultimo indice è il num. link ha tre righe poichè va in R^3, quattro colonne poichè ha quattro giunti
Jpl = sym('j_%d_', [3, 4, 4], 'real'); 
Jol = sym('j_%d_', [3, 4, 4], 'real');
Jpm = sym('j_%d_', [3, 4, 4], 'real');
Jom = sym('j_%d_', [3, 4, 4], 'real');

syms B C Fv mm real;

B = zeros(4, 4, 'sym');
C = zeros(4, 4, 'sym');
Fv = zeros(1, 4, 'sym');
mm = zeros (1, 4, 'sym');

syms ml [1 4] real;
syms Il [1 4] real;
syms Im [1 4] real;
syms Fm [1 4] real;

pigreco (1) = ml1;
pigreco (2) = Il1;
pigreco (3) = Im1;
pigreco (4) = Fm1;

pigreco (5) = ml2;
pigreco (6) = Il2;
pigreco (7) = Im2;
pigreco (8) = Fm2;

pigreco (9) = ml3;
pigreco (10) = Il3;
pigreco (11) = Im3;
pigreco (12) = Fm3;

pigreco (13) = ml4;
pigreco (14) = Il4;
pigreco (15) = Im4;
pigreco (16) = Fm4;


% Calcolo Jpl
Jpl1 = [-l1*sin(q_1) 0 0 0;
         l1*cos(q_1) 0 0 0;
              0      0 0 0];
           
Jpl2 = [-a1*sin(q_1)-l2*sin(q_1+q_2)  -l2*sin(q_1+q_2)  0  0;
         a1*cos(q_1)+l2*cos(q_1+q_2)   l2*cos(q_1+q_2)  0  0;
                   0                     0              0  0];

Jpl3= [-a1*sin(q_1)-a2*sin(q_1+q_2)  -a2*sin(q_1+q_2)  0  0;
         a1*cos(q_1)+a2*cos(q_1+q_2)   a2*cos(q_1+q_2)  0  0;
         0                                   0          1   0];

Jpl4 = [-a1*sin(q_1)-a2*sin(q_1+q_2)  -a2*sin(q_1+q_2)  0  0;
         a1*cos(q_1)+a2*cos(q_1+q_2)   a2*cos(q_1+q_2)  0  0;
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

Jpm2 = [ -a1*sin(q_1)  0  0  0;
          a1*cos(q_1)  0  0  0;
               0       0  0  0];
            
Jpm3 = [ -a1*sin(q_1)-a2*sin(q_1+q_2)  -a2*sin(q_1+q_2)  0  0;
          a1*cos(q_1)+a2*cos(q_1+q_2)  a2*cos(q_1+q_2)  0  0;
                        0                     0             0  0];
                   
Jpm4 = [ -a1*sin(q_1)-a2*sin(q_1+q_2)  -a2*sin(q_1+q_2)  0  0;
          a1*cos(q_1)+a2*cos(q_1+q_2)  a2*cos(q_1+q_2)  0  0;
                        0                   0               1  0];

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
            
            cijk = 0.5*( diff(B(i,j),q_sym(k)) + diff(B(i,k),q_sym(j)) - diff(B(j,k),q_sym(i)));
            C(i,j) = C(i,j) + cijk*qd_sym(k);
            
        end
    end
end
C = simplify (C);


% Calcolo Fv  (formula 8.21)
  for i= 1:4
      Fv(i)=Fm(i)*(kr(i))^2;
  end
Fv = diag(Fv);


% Calcolo g
g = [0  0  9.81*(ml3+ml4)  0]';

% tau
tau = B*qdd_sym + C*qd_sym + Fv*qd_sym + g;
tau = simplify(tau);

% Forza
F = Fv; % approssimazione perché non abbiamo gli altri termini  (8.8)

% n
n = C*qd_sym + Fv*qd_sym + g;
n = simplify(n);

% Calcolo Y (MATRICE REGRESSORE)

syms Y real;
id = eye(length(pigreco), 'sym');   % Matrice identità

for j = 1:length(tau)
    for i = 1:length(pigreco)
        a = subs(tau(j), pigreco, id(i, :)); 
        % a = subs (s , old , new ) --->  dove s= s(old) ; 
        
        % Alla fine della sostituzione farà a=s* che è la s modificata da
        % susb praticamente. 
        
        % Pongo ad 1 solo il valore del parametro corrispondente alla
        % colonna di Y considerata.
        
        Y(j,i) = a;
    end
end
simplify(Y);