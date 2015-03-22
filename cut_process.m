construct_border;
fprintf('------ Constructing border finished.\n')
process_border;
fprintf('------ Border processed.\n')

max_eft = -1;
max_eft_set = zeros(3, 1000);
max_eft_set_num = 0;

for i = (range_z1 + round(tool_h / 8)):range_z2
    for j = (range_x1 + round(tool_w/8)):range_x2
        if (comb(i, j) == 1)
            for pz = 1:2
                for px = 1:2
                    temp_z = i + dirr_z(pz);
                    temp_x = j + dirr_x(px);
                    if (temp_z >= range_z1 && temp_z <= range_z2 && temp_x >= range_x1 && temp_x <= range_x2)
                        if (comb(temp_z, temp_x) == 0 || comb(temp_z, temp_x) == 2)
                            hass1 = hass(i - range_z1, j - range_x1 + 1);
                            hass2 = hass(i - range_z1 + 1, j - range_x1);
                            hass3 = hass(i - range_z1 + 1, j - range_x1 + 1);
                            if (hass1 == 0 || hass2 == 0 || hass3 == 0)
                                continue;
                            end
                            temp_value1 = solv_x(hass1);
                            temp_value2 = solv_x(hass2);
                            temp_value3 = solv_x(hass3);
                            temp_value = (temp_value3 - temp_value1)^2 + (temp_value3 - temp_value2)^2;
                            if (temp_value > max_eft)
                                max_eft = temp_value;
                                max_eft_set_num = 1;
                                max_eft_set(1, 1) = i;
                                max_eft_set(2, 1) = j;
                                switch comb(temp_z, temp_x)
                                    case 0
                                        max_eft_set(3, 1) = 0;
                                    case 2
                                        max_eft_set(3, 1) = 2;
                                end
                            else if (temp_value == max_eft)
                                    max_eft_set_num = max_eft_set_num + 1;
                                    max_eft_set(1, max_eft_set_num) = i;
                                    max_eft_set(2, max_eft_set_num) = j;
                                    switch comb(temp_z, temp_x)
                                        case 0
                                            max_eft_set(3, max_eft_set_num) = 0;
                                        case 2
                                            max_eft_set(3, max_eft_set_num) = 2;
                                    end
                                 end
                            end
                        end
                    end
                end
            end
        end
    end
end

max_eft_rand = randi(max_eft_set_num);

dirr_z_grad = [-1, -1, -1, 0, 0, 1, 1, 1];
dirr_x_grad = [-1, 0, 1, -1, 1, -1, 0, 1];
dirr_div_grad = [2, 1, 2, 1, 1, 2, 1, 2];

start_z = max_eft_set(1, max_eft_rand);
start_x = max_eft_set(2, max_eft_rand);
start_dir = max_eft_set(3, max_eft_rand);
switch start_dir
    case 0
        min_tool_z = start_z;
        min_tool_x = start_x;
    case 2
        min_drill_z = start_z;
        min_drill_x = start_x;
end
while (1)
    max_grad = 0;
    max_grad_num = 0;
    max_grad_cho = zeros(1, 8);
    for i = 1:8
        temp_valuez = start_z + dirr_z_grad(i);
        temp_valuex = start_x + dirr_x_grad(i);
        if ((temp_valuez >= range_z1) && (temp_valuez <= range_z2) && (temp_valuex >= range_x1) && (temp_valuex <= range_x2))
            hass1 = hass(start_z - range_z1 + 1, start_x - range_x1 + 1);
            hass2 = hass(temp_valuez - range_z1 + 1, temp_valuex - range_x1 + 1);
            if (hass1 == 0 || hass2 == 0)
                continue;
            end
%            fprintf('%f %f %d\n', solv_x(hass2), solv_x(hass1), i)
            temp_value = sign(solv_x(hass2) - solv_x(hass1)) * (solv_x(hass2) - solv_x(hass1))^2 / dirr_div_grad(i) * (start_dir - 1);
            if (temp_value > max_grad)
                max_grad = temp_value;
                max_grad_num = 1;
                max_grad_cho(1) = i;
            else if (temp_value == max_grad)
                    max_grad_num = max_grad_num + 1;
                    max_grad_cho(max_grad_num) = i;
                 end
            end
        end
    end
    if (max_grad == 0)
        break;
    end
    max_gradn = randi(max_grad_num);
    start_z = start_z + dirr_z_grad(max_grad_cho(max_gradn));
    start_x = start_x + dirr_x_grad(max_grad_cho(max_gradn));
%    fprintf('%d\n', max_gradn);
%    fprintf('------\n') 
end

switch start_dir
    case 0
        min_drill_z = start_z;
        min_drill_x = start_x;
    case 2
        min_tool_z = start_z;
        min_tool_x = start_x;
end

% min_tool = -1;
% min_drill = -1;
% min_tool_set = zeros(2, 1000);
% min_tool_set_num = 0;
% min_drill_set = zeros(2, 1000);
% min_drill_set_num = 0;
% for i = (range_z1 + round(tool_h / 8)):range_z2
%     for j = (range_x1 + 1):range_x2
%         if (comb(i, j) == 1)
%             bord_belong = 0;
%             for pz = 1:2
%                 for px = 1:2
%                     temp_z = i + dirr_z(pz);
%                     temp_x = j + dirr_x(px);
%                     if (bord_belong)
%                         break
%                     end
%                     if (temp_z < range_z1 || temp_z > range_z2 || temp_x < range_x1 || temp_x > range_x2)
%                         continue
%                     end
%                     switch comb(temp_z, temp_x)
%                         case 0
%                             hass1 = hass(i - range_z1, j - range_x1 + 1);
%                             hass2 = hass(i - range_z1 + 1, j - range_x1);
%                             hass3 = hass(i - range_z1 + 1, j - range_x1 + 1);
%                             if (hass1 == 0 || hass2 == 0 || hass3 == 0)
%                                 break;
%                             end
%                             temp_value1 = solv_x(hass1);
%                             temp_value2 = solv_x(hass2);
%                             temp_value3 = solv_x(hass3);
%                             temp_value = (temp_value3 - temp_value1)^2 + (temp_value3 - temp_value2)^2;
%                             if (temp_value > min_tool)
%                                 min_tool_set_num = 1;
%                                 min_tool = temp_value;
%                                 min_tool_set(1, min_tool_set_num) = i;
%                                 min_tool_set(2, min_tool_set_num) = j;
%                             else if (temp_value == min_tool)
%                                      min_tool_set_num = min_tool_set_num + 1;
%                                      min_tool_set(1, min_tool_set_num) = i;
%                                      min_tool_set(2, min_tool_set_num) = j;
%                                  end
%                             end
%                             bord_belong = 1;
%                         case 2
%                             temp_value1 = solv_x(hass(i - range_z1, j - range_x1 + 1));
%                             temp_value2 = solv_x(hass(i - range_z1 + 1, j - range_x1));
%                             temp_value3 = solv_x(hass(i - range_z1 + 1, j - range_x1 + 1));
%                             temp_value = (temp_value3 - temp_value1)^2 + (temp_value3 - temp_value2)^2;
%                             if (temp_value > min_drill)
%                                 min_drill_set_num = 1;
%                                 min_drill = temp_value;
%                                 min_drill_set(1, min_drill_set_num) = i;
%                                 min_drill_set(2, min_drill_set_num) = j;
%                             else if (temp_value == min_drill)
%                                      min_drill_set_num = min_drill_set_num + 1;
%                                      min_drill_set(1, min_drill_set_num) = i;
%                                      min_drill_set(2, min_drill_set_num) = j;
%                                  end
%                             end            
%                             bord_belong = 1;
%                     end
%                 end
%             end
%         end
%     end
% end
% 
% min_now = 999999999999999;
% for tool_i = 1:min_tool_set_num
%     for drill_i = 1:min_drill_set_num
%         temp_value = (min_tool_set(1, tool_i) - min_drill_set(1, drill_i))^2 + (min_tool_set(2, tool_i) - min_drill_set(2, drill_i))^2;
%         if (temp_value < min_now)
%             min_now = temp_value;
%             min_tool_z = min_tool_set(1, tool_i);
%             min_drill_z = min_drill_set(1, drill_i);
%             min_tool_x = min_tool_set(2, tool_i);
%             min_drill_x = min_drill_set(2, drill_i);
%         end
%     end
% end
min_now = (min_tool_z - min_drill_z)^2 + (min_tool_x - min_drill_x)^2;
fprintf('------ Get minimum distance ... Positions:\n')
fprintf('%d %d %d %d\n', min_tool_z, min_tool_x, min_drill_z, min_drill_x)
if (min_now < ele_w^2)
    fprintf('------ Min distance legal to remove.\n')
    cut_remove;
else
    fprintf('------ Min distance illegal to remove, skip...\n')
    poss_right = 1;
end
