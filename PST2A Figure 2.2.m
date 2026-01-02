x = linspace(-2, 2, 200);
y = linspace(-2, 2, 200);
[X, Y] = meshgrid(x, y);

H_km = exp(- (4/5) * (X.^2 + Y.^2).^2 - (2/3) * X.^3 + X.^2 + Y.^2);

H_m = H_km * 1000;

figure;
[~, h] = contourf(X, Y, H_m, 0:250:2000);
colormap(summer);
hold on;

[C, h_cont] = contour(X, Y, H_m, 0:250:2000, 'k', 'LineWidth', 1);
clabel(C, h_cont, 'manual');

xlabel('x (km)', 'FontSize',14);
ylabel('y (km)', 'FontSize',14);
title('Topographic Contour Map of Exoplanet Surface', 'FontSize',14);
c = colorbar;
c.Label.String = 'Elevation (m)';
caxis([0 2000]);

axis equal tight;
grid on;

ax = gca;
ax.GridColor = [0, 0, 0];
ax.GridAlpha = 0.4;
ax.LineWidth = 0.75;
ax.Layer = 'top';
