%% channel order fix

test=squeeze(str2num(char(regexprep(aran_Eng_AVG_ERP.label(1:129), 'E',''))));
test2=[test aran_Eng_AVG_ERP.avg(1:129,:)];
test2=sortrows(test2,1);
aran_English_AVG_ERP_chancorr=test2(:,[2:30002]);
save aran_English_AVG_ERP_chancorr aran_English_AVG_ERP_chancorr

test=squeeze(str2num(char(regexprep(aran_Japanese_AVG_ERP.label(1:129), 'E',''))));
test2=[test aran_Japanese_AVG_ERP.avg(1:129,:)];
test2=sortrows(test2,1);
aran_Japanese_AVG_ERP_chancorr=test2(:,[2:30002]);
save aran_Japanese_AVG_ERP_chancorr aran_Japanese_AVG_ERP_chancorr

test=squeeze(str2num(char(regexprep(aran_French_AVG_ERP.label(1:129), 'E',''))));
test2=[test aran_French_AVG_ERP.avg(1:129,:)];
test2=sortrows(test2,1);
aran_French_AVG_ERP_chancorr=test2(:,[2:30002]);
save aran_French_AVG_ERP_chancorr aran_French_AVG_ERP_chancorr

test=squeeze(str2num(char(regexprep(aran_Polish_AVG_ERP.label(1:129), 'E',''))));
test2=[test aran_Polish_AVG_ERP.avg(1:129,:)];
test2=sortrows(test2,1);
aran_Polish_AVG_ERP_chancorr=test2(:,[2:30002]);
save aran_Polish_AVG_ERP_chancorr aran_Polish_AVG_ERP_chancorr

test=squeeze(str2num(char(regexprep(aran_Vocoded_AVG_ERP.label(1:129), 'E',''))));
test2=[test aran_Vocoded_AVG_ERP.avg(1:129,:)];
test2=sortrows(test2,1);
aran_Vocoded_AVG_ERP_chancorr=test2(:,[2:30002]);
save aran_Vocoded_AVG_ERP_chancorr aran_Vocoded_AVG_ERP_chancorr

%% once snr fft files are sVot to matlab's workspace

electrodes = [24 19 11 4 124 29 20 12 5 118 111 30 13 6 112 105 7 106];
Freqs = linspace(0,500,30001);
limits = [-.15 .16];
x1 = [2.5 2.5];
x2 = [5 5];
x3 = [10 10];

aran_English_chan = squeeze(lwdata(1).data);
aran_English_FC=mean(aran_English_chan(electrodes, 61:721), 1); %FC for Fronto-Central electrodes we want to average
figure();
plot(Freqs(61:721), aran_English_FC, 'LineWidth',1.5, 'Color','k'); %721 is the column number at which the value is 12Hz
title('ENGLISH');
ylim(limits);
y1 = get(gca,'ylim')
hold on
plot(x1,y1,'LineStyle','--')
hold on
plot(x2,y1,'LineStyle','--')
hold on
plot(x3,y1,'LineStyle','--')
axes('Position', [.675 .15 .2 .2])
box on 
ft_topoplotER(cfg, aran_English_chan_ft); colormap;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))
axes('Position', [.15 .15 .2 .2])
box on 
ft_topoplotER(cfg, aran_English_chan_ft); colormap;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))
axes('Position', [.35 .15 .2 .2])
box on 
ft_topoplotER(cfg, aran_English_chan_ft); colormap;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))

save aran_English_chan aran_English_chan;


aran_French_chan = squeeze(lwdata(2).data);
aran_French_FC=mean(aran_French_chan(electrodes, 61:721), 1); %FC for Fronto-Central electrodes we want to average
figure();
plot(Freqs(61:721), aran_French_FC, 'LineWidth',1.5, 'Color','k'); %721 is the column number at which the value is 12Hz
title('FRENCH');
ylim(limits);
y1 = get(gca,'ylim')
hold on
plot(x1,y1,'LineStyle','--')
hold on
plot(x2,y1,'LineStyle','--')
hold on
plot(x3,y1,'LineStyle','--')
save aran_French_chan aran_French_chan;


aran_Japanese_chan = squeeze(lwdata(3).data);
aran_Japanese_FC=mean(aran_Japanese_chan(electrodes, 61:721), 1); %FC for Fronto-Central electrodes we want to average
figure();
plot(Freqs(61:721), aran_Japanese_FC, 'LineWidth',1.5, 'Color','k'); %721 is the column number at which the value is 12Hz
title('JAPANESE');
ylim(limits);
y1 = get(gca,'ylim')
hold on
plot(x1,y1,'LineStyle','--')
hold on
plot(x2,y1,'LineStyle','--')
hold on
plot(x3,y1,'LineStyle','--')
save aran_Japanese_chan aran_Japanese_chan;


aran_Polish_chan = squeeze(lwdata(4).data);
aran_Polish_FC=mean(aran_Polish_chan(electrodes, 61:721), 1); %FC for Fronto-Central electrodes we want to average 61 to 721 (meaning from 1Hz to 12Hz in this case)
figure();
plot(Freqs(61:721), aran_Polish_FC, 'LineWidth',1.5, 'Color','k'); %721 is the column number at which the value is 12Hz
title('POLISH');
ylim(limits);
y1 = get(gca,'ylim')
hold on
plot(x1,y1,'LineStyle','--')
hold on
plot(x2,y1,'LineStyle','--')
hold on
plot(x3,y1,'LineStyle','--')
save aran_Polish_chan aran_Polish_chan;


aran_Vocoded_chan = squeeze(lwdata(5).data);
aran_Vocoded_FC=mean(aran_Vocoded_chan(electrodes, 61:721), 1); %FC for Fronto-Central electrodes we want to average
figure();
plot(Freqs(61:721), aran_Vocoded_FC, 'LineWidth',1.5, 'Color','k'); %721 is the column number at which the value is 12Hz
title('VOCODED');
ylim(limits);
y1 = get(gca,'ylim')
hold on
plot(x1,y1,'LineStyle','--')
hold on
plot(x2,y1,'LineStyle','--')
hold on
plot(x3,y1,'LineStyle','--')
save aran_Vocoded_chan aran_Vocoded_chan;


















