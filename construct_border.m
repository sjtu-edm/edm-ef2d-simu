% 1 - Removed
% 2 - Drill part
% 0 - Tool part

comb = uint8(ones(drill_h + tool_h / 2, drill_l));
comb((tool_h/2+1):(drill_h + tool_h / 2), :) = drill;
flptl = flipud(tool(1:tool_h/2, 1:tool_w));
flptl1 = [fliplr(flptl) flptl];
comb((be_z+1):(be_z+tool_h/2), (be_x - tool_w):(be_x+tool_w-1)) = flptl1 & comb((be_z+1):(be_z+tool_h/2), (be_x-tool_w):(be_x+tool_w-1));
center_x = be_x;
center_z = ct(comb(:, be_x)');
range_x1 = max(1, center_x - tool_w*2);
range_x2 = min(drill_l, center_x + tool_w*2);
range_z1 = max(1, center_z - tool_h/4);
range_z2 = min(drill_h + tool_h/2, center_z + tool_h/2);

% imshow(comb(range_z1:range_z2, range_x1:range_x2)*255)
for i = range_z1:range_z2
    if ((i - tool_h/2) > 0)
        for j = range_x1:range_x2
            if (drill(i - (tool_h/2), j) == 0)
                comb(i, j) = 2;
            end
        end
    end
end
