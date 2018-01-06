% BCM rule for 2 lin ind inputs with equal probability

K = [[1; .3],[.3; 1]];
p1 = .5;
p2 = 1 - p1;
P = [p1; p2];

T = 50000;
tau = 100;
eta = .001;
dim = 2;
patN = 2;
theta = ones(dim, T);
w = .5*ones(dim, T);
y = zeros(1,T);
xSeq = randsample(1:patN, T, 'true', P);
x = zeros(dim, T);

for i = 1:T
    x(:,i) = K(:, xSeq(i));
end


y(1) = x(:,1)' * w(:,1);

for t = 2:T
    
    dtheta = 1/tau*(y(t-1).^2 - theta(t-1));
    dw = eta * x(:,t-1) * (y(t-1) * (y(t-1) - theta(t-1)));
    theta(t) = theta(t-1) + dtheta;
    w(:,t) = w(:,t-1) + dw;
    y(t) = x(:,t)' * w(:,t);
    
end

figure(1)
plot( w(1,:), 'r')
hold on
plot(w(2,:), 'b')
xlabel('time iteration', 'FontSize', 16)
ylabel('input values, x_1 or x_2','FontSize', 16 )
title('evolution of weight vector components','FontSize', 16)
legend('weight, 1st comp.', 'weight, 2nd comp.', 'Location','northWest')

figure(2)
plotv(K, 'k')
hold on
plotv(w(:,T),'g')
xlabel('value of 1st dimension ','FontSize', 16)
ylabel('value of 2nd dimension','FontSize', 16)
title('input pattern and weight vectors','FontSize', 16)
legend('input patterns', 'weights')



    
    