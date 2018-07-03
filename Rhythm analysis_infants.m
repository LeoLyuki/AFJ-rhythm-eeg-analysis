cfg                             =[];
cfg.layout                      = 'GSN-HydroCel-129.sfp';
cfg.channel                     = {'all'};
lay                             = ft_prepare_layout(cfg);
cfg                             = [];
cfg_neighb.layout               = lay;
cfg_neighb.method               = 'triangulation';
cfg.feedback                    = 'yes';
EEG_neighbours                  = ft_prepare_neighbours(cfg_neighb);
%
% Loading the data
cfg                             = [];
cfg.dataset                     = 'leo.raw'; % use control+H to change the subject name everywhere
cfg.continuous                  = 'yes';
% filtering between 0.3 to 30 Hz
cfg.bpfilter                    = 'yes';
cfg.bpfilttype                  = 'firws'; 
cfg.lpfiltdir                   = 'onepass-zerophase';
cfg.bpfreq                      = [0.3 30]; % Hz
cfg.channel                     = 'EEG';
leo_cont                = ft_preprocessing(cfg); 
% save leo_cont leo_cont;
% Epochs data
cfg                             = [];
cfg.dataset                     = 'leo.raw'; % datafile to read events from
cfg.trialdef.prestim            = 0;
cfg.trialdef.poststim           = 30; 
cfg.trialfun                    = 'Rhythm_trialfun';
% cfg.trialdef.eventvalue       = {'D253', 'D221'}; [2 3 4];
leo_cfg                 = ft_definetrial(cfg);
leo_epochs              = ft_redefinetrial(leo_cfg, leo_cont);
save leo_epochs leo_epochs;
% resample the data to 250 Hz
cfg                             = [];
cfg.resamplefs                  = 250;
leo_epochs2             = ft_resampledata(cfg, leo_epochs);

indx                            = 1;
BadChannelCriterion             = 100; % change this no if required
BadChannelNoCriterion           = 20;
AllTrialsBadChannelLabels       = {};
datr                            = {};
TrialNos                        = [];
for loop                        = 1:length(leo_epochs2.trial)
    % identify bad channels >100 microvolt
    BadChannels1                = find(max(abs(leo_epochs2.trial{loop}),[],2)>BadChannelCriterion);
    % ifdentify flat channels
    dat                         = (abs(leo_epochs2.trial{loop}));
    row_has_all_zeros           = ~any(dat, 2);
    BadChannels2                = find (row_has_all_zeros);
     if (length(BadChannels1)+length(BadChannels2))<BadChannelNoCriterion     
            BadchannelIndex     = [BadChannels1;BadChannels2];
            BadchannelLabels    = leo_epochs2.label(BadchannelIndex);
            cfg                 = [];
            cfg.layout          = lay;
            cfg.badchannel      = BadchannelLabels;
            cfg.method          = 'spline';
            cfg.neighbours      = EEG_neighbours;
            cfg.trials          = loop;
            datr{indx}          = ft_channelrepair(cfg,leo_epochs2);
            TrialNos(indx)      = loop;
            indx                = indx+1;
     end
end
cfg                             = [];
leo_clean2             = ft_appenddata(cfg, datr{:});
leo_clean2.cfg         = [];
save leo_clean2 leo_clean2;
%
% reref
cfg                             = [];
cfg.reref                       = 'yes';
cfg.refchannel                  = {'all'};
leo_epochs_AVG_reref             = ft_preprocessing(cfg, leo_clean2);
% Averaging
if length(find(leo_epochs_AVG_reref.trialinfo==2))~=0
    s1=length(find(leo_epochs_AVG_reref.trialinfo==2));
    cfg                         = [];
    cfg.trials                  = find(leo_epochs_AVG_reref.trialinfo==2);
    leo_Eng_AVG_ERP          = ft_timelockanalysis(cfg, leo_epochs_AVG_reref);
    save leo_Eng_AVG_ERP leo_Eng_AVG_ERP
else
    s1=0;
end
if length(find(leo_epochs_AVG_reref.trialinfo==6))~=0
    s2=length(find(leo_epochs_AVG_reref.trialinfo==6));
    cfg                         = [];
    cfg.trials                  = find(leo_epochs_AVG_reref.trialinfo==6);
    leo_French_AVG_ERP          = ft_timelockanalysis(cfg, leo_epochs_AVG_reref);
    save leo_French_AVG_ERP leo_French_AVG_ERP
else
    s2=0;
end
if length(find(leo_epochs_AVG_reref.trialinfo==10))~=0
    s3=length(find(leo_epochs_AVG_reref.trialinfo==10));
    cfg                         = [];
    cfg.trials                  = find(leo_epochs_AVG_reref.trialinfo==10);
    leo_Japanese_AVG_ERP         = ft_timelockanalysis(cfg, leo_epochs_AVG_reref);
    save leo_Japanese_AVG_ERP leo_Japanese_AVG_ERP
else
    s3=0;
end
if length(find(leo_epochs_AVG_reref.trialinfo==14))~=0
    s4=length(find(leo_epochs_AVG_reref.trialinfo==14));
    cfg                         = [];
    cfg.trials                  = find(leo_epochs_AVG_reref.trialinfo==14);
    leo_Polish_AVG_ERP         = ft_timelockanalysis(cfg, leo_epochs_AVG_reref);
    save leo_Polish_AVG_ERP leo_Polish_AVG_ERP
else
    s4=0;
end
if length(find(leo_epochs_AVG_reref.trialinfo==20))~=0
    s5=length(find(leo_epochs_AVG_reref.trialinfo==20));
    cfg                         = [];
    cfg.trials                  = find(leo_epochs_AVG_reref.trialinfo==20);
    leo_Vocoded_AVG_ERP         = ft_timelockanalysis(cfg, leo_epochs_AVG_reref);
    save leo_Vocoded_AVG_ERP leo_Vocoded_AVG_ERP
else
    s5=0;
end

leo_ft_Data                     =[s1 s2 s3 s4 s5];
 
save leo_Data leo_ft_Data
clear all;

%% reref to MS
% If you don't want to re reference to mastoids, remove this
cfg                             = [];
cfg.reref                       = 'yes';
cfg.refchannel                  = {'E57' 'E100'};
leo_epochs_MS_reref             = ft_preprocessing(cfg, leo_clean2);
% Averaging
if length(find(leo_epochs_MS_reref.trialinfo==2))~=0
    s1=length(find(leo_epochs_MS_reref.trialinfo==2));
    cfg                         = [];
    cfg.trials                  = find(leo_epochs_MS_reref.trialinfo==2);
    leo_Eng_MS_ERP          = ft_timelockanalysis(cfg, leo_epochs_MS_reref);
    save leo_Eng_MS_ERP leo_Eng_MS_ERP
else
    s1=0;
end
if length(find(leo_epochs_MS_reref.trialinfo==6))~=0
    s2=length(find(leo_epochs_MS_reref.trialinfo==6));
    cfg                         = [];
    cfg.trials                  = find(leo_epochs_MS_reref.trialinfo==6);
    leo_French_MS_ERP          = ft_timelockanalysis(cfg, leo_epochs_MS_reref);
    save leo_French_MS_ERP leo_French_MS_ERP
else
    s2=0;
end
if length(find(leo_epochs_MS_reref.trialinfo==10))~=0
    s3=length(find(leo_epochs_MS_reref.trialinfo==10));
    cfg                         = [];
    cfg.trials                  = find(leo_epochs_MS_reref.trialinfo==10);
    leo_Japanese_MS_ERP         = ft_timelockanalysis(cfg, leo_epochs_MS_reref);
    save leo_Japanese_MS_ERP leo_Japanese_MS_ERP
else
    s3=0;
end
if length(find(leo_epochs_MS_reref.trialinfo==14))~=0
    s4=length(find(leo_epochs_MS_reref.trialinfo==14));
    cfg                         = [];
    cfg.trials                  = find(leo_epochs_MS_reref.trialinfo==14);
    leo_Polish_MS_ERP         = ft_timelockanalysis(cfg, leo_epochs_MS_reref);
    save leo_Polish_MS_ERP leo_Polish_MS_ERP
else
    s4=0;
end
if length(find(leo_epochs_MS_reref.trialinfo==20))~=0
    s5=length(find(leo_epochs_MS_reref.trialinfo==20));
    cfg                         = [];
    cfg.trials                  = find(leo_epochs_MS_reref.trialinfo==20);
    leo_Vocoded_MS_ERP         = ft_timelockanalysis(cfg, leo_epochs_MS_reref);
    save leo_Vocoded_MS_ERP leo_Vocoded_MS_ERP
else
    s5=0;
end