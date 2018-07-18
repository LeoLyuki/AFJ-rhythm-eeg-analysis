% Grand average across subjects. 
% Compiled by Min Kim from scripts provided by Dr. Varghese Peter, July
% 2018.

%% One struct with one field per condition (language), grand average by condition
% -------------------------------------------------------------------------

All_subjects = struct;

% English
All_subjects.English = cat(3, bogdan_English_chan_ft.avg, motohashi_English_chan_ft.avg, ... 
    yam_English_chan_ft.avg, takeuchi_English_chan_ft.avg, takeda_English_chan_ft.avg, ...
    NJ_10_English_chan_ft.avg, NE_08_English_chan_ft.avg, matsui_English_chan_ft.avg, ...
    chin_English_chan_ft.avg, aran_English_chan_ft.avg);
GrandAverageEnglish = mean(All_subjects.English,3);

% French
All_subjects.French = cat(3, bogdan_French_chan_ft.avg, motohashi_French_chan_ft.avg, ...
    yam_French_chan_ft.avg, takeuchi_French_chan_ft.avg, takeda_French_chan_ft.avg, ...
    NJ_10_French_chan_ft.avg, NE_08_French_chan_ft.avg, matsui_French_chan_ft.avg, ...
    chin_French_chan_ft.avg, aran_French_chan_ft.avg);
GrandAverageFrench = mean(All_subjects.French,3);

% Japanese
All_subjects.Japanese = cat(3, bogdan_Japanese_chan_ft.avg, motohashi_Japanese_chan_ft.avg, ...
    yam_Japanese_chan_ft.avg, takeuchi_Japanese_chan_ft.avg, takeda_Japanese_chan_ft.avg, ...
    NJ_10_Japanese_chan_ft.avg, NE_08_Japanese_chan_ft.avg, matsui_Japanese_chan_ft.avg, ...
    chin_Japanese_chan_ft.avg, aran_Japanese_chan_ft.avg);
GrandAverageJapanese = mean(All_subjects.Japanese,3);

% Polish
All_subjects.Polish = cat(3, bogdan_Polish_chan_ft.avg, motohashi_Polish_chan_ft.avg, ...
    yam_Polish_chan_ft.avg, takeuchi_Polish_chan_ft.avg, takeda_Polish_chan_ft.avg, ...
    NJ_10_Polish_chan_ft.avg, NE_08_Polish_chan_ft.avg, matsui_Polish_chan_ft.avg, ...
    chin_Polish_chan_ft.avg, aran_Polish_chan_ft.avg);
GrandAveragePolish = mean(All_subjects.Polish,3);

% Vocoded
All_subjects.Vocoded = cat(3, bogdan_Vocoded_chan_ft.avg, motohashi_Vocoded_chan_ft.avg, ...
    yam_Vocoded_chan_ft.avg, takeuchi_Vocoded_chan_ft.avg, takeda_Vocoded_chan_ft.avg, ...
    NJ_10_Vocoded_chan_ft.avg, NE_08_Vocoded_chan_ft.avg, matsui_Vocoded_chan_ft.avg, ...
    chin_Vocoded_chan_ft.avg, aran_Vocoded_chan_ft.avg);
GrandAverageVocoded = mean(All_subjects.Vocoded,3);

%% Create one struct per language for topoplot purposes.
% -------------------------------------------------------------------------

% English
allEnglish = struct;
allEnglish.avg = GrandAverageEnglish;
allEnglish.time=linspace(0,1000,30001);
allEnglish.label=ChanLabel;
allEnglish.dimord='chan_time';

% French
allFrench = struct;
allFrench.avg = GrandAverageFrench;
allFrench.time=linspace(0,1000,30001);
allFrench.label=ChanLabel;
allFrench.dimord='chan_time';

% Japanese
allJapanese = struct;
allJapanese.avg = GrandAverageJapanese;
allJapanese.time=linspace(0,1000,30001);
allJapanese.label=ChanLabel;
allJapanese.dimord='chan_time';

% Polish
allPolish = struct;
allPolish.avg = GrandAveragePolish;
allPolish.time=linspace(0,1000,30001);
allPolish.label=ChanLabel;
allPolish.dimord='chan_time';

% Vocoded
allVocoded = struct;
allVocoded.avg = GrandAverageVocoded;
allVocoded.time=linspace(0,1000,30001);
allVocoded.label=ChanLabel;
allVocoded.dimord='chan_time';

%% Plotting grand average entrainment and topoplots
% -------------------------------------------------------------------------

% frequencies to draw vertical marker lines and topoplot
x1 = [2.5 2.5];
x2 = [5 5];
x3 = [10 10];

% -------------------------------------------------------------------------
% English
% -------------------------------------------------------------------------

ga_english_FC = mean(GrandAverageEnglish(electrodes, freqrange), 1);
figure();
plot(Freqs(freqrange), ga_english_FC, 'LineWidth',1.5, 'Color','k');
title('ENGLISH');
ylim(limits);

% plots vertical lines
hold on
p = plot(x1,limits,x2,limits,x3,limits,'LineStyle','--');

% plotting topoplots inside
axes('Position', head25)
box on 
cfg.xlim=x1;   
ft_topoplotER(cfg, allEnglish); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))

axes('Position', head5)
box on 
cfg.xlim=x2;   
ft_topoplotER(cfg, allEnglish); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))
axes('Position', head10)

box on 
cfg.xlim=x3;   
ft_topoplotER(cfg, allEnglish); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))

% -------------------------------------------------------------------------
% French
% -------------------------------------------------------------------------

ga_French_FC = mean(GrandAverageFrench(electrodes, freqrange), 1);
figure();
plot(Freqs(freqrange), ga_French_FC, 'LineWidth',1.5, 'Color','k');
title('FRENCH');
ylim(limits);

% plots vertical lines
hold on
p = plot(x1,limits,x2,limits,x3,limits,'LineStyle','--');

% plotting topoplots inside
axes('Position', head25)
box on 
cfg.xlim=x1;   
ft_topoplotER(cfg, allFrench); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))

axes('Position', head5)
box on 
cfg.xlim=x2;   
ft_topoplotER(cfg, allFrench); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))
axes('Position', head10)

box on 
cfg.xlim=x3;   
ft_topoplotER(cfg, allFrench); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))

% -------------------------------------------------------------------------
% Japanese
% -------------------------------------------------------------------------

ga_Japanese_FC = mean(GrandAverageJapanese(electrodes, freqrange), 1);
figure();
plot(Freqs(freqrange), ga_Japanese_FC, 'LineWidth',1.5, 'Color','k');
title('JAPANESE');
ylim(limits);

% plots vertical lines
hold on
p = plot(x1,limits,x2,limits,x3,limits,'LineStyle','--');

% plotting topoplots inside
axes('Position', head25)
box on 
cfg.xlim=x1;   
ft_topoplotER(cfg, allJapanese); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))

axes('Position', head5)
box on 
cfg.xlim=x2;   
ft_topoplotER(cfg, allJapanese); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))
axes('Position', head10)

box on 
cfg.xlim=x3;   
ft_topoplotER(cfg, allJapanese); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))

% -------------------------------------------------------------------------
% Polish
% -------------------------------------------------------------------------

ga_Polish_FC = mean(GrandAveragePolish(electrodes, freqrange), 1);
figure();
plot(Freqs(freqrange), ga_Polish_FC, 'LineWidth',1.5, 'Color','k');
title('POLISH');
ylim(limits);

% plots vertical lines
hold on
p = plot(x1,limits,x2,limits,x3,limits,'LineStyle','--');

% plotting topoplots inside
axes('Position', head25)
box on 
cfg.xlim=x1;   
ft_topoplotER(cfg, allPolish); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))

axes('Position', head5)
box on 
cfg.xlim=x2;   
ft_topoplotER(cfg, allPolish); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))
axes('Position', head10)

box on 
cfg.xlim=x3;   
ft_topoplotER(cfg, allPolish); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))

% -------------------------------------------------------------------------
% Vocoded
% -------------------------------------------------------------------------

ga_Vocoded_FC = mean(GrandAverageVocoded(electrodes, freqrange), 1);
figure();
plot(Freqs(freqrange), ga_Vocoded_FC, 'LineWidth',1.5, 'Color','k');
title('VOCODED');
ylim(limits);

% plots vertical lines
hold on
p = plot(x1,limits,x2,limits,x3,limits,'LineStyle','--');

% plotting topoplots inside
axes('Position', head25)
box on 
cfg.xlim=x1;   
ft_topoplotER(cfg, allVocoded); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))

axes('Position', head5)
box on 
cfg.xlim=x2;   
ft_topoplotER(cfg, allVocoded); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))
axes('Position', head10)

box on 
cfg.xlim=x3;   
ft_topoplotER(cfg, allVocoded); colormap; colorbar;
ft_hastoolbox('brewermap', 1);
colormap(flipud(brewermap(64,'RdBu')))

