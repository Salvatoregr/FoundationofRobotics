% ? MAIN
% • Lanciare in ordine : 
% - MODELLO_ROBOT
% - TRAIETTORIE
% - PLOT_TRAIETTORIE
% - file simulink : CLIK, CLIK_TRASPOSTO, CLIK_SECONDO_ORDINE
% Dopo aver fatto partire ogni file simulink CLIK posso fare i plot
% mediante PLOT_CLIK.m .
% - file simulink : CONTROLLO_ADATTATIVO , CONTROLLO_ROBUSTO.
% Dopo aver fatto partire il file simulink del controllo e aver cambiato il
% nome controllo nel file del plot ottengo i grafici specifici per quel
% controllo.

clear all; clc; close all;

%Questa porzione di codice è condizionata all'esecuzione degli script precedenti
MODELLO_ROBOT ;     %Definisco i dati del problema
TRAIETTORIE ;
PLOT_TRAIETTORIE ;


%sottraggo DELTA_t che sono i campioni che ho anticipato
orient_desiderato = zeros(T_new(size(T,1))-DELTA_t(size(P,1)),1);
posa_desiderata = [pe orient_desiderato; pe(end,:) orient_desiderato(end,:)];
posa_d_desiderata = [dpe orient_desiderato; dpe(end,:) orient_desiderato(end,:)];
posa_dd_desiderata = [ddpe orient_desiderato; ddpe(end,:) orient_desiderato(end,:)];

POSA = timeseries(posa_desiderata, time');
POSA_D = timeseries(posa_d_desiderata, time');
POSA_DD = timeseries(posa_dd_desiderata, time');

% Cinematica inversa relativa alle condizioni iniziali del manipolatore
c20 = (p0(1)^2+p0(2)^2-a1^2-a2^2)/(2*a1*a2);
s20 = sqrt(1-c20^2);

theta20 = atan2(s20,c20);

s10 = ((a1+a2*c20)*p0(2) - a2*s20*p0(1))/(p0(1)^2 + p0(2)^2);
c10 = ((a1+a2*c20)*p0(1) + a2*s20*p0(2))/(p0(1)^2 + p0(2)^2);

theta10 = atan2(s10,c10);

q0=[theta10; theta20; p0(3)-1; -theta10-theta20];


%CLICK_PINV

posa_desiderata_ridotta = [pe orient_desiderato; pe(end,:) orient_desiderato(end,:)];
posa_d_desiderata_ridotta = [dpe orient_desiderato; dpe(end,:) orient_desiderato(end,:)];

%rilasso x
posa_desiderata_ridotta(:,1)=[];
posa_d_desiderata_ridotta(:,1)=[];
%rilasso y
% posa_desiderata_ridotta(:,2)=[];
% posa_d_desiderata_ridotta(:,2)=[];
%rilasso z 
% posa_desiderata_ridotta(:,3)=[];
% posa_d_desiderata_ridotta(:,3)=[];
%rilasso fi
% posa_desiderata_ridotta(:,4)=[];
% posa_d_desiderata_ridotta(:,4)=[];

POSA_ridotta = timeseries(posa_desiderata_ridotta, time');
POSA_D_ridotta = timeseries(posa_d_desiderata_ridotta, time');


%CONTROLLO
adattativo;
% %calcola B che verrà poi copiata nel simulink, mentre la B cappello del
% %simulink è ottenuta da questa con qualche modifica ai parametri.
% 
% %Controllo Robusto
D = [zeros(4) eye(4)]';
Kp = diag([750 750 750 750]);
Kd = diag([50 50 50 50]);
H_tilde = [zeros(4) eye(4); -Kp  -Kd]; 
P_lyap = eye(8);
Q = lyap(H_tilde', P_lyap);



%Controllo adattativo

adattativo;
LAMBDA = 500*eye(4);
KD_ad = 500*eye(4);
Kpi = 1000*eye(16);
Kpi(13,13) = 0.02;
%Metto tutti 1 dove ho i parametri esatti e un numero molto piccolo dove ho
%il parametro incerto così che K_pigreco^-1 è grande e aggiorno
%Pi_greco_stimato solo per il parametro che non conosco con certezza.


MODELLO_ROBOT;
pi0 = double(subs(pigreco));