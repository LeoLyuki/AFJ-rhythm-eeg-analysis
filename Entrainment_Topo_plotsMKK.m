
%Done by Min Kyo Kim on 2018 June 29!

%% -------------------------------------------------------
% Things to change 
% -------------------------------------------------------

% electrodes to be averaged together
electrodes = [24 19 11 4 124 29 20 12 5 118 111 7 30 13 6 112 105 106]; 

% frequencies reference
Freqs = linspace(0,1000,30001);

% frequencies range to plot
freqrange = 61:361;

% min and max amplitude values for entrainment plot
limits = [-.15 .16];

% locations of topoplots within plot
head10 = [.675 .15 .2 .2];
head5 = [.35 .15 .2 .2];
head25 = [.15 .15 .2 .2];

% for topography, depends on peak amplitudes in data
colorscale = [-.13 .18];

% ------------------------------------------------------
% ------------------------------------------------------

% frequencies to draw vertical marker lines and topoplot
x1 = [2.5 2.5];
x2 = [5 5];
x3 = [10 10];

% for topography 
load('ChanLabel.mat');

% setting config
cfg = [];
cfg.layout                      = 'GSN-HydroCel-129.sfp';
cfg.channel                     = {'all'};
lay                             = ft_prepare_layout(cfg);
cfg.zlim = colorscale; 
cfg.comment = 'no';
cfg.fontsize=12;
cfg.gridscale = 500;  
cfg.style = 'straight';
cfg.interactive='true';
cfg.layout = lay;


%% -----------------------------------------------------
% English Plot
% -----------------------------------------------------

% loading data (for entrainment plot)
aran_English_chan = squeeze(lwdata(1).data);
aran_English_FC=mean(aran_English_chan(electrodes, freqrange), 1); %FC for Fronto-Central electrodes we want to average

% loading data (for topography)
% load('aran_English_chan.mat');
aran_English_chan_ft=struct;
aran_English_chan_ft.avg=aran_English_chan;
aran_English_chan_ft.time=linspace(0,1000,30001);
aran_English_chan_ft.label=ChanLabel;
aran_English_chan_ft.dimord='chan_time';
save aran_English_chan_ft aran_English_chan_ft;

% plots frequency/entrainment data 
figure();
plot(Freqs(freqrange), aran_English_FC, 'LineWidth',1.5, 'Color','k'); %721 is the column number at which the value is 12Hz
title('ENGLISH');
ylim(limits);

% plots vertical lines
hold on
p = plot(x1,limits,x2,limits,x3,limits,'LineStyle','--');

% plotting topoplots inside
axes('Position', head25)
box on 
cfg.xlim=x1;   % Frequency to plot
ft_topoplotER(cfg, aran_English_chan_ft); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))

axes('Position', head5)
box on 
cfg.xlim=x2;   % Frequency to plot
ft_topoplotER(cfg, aran_English_chan_ft); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))
axes('Position', head10)

box on 
cfg.xlim=x3;   % Frequency to plot
ft_topoplotER(cfg, aran_English_chan_ft); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))

%% ---------------------------------------------------
% French plot 
% ---------------------------------------------------

% loading data (for entrainment plot)
aran_French_chan = squeeze(lwdata(2).data);
aran_French_FC=mean(aran_French_chan(electrodes, freqrange), 1); %FC for Fronto-Central electrodes we want to average

% loading data (for topography)
% load('aran_French_chan.mat');
aran_French_chan_ft=struct;
aran_French_chan_ft.avg=aran_French_chan;
aran_French_chan_ft.time=linspace(0,1000,30001);
aran_French_chan_ft.label=ChanLabel;
aran_French_chan_ft.dimord='chan_time';
save aran_French_chan_ft aran_French_chan_ft;

% plots frequency/entrainment data 
figure();
plot(Freqs(freqrange), aran_French_FC, 'LineWidth',1.5, 'Color','k'); %721 is the column number at which the value is 12Hz
title('FRENCH');
ylim(limits);

% plots vertical lines
hold on
p = plot(x1,limits,x2,limits,x3,limits,'LineStyle','--');

% plotting topoplots inside
axes('Position', head25)
box on 
cfg.xlim=x1;   % Frequency to plot
ft_topoplotER(cfg, aran_French_chan_ft); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))

axes('Position', head5)
box on 
cfg.xlim=x2;   % Frequency to plot
ft_topoplotER(cfg, aran_French_chan_ft); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))
axes('Position', head10)

box on 
cfg.xlim=x3;   % Frequency to plot
ft_topoplotER(cfg, aran_French_chan_ft); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))

%% ---------------------------------------------------
% Japanese plot 
% ---------------------------------------------------


% loading data (for entrainment plot)
aran_Japanese_chan = squeeze(lwdata(3).data);
aran_Japanese_FC=mean(aran_Japanese_chan(electrodes, freqrange), 1); %FC for Fronto-Central electrodes we want to average

% loading data (for topography)
% load('aran_Japanese_chan.mat');
aran_Japanese_chan_ft=struct;
aran_Japanese_chan_ft.avg=aran_Japanese_chan;
aran_Japanese_chan_ft.time=linspace(0,1000,30001);
aran_Japanese_chan_ft.label=ChanLabel;
aran_Japanese_chan_ft.dimord='chan_time';
save aran_Japanese_chan_ft aran_Japanese_chan_ft;

% plots frequency/entrainment data 
figure();
plot(Freqs(freqrange), aran_Japanese_FC, 'LineWidth',1.5, 'Color','k'); %721 is the column number at which the value is 12Hz
title('JAPANESE');
ylim(limits);

% plots vertical lines
hold on
p = plot(x1,limits,x2,limits,x3,limits,'LineStyle','--');

% plotting topoplots inside
axes('Position', head25)
box on 
cfg.xlim=x1;   % Frequency to plot
ft_topoplotER(cfg, aran_Japanese_chan_ft); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))

axes('Position', head5)
box on 
cfg.xlim=x2;   % Frequency to plot
ft_topoplotER(cfg, aran_Japanese_chan_ft); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))
axes('Position', head10)

box on 
cfg.xlim=x3;   % Frequency to plot
ft_topoplotER(cfg, aran_Japanese_chan_ft); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))




%% ---------------------------------------------------
% Polish plot 
% ---------------------------------------------------

% loading data (for entrainment plot)
aran_Polish_chan = squeeze(lwdata(4).data);
aran_Polish_FC=mean(aran_Polish_chan(electrodes, freqrange), 1); %FC for Fronto-Central electrodes we want to average

% loading data (for topography)
%load('aran_Polish_chan.mat');
aran_Polish_chan_ft=struct;
aran_Polish_chan_ft.avg=aran_Polish_chan;
aran_Polish_chan_ft.time=linspace(0,1000,30001);
aran_Polish_chan_ft.label=ChanLabel;
aran_Polish_chan_ft.dimord='chan_time';
save aran_Polish_chan_ft aran_Polish_chan_ft;

% plots frequency/entrainment data 
figure();
plot(Freqs(freqrange), aran_Polish_FC, 'LineWidth',1.5, 'Color','k');
title('POLISH');
ylim(limits);

% plots vertical lines
hold on
p = plot(x1,limits,x2,limits,x3,limits,'LineStyle','--');

% plotting topoplots inside
axes('Position', head25)
box on 
cfg.xlim=x1;   % Frequency to plot
ft_topoplotER(cfg, aran_Polish_chan_ft); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))

axes('Position', head5)
box on 
cfg.xlim=x2;   % Frequency to plot
ft_topoplotER(cfg, aran_Polish_chan_ft); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))
axes('Position', head10)

box on 
cfg.xlim=x3;   % Frequency to plot
ft_topoplotER(cfg, aran_Polish_chan_ft); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))


%% ---------------------------------------------------
% Vocoded plot 
% ---------------------------------------------------

% loading data (for entrainment plot)
aran_Vocoded_chan = squeeze(lwdata(5).data);
aran_Vocoded_FC=mean(aran_Vocoded_chan(electrodes, freqrange), 1); %FC for Fronto-Central electrodes we want to average

% loading data (for topography)
% load('aran_Vocoded_chan.mat');
aran_Vocoded_chan_ft=struct;
aran_Vocoded_chan_ft.avg=aran_Vocoded_chan;
aran_Vocoded_chan_ft.time=linspace(0,1000,30001);
aran_Vocoded_chan_ft.label=ChanLabel;
aran_Vocoded_chan_ft.dimord='chan_time';
save aran_Vocoded_chan_ft aran_Vocoded_chan_ft;

% plots frequency/entrainment data 
figure();
plot(Freqs(freqrange), aran_Vocoded_FC, 'LineWidth',1.5, 'Color','k'); %721 is the column number at which the value is 12Hz
title('VOCODED');
ylim(limits);

% plots vertical lines
hold on
p = plot(x1,limits,x2,limits,x3,limits,'LineStyle','--');

% plotting topoplots inside
axes('Position', head25)
box on 
cfg.xlim=x1;   % Frequency to plot
ft_topoplotER(cfg, aran_Vocoded_chan_ft); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))

axes('Position', head5)
box on 
cfg.xlim=x2;   % Frequency to plot
ft_topoplotER(cfg, aran_Vocoded_chan_ft); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))
axes('Position', head10)

box on 
cfg.xlim=x3;   % Frequency to plot
ft_topoplotER(cfg, aran_Vocoded_chan_ft); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))





















