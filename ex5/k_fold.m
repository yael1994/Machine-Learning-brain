%the function create train and test from the data, the function split the
%data in the size of k. 
function [train_x, train_y, test_x, test_y] = k_fold(x,y,k,i)
start = floor(length(x)/k*(i-1))+1;
end_run = floor(length(x)/k*i);
test_x = x((start):(end_run),:);
test_y = y((start):(end_run),:);
train_x = [ x((1:start-1),:) ; x((end_run+1 : length(x)),:)];
train_y = [ y((1:start-1),:) ; y((end_run+1 : length(y)),:)];  
end