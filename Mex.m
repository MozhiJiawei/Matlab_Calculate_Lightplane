function [ R_T ] = Mex( n_of_Mex )
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   n�����
load('lightExtrinsics.mat')
r_mat = lightExtrinsics.rotationMatrix(:,:,n_of_Mex)';
t_vec = lightExtrinsics.translationVector(n_of_Mex,:)';
R_T = [r_mat,t_vec;zeros(1,3),1];
end
