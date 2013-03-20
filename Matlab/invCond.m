function[inv_cond_num] = invCond(A)
% Function to find the inverse condition number for a matrix.
% This is used to remvoe any possible ambiguity from a well selected
% model by penalising linear dependence between rows.
% Formula taken from: "Componenta Analysis of hidden Markov model in
% Computer Vision" by Caelli and McCane

inv_cond_num = min(svd(A))/max(svd(A));