%simulation for perceptron-type Hopfield network

nth= 1; %which num vector to recall
N = 10; %set dimension
P = 30; %set num vec
eta = .1;	%learning rate

for r = 1:P %iterate over total number of patterns stored
    P = r;
    
input = randi([0 1], P, N); %memorized pattern
p = size(input,1); % Find the number of vectors 
n = size(input,2); % Find the dimension of the vectors 
y = zeros(1,n);
w = rand(n,n);
x = 2*input-1; % Convert probe to bipolar form 
d = x(nth,:); %desired out

for t = 1:100	
  for k = 1:r
      Y = x(k,:)*w'; 
      y = sgn(Y);
      dw = eta*(d - y)'*x(k,:);
      w = w+ dw;
      for j = 1:n 
          w(j,j) = 0;
      end
  end  
end 
 
%flip a few bits in the key (input)
%}
flip_N = 2;
    for i =1:flip_N
        d(i) = d(i)*(-1);
    end    
%}

probe = d; %Read probe vector = desired out (ideally)
flag = 0;						% Initialize flag ;
vector = probe;
 
while flag ~= n  
    permindex = randperm(n);	% Randomize the order of update 
   	 old_signal_vector = vector;% Keep a copy of the signals

    for j = 1:n  
      act_vec = w*probe';
      if act_vec(permindex(j)) > 0 
        vector(permindex(j)) = 1; 
      elseif act_vec(permindex(j)) < 0
        vector(permindex(j)) = -1; 
      end 
    end 
  flag = vector*old_signal_vector';	% Generate flag 
end 
 
stored_original(r,:) = input(nth,:); %whats in the memory
returned(r,:) = .5*(vector+1); % attempt to associate from incomplete probe
delta1(r,:) = abs(stored_original(r,:) - returned(r,:));
delta2(r) = delta1(r,:)*delta1(r,:)'; %count number of mismatches
end

figure(2)
plot(delta2);
hold on
xlabel('number of stored patterns, P', 'FontSize', 16);
ylabel('number of error bits in output', 'FontSize', 16); %mismatch in the associated pattern to the pattern stored
legend('all correct key');

function y = sgn(x)
    l = length(x);
    y = zeros(1,l);
    for i = 1:l
        if x(i) > 0
            y(i) = 1;
        elseif x(i) < 0
            y(i) = -1;
        end
    end
end