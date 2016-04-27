function [ Inv ] = Inv_Mex( n_of_Mex )
%UNTITLED 此处显示有关此函数的摘要
% n号外参的逆
load('lightExtrinsics.mat')
r_mat = lightExtrinsics.rotationMatrix(:,:,n_of_Mex)';
t_vec = lightExtrinsics.translationVector(n_of_Mex,:)';
Inv = [inv(r_mat), -inv(r_mat)*t_vec;zeros(1,3),1];
end

