%%the function set all the data, in out exercise we choose data numbet 4.
%the out put of the function:               
%               x   = training data [N x 2]
%               y   = known classification, 1 (red) or -1 (blue)
%               kw  = desired kernel width of RBF
%               Lambda   = regularization constant (scalar or vector);
%                     if isvector(Lambda), Lambda must have size [N x 1]
function  [xT , y , Lambda , kw ]= set_trainig()
clc;
fprintf('Welcome to SVM Trials!\n');
rng(1)
if nargin == 0
    fprintf('[1] TYPICAL\n');
    fprintf('[2] SADDLE\n');
    fprintf('[3] RANDOM\n');
    fprintf('[4] RANDOM, IN ELLIPSE W/ 1 OUTLIER\n');
    fprintf('[5] SPIRAL\n');
    fprintf('[6] IMBALANCED + OVERLAP\n')
    ch = input('Choose dataset: ');             % Let the user choose
    
    switch ch
        case 1
            % Set 1: TYPICAL
            kw = 0.8;   % Recommended RBF kernel width
            Lambda = Inf;    % Recommended box constraint
            x = [4,5,2,2,4,9,7,8,8,9;
                7,8,2,5,5,2,1,1,5,4]';
            y = [1 1 1 1 1 -1 -1 -1 -1 -1]';
            
        case 2
            % Set 2: SADDLE
            kw = 1;     % Recommended RBF kernel width
            Lambda = Inf;    % Recommended box constraint
            x = [4,4,2,3,8,9,7,7,5,4,6,5,8,9,6,7;
                4,6,6,3,2,3,2,0,1,0,1,2,7,8,7,5]';
            y = [1 1 1 1 1 1 1 1 -1 -1 -1 -1 -1 -1 -1 -1]';
            
        case 3
            % Set 3: RANDOM
            kw = 0.1;   % Recommended RBF kernel width
            Lambda = 1;      % Recommended box constraint
            x = 10*rand(50,2);
            y = ones(50,1); y(1:25) = -1;
            
        case 4
            % Set 4: RANDOM, IN ELLIPSE W/ 1 OUTLIER
            kw = 0.25;  % Recommended RBF kernel width
            Lambda = 10;     % Recommended box constraint
            x = 10*rand(150,2);
            y = (x(:,1) - 6).^2 + 3*(x(:,2) - 5).^2 - 8;
            y(y > 0) = 1; y(y ~= 1) = -1;
%             outlr = randi(150);
%             y(outlr) = -y(outlr); % Outlier (this is removable)
            
        case 5
            % Set 5: SPIRAL
            kw = 0.2;   % Recommended RBF kernel width
            Lambda = Inf;    % Recommended box constraint
            x = importdata('myspiral.mat');
            y = x(:,3); x = x(:,1:2);
            
        case 6
            % Set 6: IMBALANCED + OVERLAP
            kw = 0.5;   % Recommended RBF kernel width
            Cpos = 1;   % Recommended box constraint (red)
            Cneg = Inf; % Recommended box constraint (blue)
            x = importdata('imba.mat');
            y = x(:,3); x = x(:,1:2);
            Lambda = zeros(size(y));
            Lambda(y == 1) = Cpos; Lambda(y == -1) = Cneg;
            % Remark: Try switching Cpos and Cneg.
    end

xT = x;                                        
end   
end