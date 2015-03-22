% 1 - Removed
% 2 - Drill part
% 0 - Tool part

% --------- Sort the border --------- %
dirr_x = [1 -1];
dirr_z = [1 -1];
volta = zeros(1, (range_z2 - range_z1 + 1) * (range_x2 - range_x1 + 1));
numb = 0;
hass = zeros(range_z2 - range_z1 + 1, range_x2 - range_x1 + 1);
bord_jud = uint8(hass);

for i = range_z1:range_z2
    for j = range_x1:range_x2
        switch comb(i, j)
            case 1
                numb = numb + 1;
                % set up matrix here
                volta(numb) = 0;
                hass(i - range_z1 + 1, j - range_x1 + 1) = numb;
                for p_z = 1:2
                    for p_x = 1:2
                        temp_z = i + dirr_z(p_z);
                        temp_x = j + dirr_x(p_x);
                        if ((temp_z < range_z1) || (temp_z > range_z2) || (temp_x < range_x1) || (temp_x > range_x2))
                            bord_jud(i - range_z1 + 1, j - range_x1 + 1) = 1;
                        end
                    end
                end
            case 0
                for p_z = 1:2
                    for p_x = 1:2
                        temp_z = i + dirr_z(p_z);
                        temp_x = j + dirr_x(p_x);
                        if ((temp_z >= range_z1) && (temp_z <= range_z2) && (temp_x >= range_x1) && (temp_x <= range_x2))
                            if ((comb(temp_z, temp_x) == 1) && (hass(i - range_z1 + 1, j - range_x1 + 1) == 0))
                                numb = numb + 1;
                                % set up matrix here
                                volta(numb) = 200;   % Initial voltage for the tool
                                hass(i - range_z1 + 1, j - range_x1 + 1) = numb;
                                bord_jud(i - range_z1 + 1, j - range_x1 + 1) = 1;
                            end
                        end
                    end
                end
            case 2
                for p_z = 1:2
                    for p_x = 1:2
                        temp_z = i + dirr_z(p_z);
                        temp_x = j + dirr_x(p_x);
                        if ((temp_z >= range_z1) && (temp_z <= range_z2) && (temp_x >= range_x1) && (temp_x <= range_x2))
                            if ((comb(temp_z, temp_x) == 1) && (hass(i - range_z1 + 1, j - range_x1 + 1) == 0))
                                numb = numb + 1;
                                % set up matrix here
                                volta(numb) = 0;   % Initial voltage for the drill
                                hass(i - range_z1 + 1, j - range_x1 + 1) = numb;
                                bord_jud(i - range_z1 + 1, j - range_x1 + 1) = 1;
                            end
                        end
                    end
                end                
        end
    end
end
% ---------- Set matrix parameters ----------- %
% -- cautious for the size -- %
solv = zeros(numb, numb);
solv_b = zeros(numb, 1);
for i = range_z1:range_z2
    for j = range_x1:range_x2
        if (hass(i - range_z1 + 1, j - range_x1 + 1))
            loc = hass(i - range_z1 + 1, j - range_x1 + 1);
            if (bord_jud(i -range_z1 + 1, j - range_x1 + 1))
                solv(loc, loc) = 1;
                solv_b(loc) = volta(loc);
            else
                for p_z = 1:2
                    for p_x = 1:2
                        temp_z = i + dirr_z(p_z);
                        temp_x = j + dirr_x(p_x);
                        solv(loc, hass(temp_z - range_z1 + 1, temp_x - range_x1 + 1)) = -0.25;
                    end
                end
                solv(loc, loc) = 1;
            end
        end
    end
end
% % -- Get answer to solv_x -- %
solv_x = solv\solv_b;

