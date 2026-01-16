spin_N = [10,4e2,10000,10^6,10^8];
E_slm = 2.5e-3;
E_opt = 6e-3;
E_adc = 9.4e-4;
E_RBM_slm = 2*(E_slm + E_opt + E_adc);
EM_optical_SLM = E_RBM_slm./spin_N;
E_PPM = 1e-9;
E_opt = 3e-10;
E_adc = 1e-12;
E_RBM_PPM = 2*(E_PPM + E_opt + E_adc);
EM_optical_PPM = E_RBM_PPM./spin_N;

EM_H100 = kron(1e-11,ones(1,5));
EM_LAN = kron(3e-18,ones(1,5));

figure;loglog(spin_N,EM_optical_SLM,'o-','LineWidth',...
    1.5)
xlim([10,10^8])
ylim([1e-19,2e-3])
hold on
loglog(spin_N,EM_optical_PPM,'o-','LineWidth',...
    1.5)
hold on
loglog(spin_N,EM_H100,'o-','LineWidth',...
    1.5)
hold on
loglog(spin_N,EM_LAN,'o-','LineWidth',...
    1.5)
set(gca,'FontSize',14,'FontWeight','bold','LineWidth',...
    2);
xlabel('Spin number')
ylabel('Energy/MAC (J)')
legend('PRBM w/ LC-SLM + sCMOS','PRBM w/ PPM + PD','Digital RBM w/ H100','Landauer (1000 bit ops)','FontSize',11)


%%
spin_N = [10,4e2,10000,10^6,10^8];
T_slm = 0.72e-3;
T_pd = 2.4e-4;
T_adc = 3.7e-5;
T_PRBM_slm = 2*(T_slm + T_pd + T_adc);
optical_SLM = T_PRBM_slm./spin_N;
T_PPM = 1e-9;
T_pd = 1e-10;
T_adc = 1e-10;
T_PRBM_PPM = 2*(T_PPM + T_pd + T_adc);
optical_PPM = T_PRBM_PPM./spin_N;
digital_H100 = kron(1/(6/2)/10^13,ones(1,5));


figure;loglog(spin_N,optical_SLM,'o-','LineWidth',...
    1.5)
 xlim([10,10^8])
hold on
loglog(spin_N,optical_PPM,'o-','LineWidth',...
    1.5)
hold on
loglog(spin_N,digital_H100,'o-','LineWidth',...
    1.5)
set(gca,'FontSize',14,'FontWeight','bold','LineWidth',...
    2);
legend('PRBM w/ LC-SLM + sCMOS','PRBM w/ PPM + PD','Digital RBM w/ H100','FontSize',11)
xlabel('Spin number')
ylabel('Time/MAC (s)')