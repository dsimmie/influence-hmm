% Function to find the inverse condition number for a matrix.
% This is used to remvoe any possible ambiguity from a well selected
% model by penalising linear dependence between rows.
function[inv_cond_num] = invCond(A)

inv_cond_num = min(svd(A))/max(svd(A));