function createPlot(points, adjacencyTracks, times)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This function, takes as inputs cell arrays of points and adjecency tracks
% from the simpleTracker.m algorithm in order to generate a 3D plot of
% trajectories that are color coded with respect to time.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global masterDir minTrackSize
allPoints = vertcat(points{:});
Mins = min(allPoints);
Maxs = max(allPoints);
maxes = max(allPoints);
nTracks = size(adjacencyTracks,1);

% Import timestamp file to calculate velocities
[stamp, timeOfDay, Date, time] = textread(fullfile(masterDir, ...
    'timestamps.txt'),'%f %s %s %f');
clear timeOfDay Date stamp
time = time./1000;                              % Convert time from ms to s

if times(1) == 0
    times(1) = [];
end

ImgTimes = time(times);

for i = 1 : nTracks
    index = adjacencyTracks{i,1};
    if length(index) >= minTrackSize
        coords = allPoints(index,:);
        % Find the times associated to each coordinate
        for j = 1 : length(coords)
            for k = 1 : size(points,2)
                [tf,Index] = ismember(points{1,k}, coords(j,1:3),'rows');
                if any(Index)
                    coords(j,4) = ImgTimes(k);
                    %coords(j,4) = k;
                    break
                end
            end
        end
        % Account for flipped z (this is because of the way numerical
        % reconstructions occur and will be fixed later
        coords(:,3) = maxes(3) - coords(:,3);
        scatter3(coords(:,1), coords(:,2), coords(:,3), 5, coords(:,4),'*')
        %scatter3(coords(:,1), coords(:,2), coords(:,3), 5,'*')
        hold on; axis equal; axis([Mins(1) Maxs(1) Mins(2) Maxs(2) Mins(3) Maxs(3)]);
        drawnow
    end
end
h = colorbar;
xlabel('Distance [\mum]')
ylabel('Distance [\mum]')
zlabel('Distance [\mum]')
ylabel(h, 'Time [s]')