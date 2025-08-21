%%Draw images of the generation process
for i = 1:3
    load(sprintf('Generated_Process%d.mat',i)) %load the generated sample data
    n = 14; %Number of rows and columns
    Picture = ones(n+1,n+1);
    figure;
    for m = 1:10
        subplot(2,5,m);
        Picture(1:n,1:n) = flip(reshape(visprobs_ite(m,:),[n,n]));
        imagesc(Picture);colormap('gray(256)');
        s = pcolor(Picture);colormap(gray);
        s.EdgeColor = [0.2,0.2,0.2];
        axis off
    end
end