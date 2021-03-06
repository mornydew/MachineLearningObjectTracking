function ampXphase(masterDir)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This function cycles through mean subtracted amplitude and phase
% reconstructions and multiplies them together.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

poolobj = parpool;

zSorted = zSteps(fullfile(masterDir, 'MeanStack', 'Amplitude'));
NFz = length(zSorted);

meanDir = fullfile(masterDir, 'MeanStack','ampXphase');
mkdir(meanDir);

% First, look through the master directory for duplicate holograms
timePath = dir(fullfile(masterDir, 'Holograms'));
[dupes] = findDuplicates(masterDir);
times = 0:length(dupes)-1;
% remove duplicate from times
times(logical(dupes)) = [];

for z = 1 : NFz
    ampPath = fullfile(masterDir, 'MeanStack', 'Amplitude', sprintf('%0.2f', zSorted(z)));
    phasePath = fullfile(masterDir, 'MeanStack', 'Phase', sprintf('%0.2f', zSorted(z)));
    dataDir = fullfile(meanDir, sprintf('%0.2f', zSorted(z)));
    mkdir(dataDir);
    parfor t = 1 : length(times)
        I_amp = imread(fullfile(ampPath, sprintf('%05d.tiff', times(t))));
        I_phase = imread(fullfile(phasePath, sprintf('%05d.tiff', times(t))));
        I = (im2double(I_amp).*255).*(im2double(I_phase).*255);
        I = I./max(I(:));
        imwrite(I, fullfile(dataDir, sprintf('%05d.tiff', times(t))))
    end
end

delete(poolobj)