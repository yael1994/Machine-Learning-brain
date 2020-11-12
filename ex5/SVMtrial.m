function F = SVMtrial(x,y,kw,Lambda)
% SVMtrial(x,y,kw,Lambda) runs a support vector machine for classifying
%   2D-data into 2 classes, denoted by 1 and -1. Training is done by
%   solving a quadratic programming problem using the interior-point
%   method. The Gaussian radial basis function (RBF) is used as kernel.
%
%   Inputs:     x   = training data [N x 2]
%               y   = known classification, 1 (red) or -1 (blue)
%               kw  = desired kernel width of RBF
%               Lambda   = regularization constant (scalar or vector);
%                     if isvector(Lambda), Lambda must have size [N x 1]
%
%   Output:     3D mesh plot of the learned manifold
%               F   = function f(x) for checking sign(f(x))
%
%   Note: If there are no inputs, the user can choose from the
%         6 prepared datasets below.
%   Refs.:  Coursera - Machine Learning by Andrew Ng
%           Support Vector Machines, Cristianini & Shawe-Taylor, 2000



%% NORMALIZE DATA

N = length(y);                                  % Let N = no. of samples
xm = mean(x); xs = std(x);                      % Mean and Std. Dev.
x = (x - xm(ones(N,1),:))./xs(ones(N,1),:);     % Center and scale data
xT = x;                                         % Save training data set

%% SOLVE THE QUADRATIC PROGRAMMING PROBLEM

H = zeros(N);                                   % For sum(ai*aj*yi*yj*K)
f = -ones(N,1);                                 % For sum(a)
Aeq = y';                                       % For sum(a'*y) = 0
Beq = 0;                                        % For sum(a'*y) = 0
if isscalar(Lambda), Lambda = Lambda*ones(N,1); end            % if C is scalar...
lb = zeros(N,1);                                % For 0 <= a
ub = Lambda;                                         % For a <= C

for j = 1:N
    for k = 1:j
        d = x(j,:) - xT(k,:);
        H(j,k) = y(j)*y(k)*exp(-(d*d')/kw);     % Create kernel matrix
        H(k,j) = H(j,k);                        %  using RBF kernel
    end
end

options = optimoptions('quadprog',...
    'Algorithm','interior-point-convex',...     % Set solver options
    'Display','off');

a = quadprog(H,f,[],[],...                      % Solve the QP (see the
    Aeq,Beq,lb,ub,[],options);                  % definition of quadprog)

tol = 1e-8;
n1 = a < tol; n2 = (a > Lambda - tol);
if sum(n1) >= 1, a(n1) = 0; end                 % Tolerate small errors
if sum(n2) >= 1, a(n2) = Lambda(n2); end             % Tolerate small errors
sv = find(a > 0);                               % Select support vectors

fprintf('No. of Support Vectors: %d\n',length(sv));
fprintf('No. of Samples: %d\n',N);

%% ESTIMATE THE BIAS, b
%  b is chosen so that y(i)*f(x(i)) = 1 for i=nb

nb = find(a > 0 & a < Lambda);                       % Points near boundary
temp = zeros(size(nb));
for j = 1:length(nb)
    temp(j) = 1/y(nb(j)) - func(x(nb(j),:),xT,y,a,0,kw,sv);
end
b = mean(temp);                                 % Estimate the bias, b

F.xT = xT; F.sv = sv; F.kw = kw;
F.a = a; F.b = b; F.y = y;


end