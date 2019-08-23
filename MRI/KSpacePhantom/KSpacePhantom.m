% ����read�������
Readout = 150;

% ����ͷ��ģ��ͼ
[P,~] = phantom('Modified Shepp-Logan',Readout);
figure;
subplot(1,4,1);imagesc(abs(P));axis square;
title('Software head phantom')

% ����K�ռ�
kspace =fftshift(fft2(ifftshift(P)));
subplot(1,4,2);imagesc(abs(kspace));axis square;
title('Simulated K-space')
subplot(1,4,3);plot(abs(kspace));axis square;
title('Simulated K-space')

% k�ռ�ƽ��
ShiftRead = 10;
Width = zeros(Readout,1);
for i=1:Readout
    Width(i,1) = complex(cos(i*ShiftRead),-sin(i*ShiftRead));
end
Width = repmat(Width,1,Readout);
kspace = kspace .* Width;

% k�ռ䷭ת
kspace = flip(kspace);

% ��K�ռ�ָ���ԭͼ
I0 = fftshift(ifft2(ifftshift(kspace)));
subplot(1,4,4);imagesc(abs(I0));axis square;
title('2DFFT Reconstructed image')