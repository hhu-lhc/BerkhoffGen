%��ʽ��Դ�� http://www.engineering.org.cn/en/article/20070413?utm_source=TrendMD&utm_medium=cpc&utm_campaign=Engineering_TrendMD_1
%Update 2021��4��1�� �Ͼ� ʮ������
clear;clc;close
%��������ȡ 20m * 20.0m
x=[0:0.1:20]';
y=[0:0.1:20]';
[x,y]=meshgrid(x,y);
x1=(x-10.5)*cosd(20)-(y-10)*sind(20);
y1=(x-10.5)*sind(20)+(y-10)*cosd(20);
%   [x1,y1]=meshgrid(x1,y1);

%��Բ��ǳ̲���Ķ�Ӧ�����꣨x1,y1��=(0,0)���߽綨��Ϊ��(x1/3.0)^2+(y1/4.0)^2=1.0
ecc = axes2ecc(4,3);  % ���ݳ�����Ͷ̰��������Բƫ����
[elat,elon] = ellipse1(0,0,[4 ecc],90);
figure(1)
plot(elat,elon);grid on;
title('��Բ����')

for i=1:length(x)
    for j=1:length(y)
        if x1(i,j)<-5.82   %ƽ������б����ˮ����жϺ���
            h(i,j)=0.45;
        else
            h(i,j)=0.45-0.02*(5.82+x1(i,j));
        end
        if inpolygon(x1(i,j),y1(i,j),elat,elon) %��Բ��ǳ̲��ˮ����жϺ���
            h(i,j)=h(i,j)-0.5*(1-(x1(i,j)/3.75)^2-(y1(i,j)/5.0)^2)^0.5+0.3;
        end
    end
end
figure(2)
C=contour(x,y,h);
title('Berkhoff ��Բ���εȸ���');
clabel(C)
figure(3)
mesh(x,y,h);
colorbar;
title('Berkhoff ��Բ����');

%д���depth.xyz�ļ�
fclose all;
fid=fopen(['Berkhoff-depth.xyz'],'w');%д���ļ�·��
for i=1:length(x)
    for j=1:length(y)
        fprintf(fid,'%f\t%f\t%f\n',x(i,j),y(i,j),h(i,j));
    end
end


