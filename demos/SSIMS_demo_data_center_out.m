%% SSIMS toolbox demo
%
% The following code loads data from a planar center out task,
% computes 3 and 10 dimensional spike train similarity spaces and performs
% classification using a simple nearest neighbor classifier
% The 3D results are then graphically displayed. You can change the
% parameters to see the effects of different time windows, q values and more!
%
% Validated using MatLab R2016a
%
% for details, see:
% Vargas-Irwin, C. E., Brandman, D. M., Zimmermann, J. B., Donoghue, J. P., & Black, M. J
% "Spike Train SIMilarity Space (SSIMS): A Framework for Single Neuron and Ensemble Data Analysis." (2014).
%
% @author Carlos Vargas-Irwin, Jonas Zimmermann
% Copyright (c) Carlos Vargas-Irwin, Brown University. All rights reserved.
% Questions? Contact Carlos_Vargas_Irwin@Brown.edu



%% Load data:
% This dataset includes neural activity recorded from macaque motor cortex,
% event times, and information about movement direction for each trial.
load('SSIMS_demo_data_center_out');
%   spike_timestamps: cell array with spike train data from 103 units. Spike trains
%       are double arrays whose entries correspond to times of spike
%       occurences, in seconds, referenced to a common zero
%   instruction_cue: event times for 114 instruction cue events during the
%       recording. Double array, in seconds, referenced to the same common
%       zero as spikes.
%   go_cue: event times for 114 go cue events during the
%       recording. Double array, in seconds, referenced to the same common
%       zero as spikes.
%   start_of_movement: event times for 114 start of movement events during the
%       recording. Double array, in seconds, referenced to the same common
%       zero as spikes.
%   movement_direction: double vector of 114 entries, signifying the direction of
%       the movement corresponding to events in start_of_movement (in degrees)

%% Set parameters

% set the start of the time window relative to events, in s:
start_offset =  -0.1;

% length of spike train windows, in s:
win_len = 1;

% number of dimensions for visualization:
displaydim = 3;

% number of dimensions used for classification:
classdim = 10;

% temporal accuracy parameter (from Victor & Purpura),
% with q = 10, 1/q = 100msec:
q = 10;


%% Generate SSIMS
% This generates a spike train similarity space using the specified events
% and time window. It also provides the spike trains and linear transform
% needed to project additional data into the SSIMS.
%
% This step will take some time (~10 min) using the plain MATLAB functions
% included, but it can be *tremendously* accelerated by compiling the
% toolbox functions as lined out in doc/INSTALL.md
[SSIMS_display, tSNE_transform, basespiketrains, basedmat] = ...
    getSSIMS(spike_timestamps, start_of_movement + start_offset, win_len, q, displaydim);

%% Project additional data into SSIMS (neural trajectories)
% Project new data onto the SSIMS defined above (including time windows
% starting from one second before to one second after the start of movement
% events).
%
% Note that the MATLAB implementation of the projection is quite slow,
% and for this reason only three time steps are calculated when compiled
% toolbox functions are not available (see doc/INSTALL.md).
if exist('getSSIMSprojection', 'file') == 3
    NT_times = -1:0.05:1;
else
    NT_times = [-1, 0, 1];
end
NT = getSSIMSprojection(spike_timestamps, start_of_movement, NT_times, win_len, q, tSNE_transform, basespiketrains);

%%  Show mean neural trajectories and basis points
% To make this easier, use the plotNT function included in the toolbox!

cvals = [0.4, 0, 0.4; 0, 0, 1; 0, 0.5, 1; 0, 1, 1; 0.5, 1, 0.5; 0.6, 0.4, 0; 1, 0.5, 0; 1, 0, 0];

fh = figure(42);
clf(fh);
% plot average neural trajectories for all the groups
plotNT(NT, movement_direction, 'colors', cvals, 'symbol', '-', 'avg_trajectories', 1);
% plot state space locations for individual trials, in window defined by
% start_of_movement, start_offset, and win_len
plotNT(SSIMS_display, movement_direction, 'colors', cvals);
set(gca, 'fontsize', 20);
title('Ensemble SSIMS & mean neural trajectories')
view([-46 -15])
drawnow

%%  Classification
% Classification results are generally better using > 3 dimensions
% In this example, we are projecting onto a 10D space for classification
SSIMS = getSSIMS(spike_timestamps, start_of_movement + start_offset, win_len, q, classdim);

% We can use standard matlab functions to perform classification
% In this example, we use a neareast neighbor classifier
% with 5-fold cross-validation (see matlab documentation to adjust parameters)

KNNClass = fitcknn(SSIMS, movement_direction);
CVKNN = crossval(KNNClass, 'kfold', 5);
klossKNN = kfoldLoss(CVKNN, 'mode', 'individual');

accuracyM = mean(1 - klossKNN) * 100;
accuracySTD = std(1 - klossKNN) * 100;

title(sprintf('Ensemble SSIMS & mean neural trajectories\nNN classification: %.1f%% correct (std %.1f)', accuracyM, accuracySTD))
drawnow
%% Generate combined SSIMS spaces

% Multiple events can be used to generate the SSIMS space. Here we will use
% the same events as before, i.e. spikes in windows
%	[start_of_movement, start_of_movement + win_len) - start_offset
% In addition, we will also add spike trains from earlier in the trials,
% while the animal was still at rest:
%	[instruction_cue, instruction_cue + win_len)
% We will also increase the number of dimensions to 5, and pick a few
% dimensions to plot later.

[SSIMS_display_combined, tSNE_transform_combined, basespiketrains_combined, basedmat_combined] = ...
	getSSIMS(spike_timestamps, [start_of_movement + start_offset, instruction_cue ], win_len, q, 5, 14);

% We will lengthen the window for projections to include the other events.
% Note that we pass the new tSNE_transform_combined and
% basespiketrains_combined to getSSIMSprojection

if exist('getSSIMSprojection', 'file') == 3
    NT_times_combined = -2.0:0.05:1.0;
else
    NT_times_combined = [-2.0, -1.0, 0.0, 1.0];
end
NT_combined = getSSIMSprojection(spike_timestamps, start_of_movement, ...
    NT_times_combined, win_len, q, tSNE_transform_combined, ...
    basespiketrains_combined);


%% Let's plot the new space
fh = figure(43);
clf(fh);
% Here, we plot the original state space locations for start of movement
% events. Note that SSIMS_display_combined is 228x3 dimensional, and the
% rows correspond to events as passed to getSSIMS.
% We will also select some dimensions for plotting:
tah = axes('fontsize', 16, 'Visible', 'Off');
title(sprintf('Ensemble SSIMS at events\nand mean neural trajectories'), 'Visible', 'On')
ah = axes('fontsize', 16, 'DataAspectRatio', [1 1 1]);
% We choose 3 dimensions representing the data best
plti = [1 2 4];
% and plot the movement start events:
plotNT(SSIMS_display_combined(1:numel(movement_direction), plti), movement_direction, 'colors', cvals);
% The second 114 rows contain the new events earlier in the trial:
plotNT(SSIMS_display_combined((1:numel(movement_direction)) + numel(movement_direction), plti), movement_direction, 'colors', cvals, 'symbol', 'x');
% Let's also plot the new trajectories:
plotNT(NT_combined(:, plti, :), movement_direction, 'colors', cvals, 'symbol', '-', 'avg_trajectories', 1);
% Picking a good angle:
view(-98, -16);
% Draw legend:
ph = gobjects(1,2);
ph(1) = plot(NaN, NaN, 'x', 'markeredgecolor', [.5 .5 .5], 'DisplayName', 'Instruction Cue');
ph(2) = plot(NaN, NaN, 'o', 'markerfacecolor', [.5 .5 .5], 'markeredgecolor', 'none', 'DisplayName', 'Start of movement');
lh = legend(ph, 'Location', 'Southeast');
lh.Box = 'Off';
drawnow

%% Generate video of rotating trajectories
v = VideoWriter('SSIMS_demo_center_out.mp4', 'MPEG-4');
v.FrameRate = 20;
v.open;
pos = floor(get(fh, 'position'));
for ii = 1:360
    camorbit(1, 10*cos(ii/90*pi)*pi/45);
    frame = getframe(fh, [0, 0, pos(3), pos(4)]);
    writeVideo(v, frame);
end
v.close;
