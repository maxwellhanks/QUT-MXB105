a = (log(20))/3;
t = linspace(0, 5, 1000);

u = 10 * exp(a * t);

figure;
plot(t, u, 'b-', 'LineWidth', 2);
hold on;

t_pts = 0:5;
u_pts = 10 * exp(a * t_pts);
plot(t_pts, u_pts, 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 6);

xlabel('t (years)');
ylabel('Population, u(t)');
title('Exponential Population Growth');
grid on;
xlim([0 5]);
ylim([0 max(u_pts)*1.1]);

hold off;

%%%%%%%%%

lambda = 1.35433;
K = 300;

u = linspace(-2, K+2, 500);
f = lambda * u .* (1 - u./K);

figure('Color','w'), hold on

plot(u, f, 'b-', 'LineWidth', 2)
plot(u, zeros(size(u)), 'k--')

plot([0, K], [0, 0], 'ro', 'MarkerSize', 8, 'MarkerFaceColor','r')

xlabel('u'), ylabel('du/dt')
title('Phase-line & solution curve for carrying capacity model')
axis tight

u_arrows = linspace(-1, K+1, 8);
f_arrows = lambda * u_arrows .* (1 - u_arrows./K);
arrow_length = 0.1;

for i = 1:numel(u_arrows)
  dir = sign(f_arrows(i));
  quiver( u_arrows(i), 0, ...
    dir*arrow_length, 0, ...
    'MaxHeadSize', 1, ...
    'AutoScale','off', ...
    'Color','k', ...
    'LineWidth',1 )
end

ylim([-10, max(f)*1.1])
grid on
hold off

%%%%%%%

a = - log(1/58)/3;
C = 2.48788;
t = linspace(0, 10, 1000);

u = 300./(1 + 29 * exp(-a*t));

figure;
plot(t, u, 'b-', 'LineWidth', 2);
hold on;

t_pts = 0:10;
u_pts = 300./(1 + 29 * exp(-a*t_pts));
plot(t_pts, u_pts, 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 6);

xlabel('t (years)');
ylabel('Population, u(t)');
title('Logistic Population Growth');
grid on;
xlim([0 10]);
ylim([0 max(u_pts)*1.1]);

hold off;

%%%%%%%%%%%%

lambda = 1.35433;
K = 300;
h = 35;

u = linspace(-2, K+2, 500);
f = lambda * u .* (1 - u./K) - h;

figure('Color','w'), hold on

plot(u, f, 'b-', 'LineWidth', 2)
plot(u, zeros(size(u)), 'k--')

plot([28.562, 271.437], [0, 0], 'ro', 'MarkerSize', 8,
'MarkerFaceColor','r')

xlabel('u'), ylabel('du/dt')
title('Phase-line & solution curve for carrying capacity/harvesting
model')
axis tight

u_arrows = linspace(-1, K+1, 8);
f_arrows = lambda * u_arrows .* (1 - u_arrows./K) - h;
arrow_length = 10;

for i = 1:numel(u_arrows)
  dir = sign(f_arrows(i));
  quiver( u_arrows(i), 0, ...
    dir*arrow_length, 0, ...
    'MaxHeadSize', 1, ...
    'AutoScale','off', ...
    'Color','k', ...
    'LineWidth',1 )
end

ylim([-10, max(f)*1.1])
grid on
hold off

%%%%%%%%%%

lambda = 1.35433;
K = 299.610;
h = 35;

t1_span = [0 3];
t2_span = [3 10];
t3_span = [3 10];

u0_1 = 10;
u0_2 = 200;

ode_unharvested = @(t,u) lambda*u.*(1 - u./K);
ode_unharvestedafter = @(t,u) lambda*u.*(1 - u./K);
ode_harvested = @(t,u) lambda*u.*(1 - u./K) - h;

[t1, u1] = ode45(ode_unharvested, t1_span, u0_1);
[t2, u2] = ode45(ode_harvested, t2_span, u0_2);
[t3, u3] = ode45(ode_unharvestedafter, t3_span, u0_2);

figure;
hold on;
plot(t1, u1, 'b-', 'LineWidth', 2);
plot(t2, u2, 'r--', 'LineWidth', 2);
plot(t3, u3, 'b-', 'LineWidth', 2);
hold off;

grid on;
xlabel('t');
ylabel('u(t)');
xlim([0 10]);
ylim([0 330]);
title('Piecewise logistic: unharvested until t=3, harvested thereafter');
legend({'unharvested','harvested (h=35)'}, 'Location','best');
