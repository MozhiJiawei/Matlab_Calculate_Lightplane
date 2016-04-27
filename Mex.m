function [ R_T ] = Mex( n_of_Mex )
%UNTITLED2 此处显示有关此函数的摘要
%   n号外参
load('lightExtrinsics.mat')
r_mat = lightExtrinsics.rotationMatrix(:,:,n_of_Mex)';
t_vec = lightExtrinsics.translationVector(n_of_Mex,:)';
R_T = [r_mat,t_vec;zeros(1,3),1];
end
