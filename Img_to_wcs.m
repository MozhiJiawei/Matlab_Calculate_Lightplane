function [ result_wcs ] = Img_to_wcs( u, v, n_of_Mex )
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   ����������ת����n����ϵ�е�Z=0ƽ����
load('calibrationSession_firt_try.mat');
intr_mat = calibrationSession.CameraParameters.IntrinsicMatrix;

plane_ccs = [0,0,1,0] * Inv_Mex(n_of_Mex);
line_ccs = [intr_mat(1,1),0,intr_mat(3,1)-u,0;
    0,intr_mat(2,2),intr_mat(3,2)-v,0];

A = [plane_ccs(:,1:3);line_ccs(:,1:3)];
B = [-plane_ccs(:,4);-line_ccs(:,4)];

result_ccs = A\B;
result_ccs = [result_ccs;1];
result_wcs = Inv_Mex(n_of_Mex) * result_ccs;
end