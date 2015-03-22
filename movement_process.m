if (poss_right)
    can_right = 1;
    for i_t = 1:be_z
        i_d = be_z + 1 - i_t;
        tem_c1 = ct(tool(i_t, :));
        tem_c2 = ct(fliplr(tool(i_t, :)));
        if (tem_c2 >= tool_w)
            continue;
        end
        tem1 = ct(drill(i_d, (be_x - tem_c1):min((be_x + tool_w), drill_l)));
        tem2 = ct(drill(i_d, (be_x + tool_w - tem_c2):min((be_x + 2 * tool_w), drill_l)));
        if ((tem1 < tool_x_v) || (tem2 < tool_x_v))
            can_right = 0;
            break;
        end
    end
    if (can_right)
        fprintf('------ Move right...\n')
        be_x = be_x + tool_x_v;
    end
end
if (be_x >= comp_x)
    if (down_m(floor(be_x / comp_x)) == 0)
        while (1)
            can_down = 1;
            for i_t = 1:tool_w
                i_d = be_x + i_t - 1;
                tem = ct(tool(:, i_t)') + ct(drill(:, i_d)') - be_z;
                if (tem < comp_ve)
                    can_down = 0;
                    break;
                end
            end
            if (can_down)
                break;
            end
            fprintf('------ Tool cannot go down, force processing...\n')
            cut_process;
        end
        if (can_down)                    %  && (mod(st, comp_x) == 0)
            fprintf('------ Tool can go down, move down...\n')
            be_z = be_z + comp_ve;
            down_m(floor(be_x / comp_x)) = 1;
        end
    end
end
