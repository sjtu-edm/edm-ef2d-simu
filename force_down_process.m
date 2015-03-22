l_opt = 0;

% tool_border
l_tool_b = 0;
tool_b = {};
% Bottom surface
for j = 1:tool_w
    tem = ct(tool(:, j)');
    l_tool_b = l_tool_b + 1;
    tool_b{l_tool_b} = [tem+1, j, tem+1, j];
end
% Outer surface
for i = 1:be_z
    tem = tool_w - ct(fliplr(tool(i, :)));
    if (tem == 0)
        continue;
    end
    l_tool_b = l_tool_b + 1;
    tool_b{l_tool_b} = [i, tem, i, tem];
end
% Inner surface
for i = 1:be_z
    tem = ct(tool(i, :));
    if (tem >= tool_w)
        continue;
    end
    l_tool_b = l_tool_b + 1;
    tool_b{l_tool_b} = [i, -tem, i, tem+1];
end


% drill_border
l_drill_b = 0;
max_dep = 0;
drill_b = {};
% Depth
for j = 1:(be_x + 2 * tool_w)
    tem = ct(drill(:, j)');
    max_dep = max(max_dep, tem);
    l_drill_b = l_drill_b + 1;
    drill_b{l_drill_b} = [tem+1, j];
end
% First layer
for i = 1:max_dep
    tem = ct(drill(i, 1:(be_x + 2 * tool_w)));
    l_drill_b = l_drill_b + 1;
    drill_b{l_drill_b} = [i, tem+1];
end
% Second layer
for i = 1:max_dep
    tem = ct(drill(i, (be_x + round(tool_w / 5)): (be_x + 2 * tool_w))) + be_x + round(tool_w / 5) - 1;
    l_drill_b = l_drill_b + 1;
    drill_b{l_drill_b} = [i, tem + 1];
end


% find_min_distance
min_now = 99999999999;
for i = 1:l_tool_b
   for j = 1:l_drill_b
       tem = (be_x + tool_b{i}(2) - 1 - drill_b{j}(2))^2 + (tool_b{i}(1) - be_z -1 + drill_b{j}(1))^2;
       if (tem < min_now)
           min_now = tem;
           l_opt = 1;
           opt{l_opt} = [i j];
       else if (tem == min_now)
               l_opt = l_opt + 1;
               opt{l_opt} = [i j];
           end
       end
   end
end
if (min_now < ele_w^2)
    cut_remove;
end