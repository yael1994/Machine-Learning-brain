%% 2b 
%this section answer for question 2b. we set the data and call to k_fold
%function that split to k the data to train and validation. in this 
%question we use k=3.
clear all;
[xT , y,Lambda, kw ]=set_trainig();
k = input('Choose k:');
sum_accuracy=0;
for i=1:k 
    [train_x, train_y, test_x, test_y] = k_fold(xT,y,k,i); %split the data
    F=SVMtrial(train_x,train_y,kw,Lambda);                 %train the model
    accuracy=Evaluate(F,test_x,test_y);                    %check the avaluate of the model
    sum_accuracy= sum_accuracy+accuracy;                   %sum all the k avaluate
end
sum_accuracy= sum_accuracy/k;                              %divide in k for get the average 

%% 2d
%this section is answer for question 2d. we set the data, and create a 
%vector of lambda - we choose ten number from 0.0001 till 10000.
%for every lambda we run over the 3 set of data. train the data and 
%after that we avaluate the model with the test data.
clear all
[xT , y,Lambda, kw ]=set_trainig();
Lambda=[0.0001 0.001 0.01 0.1 1 10 100 1000 10000] ;  % Recommended box constraint
arr_accuracy=zeros(length(Lambda),1);
inter_accuracy=zeros(5,1);
for i=1:length(Lambda)
for j=1:3
    [train_x, train_y, test_x, test_y] = k_fold(xT,y,3,j);
    F=SVMtrial(train_x,train_y,kw,Lambda(i));
    accuracy=Evaluate(F,test_x,test_y);
    inter_accuracy(j)=accuracy; 
    clear F accuracy
end
arr_accuracy(i)= mean(inter_accuracy);
end
%plot the lambda as function of average accuracy.
plot(Lambda,arr_accuracy);
title('Average accuracy as function of size of Lambda');
xlabel('Size of training Lambda');
ylabel('Average accuracy');
%% 2c
%this section is answer for question 2c. we set the data and create vector
%of the set size. we choose 3 part of the data to be validation and the
%reset we random the train in the size of the set size.
clear all
[x , y,Lambda, kw ]=set_trainig();
set_size=[2,4,8,16];
arr_accuracy=zeros(4,1);
for j=1:length(set_size)
sum_accuracy=0;
for i=1:3
    [train_x, train_y, test_x, test_y] = create_set(x,y,set_size(j),i);
    F=SVMtrial(train_x,train_y,kw,Lambda);
    accuracy=Evaluate(F,test_x,test_y);
    sum_accuracy= sum_accuracy+accuracy;
end
arr_accuracy(j)=sum_accuracy/3;
end
plot(set_size,arr_accuracy);
title('Average accuracy as fucntion of the size of the training set');
xlabel('Size of training set');
ylabel('Average accuracy')