%% �����ٶ�

t = (1:step-1)*h;
for i = 1:n
figure
plot(t,acc(2:step,i),'LineWidth',2);
hold on
plot(t,acc_b(2:step,i),'LineWidth',2);
hold on
title('�������ٶ�');
xlabel('ʱ��/��');
ylabel('���ٶ�/(m/s^2)');
grid on
end

