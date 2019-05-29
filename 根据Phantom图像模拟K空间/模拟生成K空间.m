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

% ��K�ռ�ָ���ԭͼ
I0 = fftshift(ifft2(ifftshift(kspace)));
subplot(1,4,4);imagesc(abs(I0));axis square;
title('2DFFT Reconstructed image')