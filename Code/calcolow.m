syms q1 q2 q3 q4 a1 a2 real;

%rilasso x
J=[a2*cos(q1+q2)+a1*cos(q1) a2*cos(q1+q2) 0 0;
    0 0 1 0;
    1 1 0 1];
w=simplify(sqrt(det(J*J')));
dw_dq_1=simplify(diff(w,q1));
dw_dq_2=simplify(diff(w,q2));
dw_dq_3=simplify(diff(w,q3));
dw_dq_4=simplify(diff(w,q4));
%rilasso y
J_y_r=[-a2*sin(q1+q2)-a1*sin(q1) -a2*sin(q1+q2) 0 0;
    0 0 1 0;
    1 1 0 1];
w_y=sqrt(det(J_y_r*J_y_r'));
dw_dq_y_1=diff(w_y,q1);
dw_dq_y_2=diff(w_y,q2);
dw_dq_y_3=diff(w_y,q3);
dw_dq_y_4=diff(w_y,q4);

%rilasso z
J_z_r=[-a2*sin(q1+q2)-a1*sin(q1) -a2*sin(q1+q2) 0 0;
    a2*cos(q1+q2)+a1*cos(q1) a2*cos(q1+q2) 0 0;
    1 1 0 1];
w_z=sqrt(det(J_z_r*J_z_r'));
dw_dq_z_1=diff(w_z,q1);
dw_dq_z_2=diff(w_z,q2);
dw_dq_z_3=diff(w_z,q3);
dw_dq_z_4=diff(w_z,q4);
%rilasso fi
J_fi_r=[-a2*sin(q1+q2)-a1*sin(q1) -a2*sin(q1+q2) 0 0;
    a2*cos(q1+q2)+a1*cos(q1) a2*cos(q1+q2) 0 0;
    0 0 1 0];
w_fi=sqrt(det(J_fi_r*J_fi_r'));
dw_dq_fi_1=diff(w_fi,q1);
dw_dq_fi_2=diff(w_fi,q2);
dw_dq_fi_3=diff(w_fi,q3);
dw_dq_fi_4=diff(w_fi,q4);
% Jacobiano intero
J_int=[ -a1*sin(q1)-a2*sin(q1+q2)   -a2*sin(q1+q2)  0   0   ;
       a1*cos(q1)+a2*cos(q1+q2)    a2*cos(q1+q2)  0   0   ;
                   0                              0         1   0   ;
                   1                              1         0   1   ];
W=abs(det(J_int));
