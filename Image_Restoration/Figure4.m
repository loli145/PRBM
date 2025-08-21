%%draw Figure 4
load("Figure4b_1.mat")
n = 20;
EE = ones(n+1,n+1);
figure;
for m = 1:20
    subplot(4,5,m);
    EE(1:n,1:n) = flip(reshape(visib_states_ite(m,:),[n,n]));
    imagesc(EE);colormap('gray(256)');
     s = pcolor(EE);colormap(gray);
     s.EdgeColor = [0.2,0.2,0.2];
     axis off
end