%����Ŀ��simulink���matlab 2019b�İ汾�У��û���ʹ��ʱ����Ҫʹ����˰汾��ͬ�����߸��ߵİ汾��
%����Ŀ��Դ��mathwork�еĹٷ�ʵ��Tuning of Gain-Scheduled Three-Loop Autopilot���޸Ķ���
%�������еı���ֵ������̱���һ�£���
%%
clc;clear;
open_system('airframecontrol')
%%
%����������
nA = 5;  
nV = 9;  
[alpha,V] = ndgrid(linspace(0,20,nA)*pi/180,linspace(700,1400,nV));

open_system('airframemodel')
%%
%��ָ���Ĺ����㸽��������Ӧ�Ŀ�������ֵ������Ĺ��̿��Բμ�matlab�Դ�ʾ���еġ�Trimming and Linearizing an
%Airframe����
clear op
for ct=1:nA*nV
   alpha_ini = alpha(ct);      
   v_ini = V(ct);             
   
   
   opspec = operspec('airframemodel');

   opspec.States(1).Known = [1;1];
   opspec.States(1).SteadyState = [0;0];
 
   opspec.States(3).Known = [1 1];
   opspec.States(3).SteadyState = [0 1];

   opspec.States(2).Known = 1;
   opspec.States(2).SteadyState = 0;

   opspec.States(4).Known = 0;
   opspec.States(4).SteadyState = 1;
   

   Options = findopOptions('DisplayReport','off');
   op(ct) = findop('airframemodel',opspec,Options);
end

G = linearize('airframemodel',op);
G = reshape(G,[nA nV]);
G.u = 'delta';
G.y = {'alpha' 'V' 'q' 'az' 'gamma' 'h'};


%%
%�����Щ���������£���Ӧ�Ŀ�������ֵ���������״̬
sigma(G), title('Variations in airframe dynamics')
%%
%���ÿһ�����������
TuningGrid = struct('alpha',alpha,'V',V);
ShapeFcn = @(alpha,V) [alpha,V,alpha*V];

Kp = tunableSurface('Kp', 0.1, TuningGrid, ShapeFcn);
Ki = tunableSurface('Ki', 2, TuningGrid, ShapeFcn);
Ka = tunableSurface('Ka', 0.001, TuningGrid, ShapeFcn);
Kg = tunableSurface('Kg', -1000, TuningGrid, ShapeFcn);
BlockSubs = struct('Name','airframecontrol/Airframe Model','Value',G);
ST0 = slTuner('airframecontrol',{'Kp','Ki','Ka','Kg'},BlockSubs);

ST0.addPoint({'az_ref','az','gamma_ref','gamma','delta'})

ST0.setBlockParam('Kp',Kp,'Ki',Ki,'Ka',Ka,'Kg',Kg);

%%
%ʹ��ϵͳ��������״̬��������
Req1 = TuningGoal.Tracking('gamma_ref','gamma',1,0.02,1.3);
viewGoal(Req1)

RejectionProfile = frd([0.02 0.02 1.2 1.2 0.1],[0 0.02 2 15 150]);
Req2 = TuningGoal.Gain('az_ref','az',RejectionProfile);
viewGoal(Req2)

Req3 = TuningGoal.Gain('delta','az',600*tf([0.25 0],[0.25 1]));
viewGoal(Req3)
MinDamping = 0.35;
Req4 = TuningGoal.Poles(0,MinDamping);

ST = systune(ST0,[Req1 Req2 Req3 Req4]);

 TGS = getBlockParam(ST);
%%
%��ͼ
clf
subplot(211), step(getIOTransfer(ST,'gamma_ref','gamma'),5), grid
title('Tracking of step change in flight path angle')
subplot(212), step(getIOTransfer(ST,'delta','az'),3), grid
title('Rejection of step disturbance at plant input')


