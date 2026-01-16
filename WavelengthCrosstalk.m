lamda = 600e-9; %wavelength 
w2 = linspace(0.2,1,20)*1e-6; 
f = 37e-3; %the focal length of the cylindrical lens
w1 = lamda*f/pi./w2;  %incident Gaussian waist
sigma = w2/2;  
width_grating = 2*w1; % the width of grating
L = 2e-6; % the width of two pixels 
half_L = L / 2; 


prob = normcdf(half_L, 0, sigma) - normcdf(-half_L, 0, sigma);
percentage = prob * 100;
crosstalk = 100-percentage; % the percentage of light intensity that leaks outside the designated pixel area
%%
figure;
semilogy(width_grating, crosstalk, 'LineWidth', 2);
xlabel('Grating width /m');
ylabel('Crosstalk (%)');
set(gca,'FontSize',14,'FontWeight','bold','LineWidth',...
    2);

