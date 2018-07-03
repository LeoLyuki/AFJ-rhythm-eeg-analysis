cfg                             =[];
cfg.layout                      = 'GSN-HydroCel-129.sfp';
cfg.channel                     = {'all'};
lay                             = ft_prepare_layout(cfg);
cfg                             = [];
cfg_neighb.layout               = lay;
cfg_neighb.method               = 'triangulation';
cfg.feedback                    = 'yes';
EEG_neighbours                  = ft_prepare_neighbours(cfg_neighb);
% (added, not in orig script) 
%% plots channels, size of channel indicates # neighbors (the bigger, the more neighbors)
% clicking a channel gives its name and its neighbors in command window 
cfg                             = [];
cfg.neighbours                  = EEG_neighbours;
cfg.senstype                    = 'EEG';
cfg.layout                      = lay; 
ft_neighbourplot(cfg); 


%% Loading the data
cfg                             = [];
cfg.dataset                     = 'Min2.raw'; % use control+H to change the subject name everywhere
cfg.continuous                  = 'yes';
% filtering between 0.3 to 30 Hz
cfg.bpfilter                    = 'yes';
cfg.bpfilttype                  = 'firws'; 
cfg.lpfiltdir                   = 'onepass-zerophase';
cfg.bpfreq                      = [0.3 30]; % Hz
cfg.channel                     = 'EEG';
Min2_cont                = ft_preprocessing(cfg); 
save Min2_cont Min2_cont;

%% plotting the filtered data

cfg=[]; % default parameters, clears settings from before
ft_databrowser(cfg,Min2_cont);




%% Epochs data
cfg                             = [];
cfg.dataset                     = 'Min2.raw'; % datafile to read events from
cfg.trialdef.prestim            = 0;
cfg.trialdef.poststim           = 30; 
cfg.trialfun                    = 'Rhythm_trialfun';
% cfg.trialdef.eventvalue       = [3 4 5]; 
Min2_cfg                 = ft_definetrial(cfg);
Min2_epochs              = ft_redefinetrial(Min2_cfg, Min2_cont);
save Min2_epochs Min2_epochs;

% epoched data browser
cfg=[];
ft_databrowser(cfg,Min2_epochs);


% resample the data to 250 Hz
% cfg                             = [];
% cfg.resamplefs                  = 250;
% Min2_epochs2             = ft_resampledata(cfg, Min2_epochs);

% Baseline correction
% cfg                             = [];
% cfg.demean                      = 'yes';
% cfg.baselinewindow              = [-0.1 0];
% Min2_epochs2_bs          = ft_preprocessing(cfg, Min2_epochs2);

%% Detecting bad trials and channels (criterion 500 microvolt)
cfg                             = [];
cfg.channel                     = {'all'};
cfg.method                      = 'summary';
Min2_epochs2_clean       = ft_rejectvisual(cfg, Min2_epochs);  
save Min2_epochs2_clean Min2_epochs2_clean
%don't forget to check the 'MaxAbs' box!
%%
cfg=[];
ft_databrowser(cfg,Min2_epochs2_clean);

%% ICA
cfg                             = [];
cfg.channel                     = {'all'};
cfg.runica.pca                  = 40;
Min2_epochs2_ICA         = ft_componentanalysis(cfg,Min2_epochs2_clean);
save Min2_epochs2_ICA Min2_epochs2_ICA
% Plot and identify noisy components
cfg                             = [];
cfg.component                   = [1:10];       % specify the component(s) that should be plotted
cfg.layout                      = lay; % specify the layout file that should be used for plotting
cfg.comment                     = 'no';
ft_topoplotIC(cfg, Min2_epochs2_ICA)
%% Remove noisy components
cfg                             =[];
cfg.component                   =[1];% IMPORTANT: Change this value based on the eye blink/eye movement component number
Min2_epochs2_ICA_clean   = ft_rejectcomponent(cfg,Min2_epochs2_ICA);
save Min2_epochs2_ICA_clean Min2_epochs2_ICA_clean
% interpolate removed channels
badchannels                     = setdiff(lay.label, Min2_epochs2_ICA_clean.label);
cfg                             = [];
cfg.layout                      = lay;
cfg.neighbours                  = EEG_neighbours;
cfg.badchannel                  = badchannels;
cfg.method                      ='spline';
cfg.senstype                    = 'EEG';
Min2_epochs2_interp   = ft_channelrepair(cfg, Min2_epochs2_ICA_clean);

cfg=[];
ft_databrowser(cfg,Min2_epochs2_interp);

%% Remove bad trials (criterion 100 microvolt)
%F*** IMPORTANT don't forget to check the 'MaxAbs' box!
% IMPORTANT: Don't remove channels now
cfg                             = [];
cfg.channel                     = {'all'};
cfg.method                      = 'summary';
Min2_clean2       = ft_rejectvisual(cfg, Min2_epochs2_interp);  
save Min2_clean2 Min2_clean2

%%
% reref
cfg                             = [];
cfg.reref                       = 'yes';
cfg.refchannel                  = {'all'};
Min2_epochs_AVG_reref             = ft_preprocessing(cfg, Min2_clean2);
% Averaging
if length(find(Min2_epochs_AVG_reref.trialinfo==2))~=0
    s1=length(find(Min2_epochs_AVG_reref.trialinfo==2));
    cfg                         = [];
    cfg.trials                  = find(Min2_epochs_AVG_reref.trialinfo==2);
    Min2_Eng_AVG_ERP          = ft_timelockanalysis(cfg, Min2_epochs_AVG_reref);
    save Min2_Eng_AVG_ERP Min2_Eng_AVG_ERP
else
    s1=0;
end
if length(find(Min2_epochs_AVG_reref.trialinfo==6))~=0
    s2=length(find(Min2_epochs_AVG_reref.trialinfo==6));
    cfg                         = [];
    cfg.trials                  = find(Min2_epochs_AVG_reref.trialinfo==6);
    Min2_French_AVG_ERP          = ft_timelockanalysis(cfg, Min2_epochs_AVG_reref);
    save Min2_French_AVG_ERP Min2_French_AVG_ERP
else
    s2=0;
end
if length(find(Min2_epochs_AVG_reref.trialinfo==10))~=0
    s3=length(find(Min2_epochs_AVG_reref.trialinfo==10));
    cfg                         = [];
    cfg.trials                  = find(Min2_epochs_AVG_reref.trialinfo==10);
    Min2_Japanese_AVG_ERP         = ft_timelockanalysis(cfg, Min2_epochs_AVG_reref);
    save Min2_Japanese_AVG_ERP Min2_Japanese_AVG_ERP
else
    s3=0;
end
if length(find(Min2_epochs_AVG_reref.trialinfo==14))~=0
    s4=length(find(Min2_epochs_AVG_reref.trialinfo==14));
    cfg                         = [];
    cfg.trials                  = find(Min2_epochs_AVG_reref.trialinfo==14);
    Min2_Polish_AVG_ERP         = ft_timelockanalysis(cfg, Min2_epochs_AVG_reref);
    save Min2_Polish_AVG_ERP Min2_Polish_AVG_ERP
else
    s4=0;
end
if length(find(Min2_epochs_AVG_reref.trialinfo==20))~=0
    s5=length(find(Min2_epochs_AVG_reref.trialinfo==20));
    cfg                         = [];
    cfg.trials                  = find(Min2_epochs_AVG_reref.trialinfo==20);
    Min2_Vocoded_AVG_ERP         = ft_timelockanalysis(cfg, Min2_epochs_AVG_reref);
    save Min2_Vocoded_AVG_ERP Min2_Vocoded_AVG_ERP
else
    s5=0;
end

Min2_ft_Data                     =[s1 s2 s3 s4 s5];
 
save Min2_Data Min2_ft_Data


%% reref to MS
cfg                             = [];
cfg.reref                       = 'yes';
cfg.refchannel                  = {'E57' 'E100'};
Min2_epochs_MS_reref             = ft_preprocessing(cfg, Min2_clean2);
% Averaging
if length(find(Min2_epochs_MS_reref.trialinfo==2))~=0
    s1=length(find(Min2_epochs_MS_reref.trialinfo==2));
    cfg                         = [];
    cfg.trials                  = find(Min2_epochs_MS_reref.trialinfo==2);
    Min2_Eng_MS_ERP          = ft_timelockanalysis(cfg, Min2_epochs_MS_reref);
    save Min2_Eng_MS_ERP Min2_Eng_MS_ERP
else
    s1=0;
end
if length(find(Min2_epochs_MS_reref.trialinfo==6))~=0
    s2=length(find(Min2_epochs_MS_reref.trialinfo==6));
    cfg                         = [];
    cfg.trials                  = find(Min2_epochs_MS_reref.trialinfo==6);
    Min2_French_MS_ERP          = ft_timelockanalysis(cfg, Min2_epochs_MS_reref);
    save Min2_French_MS_ERP Min2_French_MS_ERP
else
    s2=0;
end
if length(find(Min2_epochs_MS_reref.trialinfo==10))~=0
    s3=length(find(Min2_epochs_MS_reref.trialinfo==10));
    cfg                         = [];
    cfg.trials                  = find(Min2_epochs_MS_reref.trialinfo==10);
    Min2_Japanese_MS_ERP         = ft_timelockanalysis(cfg, Min2_epochs_MS_reref);
    save Min2_Japanese_MS_ERP Min2_Japanese_MS_ERP
else
    s3=0;
end
if length(find(Min2_epochs_MS_reref.trialinfo==14))~=0
    s4=length(find(Min2_epochs_MS_reref.trialinfo==14));
    cfg                         = [];
    cfg.trials                  = find(Min2_epochs_MS_reref.trialinfo==14);
    Min2_Polish_MS_ERP         = ft_timelockanalysis(cfg, Min2_epochs_MS_reref);
    save Min2_Polish_MS_ERP Min2_Polish_MS_ERP
else
    s4=0;
end
if length(find(Min2_epochs_MS_reref.trialinfo==20))~=0
    s5=length(find(Min2_epochs_MS_reref.trialinfo==20));
    cfg                         = [];
    cfg.trials                  = find(Min2_epochs_MS_reref.trialinfo==20);
    Min2_Vocoded_MS_ERP         = ft_timelockanalysis(cfg, Min2_epochs_MS_reref);
    save Min2_Vocoded_MS_ERP Min2_Vocoded_MS_ERP
else
    s5=0;
end
 
Min2_ft_Data                     =[s1 s2 s3 s4 s5];
 
save Min2_Data Min2_ft_Data







