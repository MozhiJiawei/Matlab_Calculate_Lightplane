function [ Inv ] = Inv_Mex( n_of_Mex )
%UNTITLED �˴���ʾ�йش˺�����ժҪ
% n����ε���
load('lightExtrinsics.mat')
r_mat = lightExtrinsics.rotationMatrix(:,:,n_of_Mex)';
t_vec = lightExtrinsics.translationVector(n_of_Mex,:)';
Inv = [inv(r_mat), -inv(r_mat)*t_vec;zeros(1,3),1];
end

