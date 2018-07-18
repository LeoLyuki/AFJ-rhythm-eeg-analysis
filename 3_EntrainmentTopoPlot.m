% Plotting entrainment and EEG topography. (requires ChanLabel.mat)
% Compiled from scripts provided by Dr. Varghese Peter by Min Kim, June
% 2018. 

%% Removing Letswave from and adding Fieldtrip to MATLAB path
% -------------------------------------------------------------------------

rmpath(genpath('/Users/lln/Documents/MATLAB/letswave6-master'));

addpath('/Users/lln/Documents/MATLAB/fieldtrip-20171231');

%% Parameters to edit as necessary 
% -------------------------------------------------------------------------

% electrodes to be averaged together
electrodes = [24 19 11 4 124 29 20 12 5 118 111 7 30 13 6 112 105 106]; 

% frequencies reference
Freqs = linspace(0,1000,30001);

% frequencies range to plot (2 to 12 Hz)
freqrange = 61:361;

% min and max amplitude values for entrainment plot
limits = [-.15 .2];

% locations of topoplots within plot
head10 = [.675 .15 .2 .2];
head5 = [.35 .15 .2 .2];
head25 = [.15 .15 .2 .2];

% for topography, depends on peak amplitudes in data
colorscale = [-.13 .18];

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

%% English Plot
% -------------------------------------------------------------------------

% loading data (for entrainment plot)
bogdan_English_chan = squeeze(lwdata(1).data);
bogdan_English_FC=mean(bogdan_English_chan(electrodes, freqrange), 1); 

% loading data (for topography)
bogdan_English_chan_ft=struct;
bogdan_English_chan_ft.avg=bogdan_English_chan;
bogdan_English_chan_ft.time=linspace(0,1000,30001);
bogdan_English_chan_ft.label=ChanLabel;
bogdan_English_chan_ft.dimord='chan_time';
save bogdan_English_chan_ft bogdan_English_chan_ft;

% plots frequency/entrainment data 
figure();
plot(Freqs(freqrange), bogdan_English_FC, 'LineWidth',1.5, 'Color','k'); 
title('ENGLISH');
ylim(limits);

% plots vertical lines
hold on
p = plot(x1,limits,x2,limits,x3,limits,'LineStyle','--');

% plotting topoplots inside
axes('Position', head25)
box on 
cfg.xlim=x1;   
ft_topoplotER(cfg, bogdan_English_chan_ft); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))

axes('Position', head5)
box on 
cfg.xlim=x2;   
ft_topoplotER(cfg, bogdan_English_chan_ft); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))
axes('Position', head10)

box on 
cfg.xlim=x3;  
ft_topoplotER(cfg, bogdan_English_chan_ft); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))

%% French plot 
% -------------------------------------------------------------------------

% loading data (for entrainment plot)
bogdan_French_chan = squeeze(lwdata(2).data);
bogdan_French_FC=mean(bogdan_French_chan(electrodes, freqrange), 1); 

% loading data (for topography)
bogdan_French_chan_ft=struct;
bogdan_French_chan_ft.avg=bogdan_French_chan;
bogdan_French_chan_ft.time=linspace(0,1000,30001);
bogdan_French_chan_ft.label=ChanLabel;
bogdan_French_chan_ft.dimord='chan_time';
save bogdan_French_chan_ft bogdan_French_chan_ft;

% plots frequency/entrainment data 
figure();
plot(Freqs(freqrange), bogdan_French_FC, 'LineWidth',1.5, 'Color','k'); 
title('FRENCH');
ylim(limits);

% plots vertical lines
hold on
p = plot(x1,limits,x2,limits,x3,limits,'LineStyle','--');

% plotting topoplots inside
axes('Position', head25)
box on 
cfg.xlim=x1;  
ft_topoplotER(cfg, bogdan_French_chan_ft); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))

axes('Position', head5)
box on 
cfg.xlim=x2;   
ft_topoplotER(cfg, bogdan_French_chan_ft); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))
axes('Position', head10)

box on 
cfg.xlim=x3;   
ft_topoplotER(cfg, bogdan_French_chan_ft); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))

%% Japanese plot 
% -------------------------------------------------------------------------

% loading data (for entrainment plot)
bogdan_Japanese_chan = squeeze(lwdata(3).data);
bogdan_Japanese_FC=mean(bogdan_Japanese_chan(electrodes, freqrange), 1); 

% loading data (for topography)
bogdan_Japanese_chan_ft=struct;
bogdan_Japanese_chan_ft.avg=bogdan_Japanese_chan;
bogdan_Japanese_chan_ft.time=linspace(0,1000,30001);
bogdan_Japanese_chan_ft.label=ChanLabel;
bogdan_Japanese_chan_ft.dimord='chan_time';
save bogdan_Japanese_chan_ft bogdan_Japanese_chan_ft;

% plots frequency/entrainment data 
figure();
plot(Freqs(freqrange), bogdan_Japanese_FC, 'LineWidth',1.5, 'Color','k'); 
title('JAPANESE');
ylim(limits);

% plots vertical lines
hold on
p = plot(x1,limits,x2,limits,x3,limits,'LineStyle','--');

% plotting topoplots inside
axes('Position', head25)
box on 
cfg.xlim=x1;   
ft_topoplotER(cfg, bogdan_Japanese_chan_ft); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))

axes('Position', head5)
box on 
cfg.xlim=x2;   
ft_topoplotER(cfg, bogdan_Japanese_chan_ft); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))
axes('Position', head10)

box on 
cfg.xlim=x3;   
ft_topoplotER(cfg, bogdan_Japanese_chan_ft); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))




%% Polish plot 
% -------------------------------------------------------------------------

% loading data (for entrainment plot)
bogdan_Polish_chan = squeeze(lwdata(4).data);
bogdan_Polish_FC=mean(bogdan_Polish_chan(electrodes, freqrange), 1); 

% loading data (for topography)
bogdan_Polish_chan_ft=struct;
bogdan_Polish_chan_ft.avg=bogdan_Polish_chan;
bogdan_Polish_chan_ft.time=linspace(0,1000,30001);
bogdan_Polish_chan_ft.label=ChanLabel;
bogdan_Polish_chan_ft.dimord='chan_time';
save bogdan_Polish_chan_ft bogdan_Polish_chan_ft;

% plots frequency/entrainment data 
figure();
plot(Freqs(freqrange), bogdan_Polish_FC, 'LineWidth',1.5, 'Color','k');
title('POLISH');
ylim(limits);

% plots vertical lines
hold on
p = plot(x1,limits,x2,limits,x3,limits,'LineStyle','--');

% plotting topoplots inside
axes('Position', head25)
box on 
cfg.xlim=x1;   
ft_topoplotER(cfg, bogdan_Polish_chan_ft); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))

axes('Position', head5)
box on 
cfg.xlim=x2;   
ft_topoplotER(cfg, bogdan_Polish_chan_ft); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))
axes('Position', head10)

box on 
cfg.xlim=x3;  
ft_topoplotER(cfg, bogdan_Polish_chan_ft); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))


%% Vocoded plot 
% -------------------------------------------------------------------------

% loading data (for entrainment plot)
bogdan_Vocoded_chan = squeeze(lwdata(5).data);
bogdan_Vocoded_FC=mean(bogdan_Vocoded_chan(electrodes, freqrange), 1); %FC for Fronto-Central electrodes we want to average

% loading data (for topography)
bogdan_Vocoded_chan_ft=struct;
bogdan_Vocoded_chan_ft.avg=bogdan_Vocoded_chan;
bogdan_Vocoded_chan_ft.time=linspace(0,1000,30001);
bogdan_Vocoded_chan_ft.label=ChanLabel;
bogdan_Vocoded_chan_ft.dimord='chan_time';
save bogdan_Vocoded_chan_ft bogdan_Vocoded_chan_ft;

% plots frequency/entrainment data 
figure();
plot(Freqs(freqrange), bogdan_Vocoded_FC, 'LineWidth',1.5, 'Color','k'); 
title('VOCODED');
ylim(limits);

% plots vertical lines
hold on
p = plot(x1,limits,x2,limits,x3,limits,'LineStyle','--');

% plotting topoplots inside
axes('Position', head25)
box on 
cfg.xlim=x1;   
ft_topoplotER(cfg, bogdan_Vocoded_chan_ft); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))

axes('Position', head5)
box on 
cfg.xlim=x2;   
ft_topoplotER(cfg, bogdan_Vocoded_chan_ft); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))
axes('Position', head10)

box on 
cfg.xlim=x3;   
ft_topoplotER(cfg, bogdan_Vocoded_chan_ft); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))
