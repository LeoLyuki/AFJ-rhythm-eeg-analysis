function [ CIs ] = ERP_CousineauMoreyCI( data, channel, confidence )
%ERP_CousineauMoreyCI   Make CousineauMorey CI around ERPs
%   Inputs:
%       data: a structure of individual-subject ERPs. Each structure field
%           should be one conditon. And within the field there should be a
%           Channels*Samples*Subjects matrix (must be in this order)
%       channel: the channel number to do the CIs around
%       confidence: Confidence level to plot, as a fraction (e.g., .95 for
%           a 95% CI, .99 for a 99% CI)
%
%   Outputs:
%       CIs: a structure of confidence distances. Each structure field is
%           one condition. Within the field there is a 1*Samples matrix
%           representing the upper confidence distance for that sample in that
%           condition. Thus, the actual CI for a given sample is
%               [ERP(sample) - CIs(sample); ERP(sample) + CIs(sample)
%           This can be used with e.g. boundedline() or shadedErrorBar() to
%           plot a nice ribbon.
%
%   Example:
%       CIs = ERP_CousineauMoreyCI( MMNs_ind, 5, .95 );
%

%%% Get Cousineau-Morey CIs for this channel


    % names of conditions
    conditions = fieldnames(data)';

    % number of conditions
    n_cond = length(conditions);

    % number of subjects
    n_subj = size( data.(conditions{1}), 3);
    
    % number of channels
    n_chan = size( data.(conditions{1}), 1);
    
    % number of samples
    n_samp = size( data.(conditions{1}), 2);



    % Get the individual-subject MMNs into one big matrix, instead of a struct,
    % for easier handling in a moment
    data_mat = reshape( cell2mat( cellfun( @(x)(squeeze( data.(x)(channel,:,:))), conditions, 'UniformOutput', false) ), [n_samp n_subj n_cond] );

    % Each subject's mean across conditions (dimension 3), at each timepoine
    indmeans = mean(data_mat, 3);

    % Scale the data by subtracting each subject's mean-across-conditions from
    % the actual condition values
    data_mat_scaled = data_mat - reshape( repmat( indmeans, [1 n_cond] ), size(data_mat) );

    % Here we'll put the data back into a struct, and also compute the CI for
    % each condition
    % iterate through conditions
    for conditionnum=1:length(conditions)
        condition = conditions{conditionnum};

        % take the data for this condition and put it into a struct field
        data_scaled.(condition) = data_mat_scaled(:,:,conditionnum);

        % compute the CI. This uses an arrayfun to do the following at each
        % timepoint:
        % take the std across all subjs, divide by sqrt(N-1), multiply by the
        % critical t-value for .05 two-tailed, and multiply by the Morey
        % scaling factor (sqrt(K/(K-1))
        CIs.(condition) = arrayfun( @(x)( std(data_scaled.(condition)(x,:)) / sqrt(n_subj-1) * tinv( (confidence+(1-confidence)/2),n_subj-1) * sqrt(n_cond/(n_cond-1)) ), 1:n_samp );
    end;

    %%% Done getting CIs



end

