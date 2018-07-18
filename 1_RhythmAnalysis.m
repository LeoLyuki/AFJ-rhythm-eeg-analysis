% Rhythm Analysis using FieldTrip toolbox. (requires Rhythm_trialfun.m)
% Script provided by Dr. Varghese Peter, edited by Dr. Leo-Lyuki Nishibayashi
% and Min Kim, June 2018.

%% 1. Configuration  
% -------------------------------------------------------------------------

cfg                             =[];
cfg.layout                      = 'GSN-HydroCel-129.sfp';
cfg.channel                     = {'all'};
lay                             = ft_prepare_layout(cfg);
cfg                             = [];
cfg_neighb.layout               = lay;
cfg_neighb.method               = 'triangulation';
cfg.feedback                    = 'yes';
EEG_neighbours                  = ft_prepare_neighbours(cfg_neighb);

%% 2. Plotting the channels
% -------------------------------------------------------------------------

cfg                             = [];
cfg.neighbours                  = EEG_neighbours;
cfg.senstype                    = 'EEG';
cfg.layout                      = lay; 
ft_neighbourplot(cfg); 

%% 3. Loading and filtering the data
% -------------------------------------------------------------------------

cfg                             = [];
cfg.dataset                     = 'bogdan.raw'; % use command + F to change the subject name everywhere
cfg.continuous                  = 'yes';

% Filtering between 0.3 to 30 Hz
cfg.bpfilter                    = 'yes';
cfg.bpfilttype                  = 'firws'; 
cfg.lpfiltdir                   = 'onepass-zerophase';
cfg.bpfreq                      = [0.3 30]; 
cfg.channel                     = 'EEG';
bogdan_cont                = ft_preprocessing(cfg); 
save bogdan_cont bogdan_cont;

% Plotting the filtered data
cfg=[]; 
ft_databrowser(cfg,bogdan_cont);

%% 4. Epoching the data 
% -------------------------------------------------------------------------

cfg                             = [];
cfg.dataset                     = 'bogdan.raw'; % datafile to read events from
cfg.trialdef.prestim            = 0;
cfg.trialdef.poststim           = 30; 
cfg.trialfun                    = 'Rhythm_trialfun';
bogdan_cfg                 = ft_definetrial(cfg);
bogdan_epochs              = ft_redefinetrial(bogdan_cfg, bogdan_cont);
save bogdan_epochs bogdan_epochs;

% Plotting the epoched data
cfg=[];
ft_databrowser(cfg,bogdan_epochs);

%% 5. < 500 microV criterion
% -------------------------------------------------------------------------

cfg                             = [];
cfg.channel                     = {'all'};
cfg.method                      = 'summary';
bogdan_epochs2_clean       = ft_rejectvisual(cfg, bogdan_epochs);  
save bogdan_epochs2_clean bogdan_epochs2_clean

%% Optional: Plotting the data post <500 microV rejection
% -------------------------------------------------------------------------

cfg=[];
ft_databrowser(cfg,bogdan_epochs2_clean);

%% 6. ICA
% -------------------------------------------------------------------------

cfg                             = [];
cfg.channel                     = {'all'};
cfg.runica.pca                  = 40;
bogdan_epochs2_ICA         = ft_componentanalysis(cfg,bogdan_epochs2_clean);
save bogdan_epochs2_ICA bogdan_epochs2_ICA

% Plot and identify noisy components
cfg                             = [];
cfg.component                   = [1:20];       
cfg.layout                      = lay; 
cfg.comment                     = 'no';
ft_topoplotIC(cfg, bogdan_epochs2_ICA)

%% 7. Reject eye blink/movement components
% -------------------------------------------------------------------------

cfg                             =[];

% IMPORTANT: Change this value based on the eye blink/eye movement component number
cfg.component                   =[5 6]; 

bogdan_epochs2_ICA_clean   = ft_rejectcomponent(cfg,bogdan_epochs2_ICA);
save bogdan_epochs2_ICA_clean bogdan_epochs2_ICA_clean

% Interpolate removed channels
badchannels                     = setdiff(lay.label, bogdan_epochs2_ICA_clean.label);
cfg                             = [];
cfg.layout                      = lay;
cfg.neighbours                  = EEG_neighbours;
cfg.badchannel                  = badchannels;
cfg.method                      ='spline';
cfg.senstype                    = 'EEG';
bogdan_epochs2_interp   = ft_channelrepair(cfg, bogdan_epochs2_ICA_clean);

%% Optional: Plotting interpolated data
% -------------------------------------------------------------------------

cfg=[];
ft_databrowser(cfg,bogdan_epochs2_interp);

%% 8. < 100 microV criterion
% -------------------------------------------------------------------------

% IMPORTANT: Don't remove channels now
cfg                             = [];
cfg.channel                     = {'all'};
cfg.method                      = 'summary';
bogdan_clean2       = ft_rejectvisual(cfg, bogdan_epochs2_interp);  
save bogdan_clean2 bogdan_clean2

%% 9. Rereferencing all channels to the average
% -------------------------------------------------------------------------

cfg                             = [];
cfg.reref                       = 'yes';
cfg.refchannel                  = {'all'};
bogdan_epochs_AVG_reref             = ft_preprocessing(cfg, bogdan_clean2);

% Averaging
if length(find(bogdan_epochs_AVG_reref.trialinfo==2))~=0
    s1=length(find(bogdan_epochs_AVG_reref.trialinfo==2));
    cfg                         = [];
    cfg.trials                  = find(bogdan_epochs_AVG_reref.trialinfo==2);
    bogdan_Eng_AVG_ERP          = ft_timelockanalysis(cfg, bogdan_epochs_AVG_reref);
    save bogdan_Eng_AVG_ERP bogdan_Eng_AVG_ERP
else
    s1=0;
end
if length(find(bogdan_epochs_AVG_reref.trialinfo==6))~=0
    s2=length(find(bogdan_epochs_AVG_reref.trialinfo==6));
    cfg                         = [];
    cfg.trials                  = find(bogdan_epochs_AVG_reref.trialinfo==6);
    bogdan_French_AVG_ERP          = ft_timelockanalysis(cfg, bogdan_epochs_AVG_reref);
    save bogdan_French_AVG_ERP bogdan_French_AVG_ERP
else
    s2=0;
end
if length(find(bogdan_epochs_AVG_reref.trialinfo==10))~=0
    s3=length(find(bogdan_epochs_AVG_reref.trialinfo==10));
    cfg                         = [];
    cfg.trials                  = find(bogdan_epochs_AVG_reref.trialinfo==10);
    bogdan_Japanese_AVG_ERP         = ft_timelockanalysis(cfg, bogdan_epochs_AVG_reref);
    save bogdan_Japanese_AVG_ERP bogdan_Japanese_AVG_ERP
else
    s3=0;
end
if length(find(bogdan_epochs_AVG_reref.trialinfo==14))~=0
    s4=length(find(bogdan_epochs_AVG_reref.trialinfo==14));
    cfg                         = [];
    cfg.trials                  = find(bogdan_epochs_AVG_reref.trialinfo==14);
    bogdan_Polish_AVG_ERP         = ft_timelockanalysis(cfg, bogdan_epochs_AVG_reref);
    save bogdan_Polish_AVG_ERP bogdan_Polish_AVG_ERP
else
    s4=0;
end
if length(find(bogdan_epochs_AVG_reref.trialinfo==20))~=0
    s5=length(find(bogdan_epochs_AVG_reref.trialinfo==20));
    cfg                         = [];
    cfg.trials                  = find(bogdan_epochs_AVG_reref.trialinfo==20);
    bogdan_Vocoded_AVG_ERP         = ft_timelockanalysis(cfg, bogdan_epochs_AVG_reref);
    save bogdan_Vocoded_AVG_ERP bogdan_Vocoded_AVG_ERP
else
    s5=0;
end

bogdan_ft_Data                     =[s1 s2 s3 s4 s5];
 
save bogdan_Data bogdan_ft_Data
