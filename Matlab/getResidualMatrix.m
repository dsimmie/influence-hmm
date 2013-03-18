% Get the residual matrix for the input matrix.
% See: "Components Analysis of hidden Markov model in
% Computer Vision" by Caelli and McCane for more information.
function[E] = getResidualMatrix(C)

% Create a new matrix with 
E = zeros(rank(C(2:end,:)), size(C,2));

for i=1:size(C,1)-1
    % r_i if the first row in C_i, the matrix without row i.
    r_i = C(i,:)';
    
    % The matrix without row i.
    C_i = C(~ismember(1:size(C, 1), i), :);
        
    % The row space of C_j. Note row space of A = column space of A' 
    C_i_rowspace = rowspace(C_i);

    % Get the Projection Matrix of the rowspace of C_j
    % Proj = C_i_rowspace/inv(C_i_rowspace'*C_i_rowspace)\C_i_rowspace';
    Proj = C_i_rowspace*inv(C_i_rowspace'*C_i_rowspace)*C_i_rowspace';
    
    % Project the vector r_i onto the subspace described by the span of the rowspace of C_j 
    P_c_i = Proj*r_i;

    % The residual vector is the row vector transpose minus the
    % projection onto to the span of the row space.
    e_i = r_i - P_c_i;

    E(i,:) = e_i';
end
