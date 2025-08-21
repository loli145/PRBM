%%draw Figure 2(c)
load('T.mat')
load('heat_capacity.mat')
load('susceptibility.mat')
createfigure(T, susceptibility, heat_capacity);

function createfigure(X1, Y1, Y2)
figure1 = figure;

axes1 = axes('Parent',figure1,'YTick',[0 0.2 0.4 0.6 0.8 1 1.2]);
hold(axes1,'on');
colororder([0.85 0.325 0.098]);

yyaxis(axes1,'left');
plot(X1,Y1,'MarkerSize',8,'Marker','square','LineWidth',0.8,'Color',[0.00,0.45,0.74]);

ylabel({'\chi'},'FontSize',20);

set(axes1,'YColor',[0 0.447 0.741]);
yyaxis(axes1,'right');
plot(X1,Y2,'MarkerSize',8,'Marker','*','LineWidth',0.8,...
    'Color',[0.85 0.325 0.098]);

ylabel({'C'},'FontWeight','bold','FontAngle','italic','FontSize',20);

set(axes1,'YColor',[0.85 0.325 0.098],'YTick',[0 0.2 0.4 0.6 0.8 1 1.2]);
xlabel('T','FontAngle','italic','FontSize',20,'Interpreter','none');

box(axes1,'on');
hold(axes1,'off');
set(axes1,'FontSize',16,'FontWeight','bold','GridLineWidth',5,'LineWidth',...
    1.5,'XTick',[0 1 2 3 4 5 6]);
end
