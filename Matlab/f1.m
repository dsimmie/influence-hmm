function [ f1Measure ] = f1( precision, recall )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
f1Measure = 0;    
if(precision+recall>0)
    f1Measure = 2*((precision*recall)/(precision+recall));
end

end

