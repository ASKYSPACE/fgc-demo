function Y = solve(X)
global  r v step Tgo n N T0 h R0
t = h*step-2*h; % ��ǰʱ��
tgo_d = 100-t;  % ������ʣ�๥��ʱ��
nm = 5; %���������ù���
r = zeros(1,n);  % ��Ŀ����
sita = zeros(1,n); % �������
q = zeros(1,n); % ���߽�
sgm = zeros(1,n); % ǰ�ý�
for i = 1:n
r(i) = X(3*i);       %��Ŀ����
sita(i) = X(3*i-1); %�����������
q(i) = X(3*i-2);    %���߽�
sgm(i) = sita(i) - q(i); %ǰ�ý�
end
T_tt = 0; % ��ʣ�๥��ʱ��
for i = 1:n
    Tgo(step,i)=( r(i)/v(i) )*( 1 + sgm(i)^2/( 4*N - 2 ) );
    T_tt = Tgo(step,i)+T_tt;
end
Tgo_ave = T_tt/n; %ƽ��ʣ�๥��ʱ��
% Tgo_ave = tgo_d; %��������ʱ��
FC = 0; % ʣ�๥��ʱ�䷽��
for i = 1:n
    FC = FC + (Tgo_ave-Tgo(step,i))^2;
end
BZC = sqrt(FC);  % ʣ�๥��ʱ���׼��
q1 = zeros(1,n);   %��ʼ�����߽��ٶ�
sita1 = zeros(1,n);% ��ʼ����������ٶ�
r1 = zeros(1,n);   % ��ʼ����Ŀ�ƽ��ٶ�
for i = 1:n
    q1(i) = ( -v(i)*sin( sgm(i) ) - 0 )/r(i);  %���߽��ٶ�


    Ke = 40/( R0*T0 );  % Ke��ǰ�ý�Ϊ0ʱ���������
    omiga = Ke*r(i)*n*( Tgo_ave - Tgo(step,i) );
    


sita1(i)=N*( 1-omiga )*v(i)*q1(i);
sita1(i) = sita1(i)/v(i);
if (v(i)*sita1(i)/9.8)>nm
    sita1(i) = nm*9.8/v(i);
else if (v(i)*sita1(i)/9.8)< -nm
    sita1(i) = -nm*9.8/v(i);
    end
end
r1(i) = 0 - v(i)*cos( sgm(i) ); %��Ŀ���뵼��
end
for i = 1:n
    if X(3*i)<1
        Y(3*i-2:3*i) = [0 0 0];
    else
        Y(3*i-2:3*i) = [ q1(i) sita1(i) r1(i) ];
    end
end







