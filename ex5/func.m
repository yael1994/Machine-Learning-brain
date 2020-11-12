%% FUNCTION TO EVALUATE ANY UNSEEN DATA, x
%  [xT,y,a,b,kw,sv] are fixed after solving the QP.
%  f(x) = SUM_{i=sv}(y(i)*a(i)*K(x,xT(i))) + b;
    function F = func(x,xT,y,a,b,kw,sv)
        K = repmat(x,size(sv)) - xT(sv,:);      % d = (x - x')
        K = exp(-sum(K.^2,2)/kw);               % RBF: exp(-d^2/kw)
        F = sum(y(sv).*a(sv).*K) + b;           % f(x)
    end