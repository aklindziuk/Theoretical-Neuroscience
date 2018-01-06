%simulation for the standard Hopfield netrwork

P = 100; %number of vectors
N = 100; %dimension of vectors
delta2 = zeros(P,1);

for m = 1:3
for k = 1:P % loop P, number of patterns
    n = N; %all vectors have same dimension
    p = k; %vary number of vectors   
input = randi([0 1], p, n);%generate some vectors to memorize
q = size(input,1); % Find the number of vectors 
n = size(input,2); % Find the dimension of the vectors 
x = 2*(input) - 1;% Convert to bipolar 
 
% Initialize and compute the weight matrix 
w = zeros(n,n); 
for i=1:q  
 w = w + x(i,:)'*x(i,:); 
end 
w = w - q*eye(n); % Zero off the diagonal 
 
%set the probe vector
Num = 1; %which vector to recall 
probe = input(Num,:);

%flip a few bits
flip_N = 0;
for i =1:flip_N
    probe(i) = abs(probe(i)-1);
end

%ok now we got the signal
signal_vector = 2*probe-1; % Convert probe to bipolar form 
flag = 0;						% Initialize flag 
 
while flag ~= n  
    permindex = randperm(n);	% Randomize the order of update 
    old_signal_vector = signal_vector;	% Keep a copy of the signals 
    for j = 1:n 					% Update all neurons once per epoch 
      act_vec = signal_vector * w;  
      if act_vec(permindex(j)) > 0 
        signal_vector(permindex(j)) = 1; 
      elseif act_vec(permindex(j)) < 0 
        signal_vector(permindex(j)) = -1; 
      end 
    end 
  flag = signal_vector*old_signal_vector';	% Generate flag 
end 
stored_original = input(Num,:); %whats in the memory
corrupted_input = probe; % with bits flipped - try to associate it 
returned = .5*(signal_vector+1); % attempt to associate from incomplete probe
delta = stored_original - returned;
delta2(k,1) = delta*delta';
end
end

figure(1)
plot(delta2);
hold on
xlabel('number of stored patterns, P', 'FontSize', 16);
ylabel('number of error bits in output', 'FontSize', 16); %mismatch in the associated pattern to the pattern stored