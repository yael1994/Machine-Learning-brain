%the function create a diffrent set of train and test.
%we choose a test vector at size 50, and from the hundred that
%remain we choose in random the train at the set size.
function [train_x, train_y, test_x, test_y] = create_set(x,y,set_size,i)
start = (i-1)*50 +1;
end_run = start + 49;
test_x = x(start : end_run,:);
test_y = y (start : end_run);
temp_x = [ x((1:start-1),:) ; x((end_run+1 : length(x)),:)];
temp_y = [ y((1:start-1),:) ; y((end_run+1 : length(y)),:)];
r = randi([10 100],1,set_size);
train_x= zeros(length(r),2);
train_y= zeros(length(r),1);
for j=1:length(r)
    train_x(j,:) = temp_x(r(j),:);
    train_y(j) = temp_y(r(j));
end 
end