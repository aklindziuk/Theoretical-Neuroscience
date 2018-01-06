% solve AND gate sorting problem using single layer perceptron


p =[1 0 0  
   1 0 1	 
   1 1 0 	 
   1 1 1]; 
 
%d =[0 0 0 1];	% output for AND gate
d =[0 1 1 1];	% output for OR gate
%d =[0 1 1 0];   % output for XOR gate
w =[0 0 0];		 
eta = 1;		  
update = 1;		
				 
 
for t = 1:10000					  
   for i=1:4					 
      y = p(i,:)*w'; 			
      if y >= 0 & d(i)== 0 	 
         w = w - eta*p(i,:);	 
      elseif y<=0 & d(i) ==1	 
         w = w + eta*p(i,:);	
      end 
   end 				
end
 

figure(1)
x1 = -.5:.1:1.5;
x2 = (-w(2)/w(3))*x1 - w(1)/w(3);
plot(x1, x2)
hold on
plot( p(1,2), p(1,3), 'k*');
hold on
plot( p(2,2), p(2,3), 'r*');
plot( p(3,2), p(3,3), 'r*');
plot( p(4,2), p(4,3), 'k*');
xlim([-.5, 1.5]);
ylim([-.5, 1.5]);
xlabel('x_1','FontSize', 20);
ylabel('x_2','FontSize', 20);
title('AND gate','FontSize', 16);