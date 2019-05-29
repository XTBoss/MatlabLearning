
% ҽѧͼ����׼
% Step1. ����ͼƬ
% Step2. ��ʼ��׼������׼��
% Step3. �����׼����
% Step4. ���ó�ʼ���������׼������׼

fixed = dicomread('knee1.dcm');      % ���ο�ͼ��fixed
moving = dicomread('knee2.dcm'); %  ������ͼ��moving

% �����Ż����Ͷ���׼��
[optimizer, metric] = imregconfig('multimodal');

% ��׼����
movingRegisteredDefault = imregister(moving,fixed,'affine',optimizer,metric);

% �����׼����
disp('optimizer');
disp('metric');

% �ı��Ż����Ĳ����Ѵﵽ�Ը��Ӿ�ϸ�ı任
optimizer.InitialRadius=optimizer.InitialRadius/3.5;
movingRegisteredAdjustedInitialRadius=imregister(moving,fixed,'affine',optimizer,metric);

% �ı�����������
optimizer.MaximumIterations = 300;
movingRegisteredAdjustedInitialRadius300 = imregister(moving, fixed, 'affine', optimizer, metric);

% �ı��ʼ������߾���
tformSimilarity = imregtform(moving,fixed,'similarity',optimizer,metric);
Rfixed = imref2d(size(fixed));
movingRegisteredRigid = imwarp(moving,tformSimilarity,'OutputView',Rfixed);

movingRegisteredAffineWithIC = imregister(moving,fixed,'affine',optimizer,metric,'InitialTransformation',tformSimilarity);
%%
moving_new=[fixed,...
    moving,movingRegisteredDefault,...
    movingRegisteredAdjustedInitialRadius,...
    movingRegisteredAdjustedInitialRadius300,...
    movingRegisteredRigid,...
    movingRegisteredAffineWithIC    ];
fixed_new=[fixed,fixed,fixed,fixed,fixed,fixed,fixed,];
subplot(2,1,1);imshowpair(moving_new, fixed_new, 'falsecolor');
subplot(2,1,2);imshow(moving_new,[]);
%%
figure;
imshowpair(movingRegisteredDefault, fixed);
title('A?-?Default?settings.');

figure;
imshowpair(movingRegisteredAdjustedInitialRadius, fixed);
title('B?-?Adjusted?InitialRadius,?100?Iterations.');

figure
imshowpair(movingRegisteredAdjustedInitialRadius300, fixed);
title('C?-?Adjusted?InitialRadius,?300?Iterations.');

figure
imshowpair(movingRegisteredAffineWithIC, fixed);
title('D?-?Registration?from?affine?model?based?on?similarity?initial?condition.');

