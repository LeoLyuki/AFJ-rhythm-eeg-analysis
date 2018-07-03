function [trl, event] = Rhythm_trialfun(cfg)
hdr   = ft_read_header(cfg.dataset);
event = ft_read_event(cfg.dataset);
EVsample   = [event.sample]';
EVvalue    = {event.value}';
pretrig  = -round(cfg.trialdef.prestim  * hdr.Fs);
posttrig =  round(cfg.trialdef.poststim * hdr.Fs);
trl = [];

for j = 1:(length(EVvalue))
       trg1 = EVvalue{j};      
       if strcmp('D253', trg1)==1
           trlbegin = EVsample(j) + pretrig ;       
           trlend   = EVsample(j) + posttrig ;       
           offset   = pretrig;
           newtrl   = [trlbegin trlend offset 2];
           trl      = [trl; newtrl];
       elseif strcmp('D221', trg1)==1
           trlbegin = EVsample(j) + pretrig ;       
           trlend   = EVsample(j) + posttrig ;       
           offset   = pretrig;
           newtrl   = [trlbegin trlend offset 6];
           trl      = [trl; newtrl];
       elseif strcmp('D189', trg1)==1
           trlbegin = EVsample(j) + pretrig ;       
           trlend   = EVsample(j) + posttrig ;       
           offset   = pretrig;
           newtrl   = [trlbegin trlend offset 10];
           trl      = [trl; newtrl];
       elseif strcmp('D157', trg1)==1
           trlbegin = EVsample(j) + pretrig ;       
           trlend   = EVsample(j) + posttrig ;       
           offset   = pretrig;
           newtrl   = [trlbegin trlend offset 14];
           trl      = [trl; newtrl];
       elseif strcmp('D207', trg1)==1
           trlbegin = EVsample(j) + pretrig ;       
           trlend   = EVsample(j) + posttrig ;       
           offset   = pretrig;
           newtrl   = [trlbegin trlend offset 20];
           trl      = [trl; newtrl];
       end
end
