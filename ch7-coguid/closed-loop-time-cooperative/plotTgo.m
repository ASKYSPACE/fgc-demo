%% ��ʣ��ʱ��
t = (1:step)*h;
figure
for i = 1:n
plot(t,Tgo(:,i),'LineWidth',2);
hold on
end
title('��������ʣ�๥��ʱ��');
xlabel('ʱ��/s');
ylabel('����ʣ��ʱ��/s');
grid on