% main function
% This file is only for continuing from last time

clear all;
clc;
% set_parameters;
% init_process;
fprnitf('--- Load data from last time...\n')
load('data.mat')
fprintf('--- Load data from last time successfully!\n')
start_step = 1;
fprintf('--- Now start simulation from step number %d\n\n', start_step)
for st = start_step:set_step
    fprintf('--- Current Step Number: %d\n', st)
    fprintf('--- %d: Now start cutting process\n', st)
    cut_process;
    fprintf('--- %d: Cutting process finished, now movement process\n', st)
    movement_process;
    fprintf('--- %d: Movement process finished.\n', st)
    plot_process;
    fprintf('--- Step %d finished.\n\n', st)
end
fprintf('--- Save workspace data to file for next running...\n')
save('data.mat')
fprintf('--- Save workspace data to file successfully!\n')
