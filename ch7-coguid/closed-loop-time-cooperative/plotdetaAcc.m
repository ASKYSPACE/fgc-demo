%% ���Ӽ��ٶ�
figure
t = (1:step-1)*h;
for i = 1:n
plot(t,a(2:step,i),'LineWidth',2);
hold on
end
title('���ӵ������ٶ�');
xlabel('ʱ��/��');
ylabel('���ٶ�/(m/s^2)');
grid on