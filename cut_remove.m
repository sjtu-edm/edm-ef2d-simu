% cur_tool
fprintf('--------- Cutting tool...\n')
cur_t_x = tool_h / 2 - (min_tool_z - be_z) + 1;
if (min_tool_x < be_x)
    cur_t_y = be_x - min_tool_x;
else
    cur_t_y = min_tool_x - be_x  + 1;
end

for i = max((cur_t_x - ele_range_t), 1):min((cur_t_x + ele_range_t), tool_h)
    ele_range_t_y = round(sqrt(ele_range_t^2 - (i - cur_t_x)^2));
    for j = max((cur_t_y - ele_range_t_y), 1):min((cur_t_y + ele_range_t_y), tool_w);
        tool(i, j) = 1;
    end
end

% cut_drill
fprintf('--------- Cutting drill...\n')
cur_d_x = min_drill_z - tool_h / 2;
cur_d_y = min_drill_x;

for i = max((cur_d_x - ele_range_d), 1):min((cur_d_x + ele_range_d), drill_h)
    ele_range_d_y = round(sqrt(ele_range_d^2 - (i - cur_d_x)^2));
    for j = max((cur_d_y - ele_range_d_y), 1):min((cur_d_y + ele_range_d_y), drill_l);
        drill(i, j) = 1;
    end
end

