function [ p_result ] = Wcs_to_wcs( p_in, n2, n1 )
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
% ��n2����ϵ�еĵ�p_inת����n1����ϵ��
p_result = Inv_Mex(n1) * Mex(n2) * p_in;
end