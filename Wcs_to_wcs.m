function [ p_result ] = Wcs_to_wcs( p_in, n2, n1 )
%UNTITLED3 此处显示有关此函数的摘要
% 将n2坐标系中的点p_in转换到n1坐标系中
p_result = Inv_Mex(n1) * Mex(n2) * p_in;
end