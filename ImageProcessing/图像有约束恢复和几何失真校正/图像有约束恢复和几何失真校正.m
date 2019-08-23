clear;
close all;

%ͨ��ģ��ˮƽ�˶�ģ�������˻�����
d=5;
h=zeros(2*d+1,2*d+1);       %��������
h(d+1,1:2*d+1)=1/(2*d);

% add noise
I=imread('E:\coding\fft\FFT.jpg');
I=rgb2gray(I);
[m,n]=size(I);
fe=zeros(m+2*d,n+2*d);
fe(1:m,1:n)=I;
he=zeros(m+2*d,n+2*d);
he(1:2*d+1,1:2*d+1)=h;
F=fft2(fe);
H=fft2(he);
g=imnoise(uint8(ifft2(F.*H)),'gaussian',0,0.0001);
G=fft2(double(g));
subplot(2,4,1);imshow(I);title('ԭʼͼ��');axis on;
subplot(2,4,2);imshow(g);title('ˮƽ�˶�ģ���˻�');axis on

%ά���˲�
k=0.05;
[m,n]=size(G);
for u=1:m;
     for v=1:n;
         i=abs(H(u,v));
         i=i.^2;
         s(u,v)=(1/H(u,v)*(i./(i+k)));
         r(u,v)=s(u,v).*G(u,v);
     end
end
 
r=ifft2(r);
r=uint8(real(r));
subplot(2,4,3);
imshow(r);title('ά���˲�');axis on;

%Լ����Сƽ���˲���
[M,N]=size(G);
p=[0 -4 0;1 -4 1 ;0 1 0];
[m,n]=size(p);
pp=zeros(M,N);
pp(1:m,1:n)=p;
P=fft2(pp);
k1=0.001;
for u=1:M;
    for v=1:N;
        i=abs(H(u,v));
        i=i.^2;
        j=abs(P(u,v));
        j=k1*(j.^2);
        H1(u,v)=i./H(u,v);
         s2(u,v)=(H1(u,v)./(i+j));
         r2(u,v)=s2(u,v).*G(u,v);
    end
end
r2=ifft2(r2);
r2=uint8(real(r2));
subplot(2,4,4);
imshow(r2);title('Լ����Сƽ���˲�');axis on;

%����任
s=0.5;T=[s 0;0 s;0 0];
tf=maketform('affine',T);
I1=imtransform(r,tf,'bicubic','FillValues',0.3);
subplot(2,4,5);imshow(I1);title('����任');axis on;
 
%��ֵ
I2=imresize(I1,1,'nearest');
I3=imresize(I1,1,'bilinear');
I4=imresize(I1,1,'bicubic');
subplot(2,4,6);imshow(I2);title('����ڲ�ֵ');axis on;
subplot(2,4,7);imshow(I2);title('˫���Բ�ֵ');axis on;
subplot(2,4,8);imshow(I2);title('˫���β�ֵ');axis on;
