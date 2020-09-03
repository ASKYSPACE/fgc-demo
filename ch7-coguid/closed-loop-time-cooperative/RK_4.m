function y = RK_4(X)
global h step v n acc acc_b N
% X = X';
K1 = h*solve( X );
K2 = h*solve( X+K1/2);
K3 = h*solve( X+K2/2);
K4 = h*solve( X+K3);
y = X+( K1 + 2*K2 + 2*K3 + K4 )/6;
 X_1 = (y-X)/h;
 for i = 1:n
 acc(step,i) = v(i)*X_1(3*i-1);  %����i�ļ��ٶ�
 acc_b(step,i) = acc(step,i) - N*v(i)*X_1(3*i-2);  %����i�ĸ��Ӽ��ٶ�
 end
% n_m(step,2) = v(2)*X_1(5);  %����2�ļ��ٶ�
% a(step,1) = v(1)*( X_1(2) - 3*X_1(1) );  % ���Ӽ��ٶ�
% a(step,2) = v(2)*( X_1(5) - 3*X_1(4) );  % ���Ӽ��ٶ�
% a(step,3) = -v(1)*sin( X(2)-X(1) )/X(3);
% a(step,4) = -v(2)*sin( X(5)-X(4) )/X(6);
% a(step,3) = v(1)*( 3*X_1(1) );  % ԭʼ���ٶ�
% a(step,4) = v(2)*( 3*X_1(4) );  % ԭʼ���ٶ�



