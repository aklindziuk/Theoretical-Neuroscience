% Synaptic weight evolution in a Hebbian neuron

% create distribution with variances 1 and 3 and mean 0
mu = [0,0];
sigma = [3 0; 0 1];
ang = pi/6;
X = mvnrnd(mu,sigma,200);


R = [cos(ang) -sin(ang); sin(ang) cos(ang)];
X = (R*X');

plot(X(1,:),X(2,:),'r+')
hold on
xlim([-10 10])
ylim([-10 10])

% create weights, set learning rate
[N, M] = size(X);
w1 = ones(N, M)*.1;
eta1 = .00015;

%evolve over 200 time steps
for i = 1:200
    
    y1 = X*w1';
    dw1 = eta1*y1*X;
    w1 = w1 + dw1;
    plot(w1(1,3),w1(2,3),'ko');
  
end

hold off
legend('distribution', 'Hebb')
xlabel('variable x')
ylabel('variable y')
title('synaptic weight evolution')
