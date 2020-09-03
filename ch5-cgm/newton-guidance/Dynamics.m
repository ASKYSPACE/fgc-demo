%a             ���ٶ�
%v             �ٶ�
%the           ·����
%x             ������
%y             ������
%X             ϵͳ��״̬
%U             ������
%%
%X�ǵ�ǰģ�͵�״̬������U��ģ�͵Ŀ��Ʊ���
%����ֵΪ���Ӧ��΢��ֵ
%%
function dX = Dynamics(  X ,U)
global m S Cd g rou 
  a = U;  
  v = X(1);
  the = X(2);
  dv = - rou*v^2*S*Cd/2/m-g*sin(the) ; 
  dthe = (a-g*cos(the))/v ;
  dx = v*cos(the) ;  
  dy = v*sin(the) ;
  dX = [dv;dthe;dx;dy] ; 
end