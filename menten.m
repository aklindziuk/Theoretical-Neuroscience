%solve michaelis menten differential equations

S0 = 5; %initail rates (substrate)
C0 = 0; % substrate enzyme complex
P0 = 0; % product

global k1; %forward rate
k1= 30;
global km1; %backward rate
km1 = 1;
global k2; %forw rate of dissociation
k2 = 10;
global Et; %total enzyme amount
Et= 1;

M0 = [S0, C0, P0];

[t, M] = ode45(@dM, [0,1], M0);

figure(1)
plot(t, M(:,1))
hold on
plot(t,M(:,2))
plot(t, M(:,3))
ylabel('Concentration','FontSize', 18)
xlabel('time','FontSize', 18)
legend('substrate', 'complex', 'product')
title('Michaelis-Menten Enzyme Kinetics','FontSize',18)
%dim = [0.5 0.4 0.3 0.3];
%str = {'k_1 = 1','k_{-1} = 15','k_2 = 15','S_0 = 5', 'E_0 = 5'};
%annotation('textbox',dim,'String',str,'FitBoxToText','on');
hold off

S0_red = 5; %initail rates (substrate)
M0_red = [S0_red];

[tr, M_red] = ode45(@dM_red, [0,1], M0_red);

figure(2)
plot(tr, M_red(:,1))
hold on
plot(tr,S0_red - M_red(:,1))
plot(t, M(:,1))
plot(t, M(:,3))
ylabel('Concentration','FontSize', 18)
xlabel('time','FontSize', 18)
legend('S(reduced)', 'P (reduced)', 'S (full)', 'P (full)')
title('Reduced Michaelis-Menten','FontSize',18)
%dim = [0.7 0.4 0.3 0.3];
%str = {'k_1 = 20','k_{-1} = 10','k_2 = 15','S_0 = 50', 'E_0 = 5'};
%annotation('textbox',dim,'String',str,'FitBoxToText','on');
hold off

function dm = dM_red(t, m)

global k1;
global km1;
global k2;
global Et;

      dm=[-k1*k2*Et*m/(km1+k2+k1*m)];
 
end

function dm = dM(t, m)

global k1;
global km1;
global k2;
global Et;

      dm=[-k1*m(1)*(Et-m(2)) + km1*m(2), 
	   -km1*m(2) + k1*m(1)*(Et-m(2))-k2*m(2), 
	   k2*m(2)];
 
end