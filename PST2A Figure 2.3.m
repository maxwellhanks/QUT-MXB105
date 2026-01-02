f = @(x,y) -4/5*(x.^2 + y.^2).^2 - 2/3*x.^3 + x.^2 + y.^2 - 23/60;

figure;

fimplicit(f, [-2 2 -2 2], 'LineWidth', 2);

xlabel('x');
ylabel('y');
title('Level Curve of Exoplanet at Landing Height');

grid on;
