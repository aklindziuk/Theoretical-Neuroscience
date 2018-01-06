% linear regression using perceptorn

x = [ .2; 
    .4;
    .6;
    .8];

output_lin = [linear(x(1,1)); linear(x(2,1)); linear(x(3,1)); linear(x(4,1))];
%output_sig = [sig(x(1,1)); sig(x(2,1)); sig(x(3,1)); sig(x(4,1))];
%output_quad =[quad(x(1,1)); quad(x(2,1)); quad(x(3,1)); quad(x(4,1))];

b = [1;
    1];

rand('state',sum(100*clock));
w = -1 +2.*rand(1,2);

eta = .7;
y = zeros(1,4);
out = zeros(2,1);

for t = 1:100
for i = 1:4
    y(i) = x(i,1)*w(1) + b(1)*w(2); %for linear regression
end

dw_1 = eta/4*(sum((output_lin' - y)*x(:,1))); %fit to linear pattern
%dw_1 = eta/4*(sum((output_sig' - y)*x(:,1))); %fit to sigmoidal pattern
%dw_1 = eta/4*(sum((output_quad' - y)*x(:,1))); %fit to quadratic pattern

dw_2 = eta/4*(sum(output_lin' - y)); %fit to linear pattern
%dw_2 = eta/4*(sum(output_sig' - y)); %fit to sigmoidal pattern
%dw_2 = eta/4*(sum(output_quad' - y)); %fit to quadratic pattern

w(1) = w(1) + dw_1;
w(2) = w(2) + dw_2;
end

figure(1)
plot(x, output_lin, 'k*')
%plot(x, output_sig, 'k*')
%plot(x, output_quad, 'k*')
x1 = -0.5:.1:1.5;
y1 = w(1)*x1 + w(2);
hold on
plot(x1, y1)
hold off

xlim([-.5, 1.5]);

xlabel('x_1','FontSize', 20);
ylabel('x_2','FontSize', 20);
title('linear regression for linear input','FontSize', 16);

function y1 = linear(x1)
y1 = 2*x1 + .5;
end

function y2 = sig(x2)
y2 = 1/(1+exp(4*(-x2-0.2)));
end

function y3 = quad(x3)
y3 = (x3 - .5)^2;
end

