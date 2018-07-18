% Reordering the channels for use outside of FieldTrip (in Letswave) and averaging.

%% Fixing channel order.
% -------------------------------------------------------------------------

% English
test=squeeze(str2num(char(regexprep(bogdan_Eng_AVG_ERP.label(1:129), 'E',''))));
test2=[test bogdan_Eng_AVG_ERP.avg(1:129,:)];
test2=sortrows(test2,1);
bogdan_English_AVG_ERP_chancorr=test2(:,[2:30002]);
save bogdan_English_AVG_ERP_chancorr bogdan_English_AVG_ERP_chancorr

% French
test=squeeze(str2num(char(regexprep(bogdan_French_AVG_ERP.label(1:129), 'E',''))));
test2=[test bogdan_French_AVG_ERP.avg(1:129,:)];
test2=sortrows(test2,1);
bogdan_French_AVG_ERP_chancorr=test2(:,[2:30002]);
save bogdan_French_AVG_ERP_chancorr bogdan_French_AVG_ERP_chancorr

% Japanese
test=squeeze(str2num(char(regexprep(bogdan_Japanese_AVG_ERP.label(1:129), 'E',''))));
test2=[test bogdan_Japanese_AVG_ERP.avg(1:129,:)];
test2=sortrows(test2,1);
bogdan_Japanese_AVG_ERP_chancorr=test2(:,[2:30002]);
save bogdan_Japanese_AVG_ERP_chancorr bogdan_Japanese_AVG_ERP_chancorr

% Polish
test=squeeze(str2num(char(regexprep(bogdan_Polish_AVG_ERP.label(1:129), 'E',''))));
test2=[test bogdan_Polish_AVG_ERP.avg(1:129,:)];
test2=sortrows(test2,1);
bogdan_Polish_AVG_ERP_chancorr=test2(:,[2:30002]);
save bogdan_Polish_AVG_ERP_chancorr bogdan_Polish_AVG_ERP_chancorr

% Vocoded
test=squeeze(str2num(char(regexprep(bogdan_Vocoded_AVG_ERP.label(1:129), 'E',''))));
test2=[test bogdan_Vocoded_AVG_ERP.avg(1:129,:)];
test2=sortrows(test2,1);
bogdan_Vocoded_AVG_ERP_chancorr=test2(:,[2:30002]);
save bogdan_Vocoded_AVG_ERP_chancorr bogdan_Vocoded_AVG_ERP_chancorr

%% Removing FieldTrip from and adding Letswave to MATLAB Path
% -------------------------------------------------------------------------

rmpath(genpath('/Users/lln/Documents/MATLAB/fieldtrip-20171231'));

addpath('/Users/lln/Documents/MATLAB/letswave6-master');
