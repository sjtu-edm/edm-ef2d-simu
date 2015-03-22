% calculation of tana
    % roots
ta = roots([(tool_w)^2 - ele_w^2, -Hw * (2 * tool_w), tool_w^2 + Hw^2, -Hw * (2 * tool_w), Hw^2]);
ta = ta(imag(ta) == 0);
ta = ta(ta > 0);
ta = min(ta);
comp_x = round((comp_ve * pi() * (2 * tool_w)^2 * ta / (4 * ratio^3 * Hw * (Hw - comp_ve))) / 5.1);
init_d = Hw + 10 / unit_size;
poss_right = 0;
% global tool;
tool = uint8(zeros(tool_h, tool_w));                     % tool 0-1 matrix with int8
tool(1:tool_h, 1:round(tool_w/5)) = 1;
% global drill;
drill = uint8(zeros(drill_h, drill_l));                     % drill 0-1 matrix with int8
drill(1:(init_d + init_w), 1:(2 * tool_w + init_w)) = 1;    % initial processing
drill(1:(init_d + init_w), (tool_w - round(tool_w/5) + init_w):(tool_w + round(tool_w/5) - init_w)) = 0;
% global be_x;
be_x = tool_w + 1;                                               % x-axis beginning location on drill
% global be_z;
be_z = init_d;                                          % z-axis beginning location on drill
down_m = zeros(floor(drill_l * 2 / comp_x));
