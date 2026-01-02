x = linspace(-2, 2, 400);
y = linspace(-2, 2, 400);

[X, Y] = meshgrid(x, y);

H_km = exp(- (4/5) * (X.^2 + Y.^2).^2 - (2/3) * X.^3 + X.^2 + Y.^2);
H_m = H_km * 1000

figure;
surf(X, Y, H_m, 'EdgeColor', 'none');
colormap jet;
xlabel('x (km)')
ylabel('y (km)')
zlabel('h(x,y) (m)')
title('3D visualisation of exoplanet surface')
c = colorbar;
c.Label.String = 'Elevation (m)';
caxis([0 2500]);
