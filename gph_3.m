clear all;
close all;

Lx = 1;
Ly = 2;
Nx = 256;
Ny = 512;
dx = Lx/Nx;
dy = Ly/Ny;
dt = 1e-5;
t  = 0.5;
Nt = floor(t/dt);

x     = linspace(0,Lx,Nx);
y     = linspace(0,Ly,Ny);
[X,Y] = meshgrid(x,y);

f                                      = zeros(Ny,Nx);
f(X>=0.45 & X<=0.55 & Y>=0.9 & Y<=1.1) = 1; % ic

pt_1 = [];
pt_2 = [];
time = [];

z_max = max(f(:));
z_min = min(f(:));

figure;
        %contourf(f);
        %colorbar;
        %caxis([z_min, z_max]);
        surf(X, Y, f);
        view(3);
        view(45, 30);
        colorbar;
        caxis([z_min, z_max]);
        zlim([z_min, z_max]);
        colormap("parula");
        shading interp;
        lighting phong;
        camlight headlight;
        title(['t = 0']);
        xlabel('x');
        ylabel('y');
        %grid on;

        %filename = sprintf('C:/Users/abhil/Desktop/DIFFERENTIAL EQUATIONS/results/1_initial_plot.png');
        %saveas(gcf, filename);

figure;
for n = 1:Nt

    pt_1 = [pt_1,f(1,1)];
    pt_2 = [pt_2,f(Ny/2,Nx/2)];
    time = [time,n];

    for i = 2:Nx-1
        for j = 2:Ny-1
            f(j,i) = f(j,i) - (dt/dx)*(f(j,i)-f(j,i-1)) + dt/3 * ((f(j,i+1)-2*f(j,i)+f(j,i-1))/dx^2) + dt/3 * ((f(j+1,i)-2*f(j,i)+f(j-1,i))/dy^2);
        end
    end

    f(:,1)   = f(:,end-1);
    f(:,end) = f(:,2);
    f(1,:)   = f(end-1,:);
    f(end,:) = f(2,:);

    if mod(n, 100) == 0
        % contourf(f);
        % colorbar;
        % caxis([z_min, z_max]);
        surf(X, Y, f);
        view(3);
        view(45, 30);
        colorbar;
        caxis([z_min, z_max]);
        zlim([z_min, z_max]);
        colormap("parula");
        shading interp;
        lighting phong;
        camlight headlight;
        title(['t = ', num2str(n * dt)]);
        xlabel('x');
        ylabel('y');
        % grid on;
        pause(1e-5);

        % filename = sprintf('C:/Users/abhil/Desktop/DIFFERENTIAL EQUATIONS/results/plot_timestep_%d.png', n);
        % saveas(gcf, filename);
    end

    timestep = n
end

figure;
plot(time,pt_2);
figure;
plot(time,pt_1);