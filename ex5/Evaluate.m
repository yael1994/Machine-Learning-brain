%the function evaluate the model with the test data. 
%we start with normalization of the test data. after that we send to
%function func. 
function accuracy=Evaluate(F,x_test, y_test)
xT = F.xT; y = F.y; a = F.a; b = F.b; kw = F.kw; sv = F.sv;    
N = length(y_test);                                  % Let N = no. of samples
xm = mean(x_test); xs = std(x_test);                      % Mean and Std. Dev.
xT_test = (x_test - xm(ones(N,1),:))./xs(ones(N,1),:);     % Center and scale data
accuracy =0;
perd = zeros(length(xT),1);
for sample=1:length(xT_test)
    pred(sample) = func(xT_test(sample,:),xT,y,a,b,kw,sv);
end
pred=sign(pred);                     
for i=1:length(x_test)
    if y_test(i) == pred(i)
        accuracy = accuracy + 1;
    end  
end
accuracy = (accuracy/sample);
end

