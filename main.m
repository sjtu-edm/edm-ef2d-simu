% main function
clear all;
clc;
set_parameters;
init_process;
%for st = 1:set_step
for st = 1:5
    if (mod(st, 10) == 0)
        st
    end
    fprintf('--- Current Step Number: %d\n', st)
    fprintf('--- %d: Now start cutting process\n', st)
    cut_process;
    fprintf('--- %d: Cutting process finished, now movement process\n', st)
    movement_process;
    fprintf('--- %d: Movement process finished.\n', st)
    plot_process;
    if ((mod(st, 10) == 0) & (be_x > tool_w+2))
%        plot_process;
    end
%    imwrite(drill*255, ['figure/drill_', num2str(st), '.bmp'], 'bmp')
%    imwrite(flipud(tool)*255, ['figure/tool_', num2str(st), '.bmp'], 'bmp')
    fprintf('--- Step %d finished.\n\n', st)
end
