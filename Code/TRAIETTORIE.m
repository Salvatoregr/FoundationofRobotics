%% Definizione di traiettorie
% p0=[0.18 0.2 0.85];
% p1=[0.14 0.2 0.85];
% p2=[0.1 0.2 0.85];
% p3=[0.1 0.15 0.85];
% p4=[0.1 0.1 0.85];
% p5=[0.225 0.1 0.85];
% p6=[0.35 0.1 0.85];
% p7=[0.35 0.15 0.85];
% p8=[0.35 0.20 0.85];
% p9=[0.30 0.2 0.85];
% p10=[0.28 0.2 0.85];
% p11=[0.18 0.2 0.85];

p0=[0.18 0.4 0.5];
p1=[0.14 0.4 0.5];
p2=[0.1 0.4 0.2];
p3=[0.05 0.35 0.5];
p4=[0.1 0.3 0.5];
p5=[0.225 0.3 0.5];
p6=[0.35 0.3 0.5];
p7=[0.6 0.35 0.3];
p8=[0.35 0.40 0.5];
p9=[0.30 0.4 0.5];
p10=[0.28 0.4 0.5];
p11=[0.18 0.4 0.5];


%Posizioni traiettorie circolari
pos_C1 = 12;
c1=[0.23 0.4 0.5] ;
r1=0.05;

%T = [0 2 5 10 20 25 30 35 40 45 50 55]';               %arrival time
T = [0 5 10 15 20 25 30 35 40 45 50 70]';               %arrival time
P = [p0; p1; p2; p3; p4; p5; p6; p7; p8; p9; p10; p11]; %punti

%Valore iniziale
sic1 = r1*acos((P(11,1)-c1(1))/r1); 
sic1=real(sic1);
sfc1 = r1*acos((P(12,1)-c1(1))/r1);
sfc1=real(sfc1);


% Lo setto >0 se sono in corrispondenza di un punto di via
%(NB: delta_t(i)>0 -> P(i)-P(i-1) in anticipo <-> P(i-1) è un punto di via)
delta_t = [0 0 0 1500 2000 1500 0 0 1600  0 0 0 ];

% Generazione traiettoria (pag.186 Robotics, Siciliano)
samples_at_sec = 1000;
T_new = T * samples_at_sec;

% Calcolo DELTA_t
DELTA_t = zeros(size(P,1),1);
DELTA_t(1) = 0;
for j=2:1:size(P,1)
    DELTA_t(j) = DELTA_t(j-1) + delta_t(j);
end

% Calcolo s'
for j=2:1:size(P,1)
    diff_point = P(j,:) - P(j-1,:);
    num_sample = (T(j)-T(j-1))*samples_at_sec;

    if (j == pos_C1) 
        [s,ds,dds] = lspb(sic1, sfc1, num_sample); 
        sc1 = real(s);
        dsc1 = real(ds);
        ddsc1 = real(dds);
    else 
        [s,ds,dds] = lspb(0, norm(diff_point), num_sample);
        s=real(s);
        ds=real(ds);
        dds=real(dds);
    end
   
    S(1:size(s),j-1) = s; 
    DS(1:size(ds),j-1) = ds;
    DDS(1:size(dds),j-1) = dds;
end

% Calcolo S, DS ee DDS considerando l'anticipo dovuto ai punti di via
bracket_d = T_new(size(T,1))-DELTA_t(size(P,1));
S_ant = zeros(bracket_d,size(P,1)-1);   %10 punti, 9 tratti
DS_ant = zeros(bracket_d,size(P,1)-1);
DDS_ant = zeros(bracket_d,size(P,1)-1);

for j=2:1:size(P,1) 
    
    diff_point =  P(j,:) - P(j-1,:);
    
    bracket_a = 0;   %%intervalli di tempo della 4.50
    bracket_b = T_new(j-1)-DELTA_t(j);
    bracket_c = T_new(j)-DELTA_t(j);
    bracket_camp = bracket_c - bracket_b;
    
    % S
    S_ant(bracket_a+1:bracket_b+1,j-1) = 0;     %%applico la 4.50 in ogni 
    S_ant(bracket_b+2:bracket_c,j-1) = S(1:bracket_camp-1,j-1);%%intervallo
        
    if (j == pos_C1) 
        S_ant(bracket_c+1:bracket_d,j-1) = sfc1;

    else
        S_ant(bracket_c+1:bracket_d,j-1) = norm(diff_point);
    end
    
    % DS
    DS_ant(bracket_a+1:bracket_b+1,j-1) = 0;
    DS_ant(bracket_b+2:bracket_c,j-1) = DS(1:bracket_camp-1,j-1);
    DS_ant(bracket_c+1:bracket_d,j-1) = 0;
    
    % DDS
    DDS_ant(bracket_a+1:bracket_b+1,j-1) = 0;
    DDS_ant(bracket_b+2:bracket_c,j-1) = DDS(1:bracket_camp-1,j-1);
    DDS_ant(bracket_c+1:bracket_d,j-1) = 0;
end

% Calcolo pe,dpe,ddpe
pe = P(1,:);
dpe = 0;
ddpe = 0;

for j=2:1:size(P,1)
    diff_point =  P(j,:) - P(j-1,:);
    
    if (j == pos_C1) 
        aux = sum(delta_t(1:pos_C1));
        l = T_new(pos_C1)-aux;
        [pe_new, ped_new, pedd_new] = CIRCOLARE(sc1, dsc1, ddsc1, c1, r1, pe, dpe, ddpe, l, S_ant(:,j-1));
        pe = pe_new;
        dpe = ped_new;
        ddpe = pedd_new;

    else
        pe = pe + ((S_ant(:,j-1)*diff_point)/norm(diff_point)); 
        dpe = dpe + ((DS_ant(:,j-1)*diff_point)/norm(diff_point));
        ddpe = ddpe + ((DDS_ant(:,j-1)*diff_point)/norm(diff_point));
    end
end


time = T(1):(1/samples_at_sec):(T(end)- sum(delta_t)/samples_at_sec);

% Se commento queste righe ottengo i grafici buoni in 2D. Questo sistema è
% stato fatto per poter poi apprezzare meglio gli andamenti di velocità ,
% posizione e acc. avendo un asse dei tempi più lungo.
% % temp=(T(end)- sum(delta_t)/samples_at_sec):(1/samples_at_sec):50;
% % time=[time temp];
% % len_temp=length(temp);
% % pe_temp=pe(end)*ones(len_temp,3);
% % pe=[pe; pe_temp];
% % dpe_temp=dpe(end)*ones(len_temp,3);
% % dpe=[dpe; dpe_temp];
% % ddpe_temp=ddpe(end)*ones(len_temp,3);
% % ddpe=[ddpe; ddpe_temp];
