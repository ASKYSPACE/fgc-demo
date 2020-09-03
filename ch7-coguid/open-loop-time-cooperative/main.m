clear
clc
global h Pm Pt v n N step Tgo T0 R0 acc acc_b
n = 2; % ��������
N = 3; % ��������ϵ��
tf =160; % ������ʱ������
acc = zeros(100,n); %
acc_b = zeros(100,n);

Pt = [14000,0];    %Ŀ���λ��
v = zeros(n,1);   %n���������ٶ�
Pm = zeros(n,2);  %������λ��(n������)
Tgo = zeros(10,n); % ������ʣ�๥��ʱ��
q0 = zeros(1,n);  %��ʼ�������߽�
Sgm = zeros(1,n);  %ǰ�ý�
sita = zeros(1,n); %�������
r0 = zeros(1,n);  %��ʼ����
R_total = 0;
T_total = 0;
tgo = zeros(1,n);
for i = 1:n
    v(i) = 200+(i-1)*20;  % �����ٶ�
    Pm(i,:) = [-(i-1)*1000,(i-1)*(00)]; % ����λ��
    q0(i) = atan( ( Pt(2) - Pm(i,2) )/( Pt(1) - Pm(i,1) ) );%��i���߽�
    Sgm(i) = ( 30+(i-1)*15 )*pi/180;    %ǰ�ý�
    sita(i) = q0(i)+Sgm(i);    %�������
    r0(i) = sqrt( ( Pt(2) - Pm(i,2) )^2 + ( Pt(1) - Pm(i,1) )^2 );%��ʼ����
    Tgo(1,i) = ( r0(i)/v(i) )*( 1 + ( Sgm(i)^2/( 2*( 2*N - 1 ) ) ) );  % ʣ�๥��ʱ�����           
    R_total = R_total + r0(i);     %�ܾ���
    T_total = T_total + Tgo(1,i);   % ��ʣ�๥��ʱ��
    
end
R0 = R_total/n;   % ��ʼƽ����Ŀ����
T0 = T_total/n;   % ��ʼƽ��ʣ�๥��ʱ��
h = 0.005;      %���沽��
t = 0:h:tf;     %ʱ��
Step = 1+tf/h;  %��󲽳�
% ��ʼ��״̬��
X = zeros(10,3*n);   %״̬��
for i = 1:n
    X(1,(3*i-2):(3*i)) = [ q0(i),sita(i),r0(i) ];
end
    % [ ��i���߽ǣ���i������ǣ���i��Ŀ���� ]
i = 1;
P = zeros( n,2,100 );  % ������λ�ü�¼
flag = 1;  % �ж��Ƿ����еĵ���������Ŀ��
while (i <=Step)&&flag  %( norm( [ ( X(8)-X(6) ),( X(7)-X(5) ) ] )<10 )
    i = i+1;
    step = i;
    X(i,:) = RK_4( X(i-1,:) );
    for j = 1:n
        P(j,:,i) =  Pt - [ X(i,3*j)*cos( X(i,j*3-2) ),X(i,3*j)*sin( X(i,3*j-2) ) ];%��¼����λ��
    end
    flag = 1;
    for j = 1:n
        if X(i,3*j)<5
            flag = 1*flag;
        else
            flag = 0;
        end
        
    end
    if flag == 1
        flag = 0;
    else
        flag = 1;
    end
end
plotTgo
plotSgm
plotAcc
out
% plotdetaAcc


