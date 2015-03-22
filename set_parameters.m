% parameters set

% symbol illustrations
% d - depth
% h - height
% x - x-axis
% v - velocity
% l - length
% w - width
% r - radius
% ve - value

set_step = 20000;                                    % step of simulations
unit_size = 1;                                    % size of one finite element
% global tool_w;
tool_w = round(100 / unit_size);                    % radius of tool = diameter / 2
% global tool_h;
tool_h = round(400 / unit_size);                    % height of tool
tool_x_v = round(7 / unit_size);                    % x-axis velocity of tool
% init_d = round(80 / unit_size);                     % initial depth of tool in drill  //  original 80
Hw = round(43.5 / unit_size);
init_w = round(5 / unit_size);                      % initial width of tool and drill
ratio = (0.119)^(1/3);         % ratio of wearing for tool and drill
% global drill_h;
drill_h = round(500 / unit_size);                   % height of drill
% global drill_l;
drill_l = round(2000 / unit_size);                  % constrainted by "tool_x_v"
ele_w = round(200 / unit_size);                       % max width for electricity

% With Wolframalpha, theta = 1.195
% R = 4.4438
% d = 3.6739
% Formula:
% depth = sqrt(R^2-delta^2) - d
test_p = 1;                                               % ##### for debugging
ele_range_t = round(test_p * ratio * 2.5 / unit_size);    % ##### range radius for electricity on tool
% ele_r_t = round(test_p * ratio * 4.4438 / unit_size);
% ele_d_t = round(test_p * ratio * 3.6739 / unit_size);
ele_range_d = round(test_p * 2.5 / unit_size);            % ##### radius for electricity on drill
% ele_r_d = round(test_p * 4.4438 / unit_size);
% ele_d_d = round(test_p * 3.6739 / unit_size);

% comp_x = 24;                                        % compensation coornidates foe x-axis
comp_ve = round(1 / unit_size);                     % compensation value for a distance of comp_x
