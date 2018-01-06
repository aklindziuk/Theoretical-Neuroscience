 %find quadratic function to fit data using multilayer perceptron

x = [  -.4 1.4; -.2 1.2; 0 1; .2 .8; .4 .6];

 output = [quad(x(1,1)); quad(x(2,1)); quad(x(3,1)); quad(x(4,1)); quad(x(5,1))];
 b = [ -1 -1 -1];
 %w = ones(3,3)*.1;
 rand('state',sum(100*clock));
 w = -1 +2.*rand(3,3);
 eta = .9;
 
 for t = 1:10000
     for i = 1:5
         
         h1 = x(i,1)*w(1,1) + x(i,2)*w(1,2) + b(1)*w(1,3);
         x2_1 = sigma(h1);
         
         h2 = x(i,1)*w(2,1) + x(i,2)*w(2,2)+ b(2)*w(2,3);
         x2_2 = sigma(h2);
        
         h3 = x2_1*w(3,1) + x2_2*w(3,2)+ b(3)*w(3,3);
         x3 = sigma(h3);
         
         %backprop 
         dw_3 = x3*(1 - x3)*(output(i,1) - x3);
         dw_2 = x2_2*(1 - x2_2)*dw_3*w(3,2);
         dw_1 = x2_1*(1 - x2_1)*dw_3*w(3,1);
         
         for k = 1:3
             if k == 3 %bias weights
                 w(1,k) = w(1,k) + eta*b(1)*dw_1;
                 w(2,k) = w(2,k) + eta*b(2)*dw_2;
                 w(3,k) = w(3,k) + eta*b(3)*dw_3;
             elseif k == 2
                 w(1,k) = w(1,k) + eta*x(i,1)*dw_1; %2st input
                 w(2,k) = w(2,k) + eta*x(i,2)*dw_2;
                 w(3,k) = w(3,k) + eta*x2_2*dw_3;
             else
                 w(1,k) = w(1,k) + eta*x(i,1)*dw_1; %1st input
                 w(2,k) = w(2,k) + eta*x(i,2)*dw_2;
                 w(3,k) = w(3,k) + eta*x2_1*dw_3;
             end
         end
     end
 end
  
 figure(1)
x1 = -.5:.1:1.5;
y1 = w(1,1)/w(1,2)*(x1-.5).^2+w(1,3)/w(1,2)*(x1-.5);
y2 = w(2,1)/w(2,2)*(x1-.5).^2+w(2,3)/w(2,2)*(x1-.5);
y3 = w(3,1)/w(3,2)*(x1-.5).^2+w(3,3)/w(3,2)*(x1-.5);

plot(x1, y1,'r')
hold on
%plot(x1, y2,'g')
grid on
%plot(x1, y3,'b')
plot(x(:,1), output, 'k')
plot(x(:,2), output, 'k')
legend('fit1', 'data')

%xlim([-.5, 1.5]);
%ylim([-.5, 1.5]);
hold off
xlabel('x_1','FontSize', 20);
ylabel('x_2','FontSize', 20);
title('quadratic solution','FontSize', 16);

function y3 = quad(x3)
y3 = (x3 - .5)^2;
end
         