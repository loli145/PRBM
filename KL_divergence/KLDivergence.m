load('experiment_gene_pro.mat');
load('baseline_train.mat');
load('digital_gene_pro.mat')
eps = 1e-10;
itera_all = 26;
pdf_ite_exp_pro = [];
for m = 1:itera_all
    pdf_ite_exp_pro(m,:) = mean(experiment_gene_pro(:,:,m));
    pdf_ite_exp_pro(m,:) =  pdf_ite_exp_pro(m,:)/sum( pdf_ite_exp_pro(m,:));
end
pdf_ite_exp_pro(find(pdf_ite_exp_pro < 1e-5)) = eps;
pdf_ite = [];
for m = 1:itera_all
    pdf_ite(m,:) = mean(digital_gene_pro(:,:,m));
    pdf_ite(m,:) = pdf_ite(m,:)/sum(pdf_ite(m,:));
end
pdf_ite(find(pdf_ite < 1e-5)) = eps;

%%
KL_ite_exp_train = [];
KL_ite_digital_train = [];
for m = 1:itera_all
    ratio = baseline_train./pdf_ite_exp_pro(m,:);
    KL_ite_exp_train(m) = sum(baseline_train.*log(ratio));
end

for m = 1:itera_all
    ratio = baseline_train./pdf_ite(m,:);
    KL_ite_digital_train(m) = sum(baseline_train.*log(ratio));
end

figure;
p = plot((0:25),KL_ite_digital_train(1:26),'-o');
p.LineWidth = 1.2;
p.Color = [0.5,0.2,0.6];
hold on
plot((0:25),KL_ite_exp_train(1:26),'-hexagram','Color',[0.9,0.7,0.1],'LineWidth',1.2);
hold on
set(gca,'FontSize',14,'FontWeight','bold','LineWidth',...
    1.5);
xlabel ('K');
ylabel ('KL divergence');
legend('KL\{Train || Digital\}','KL\{Train || Optical\}','FontSize',12)