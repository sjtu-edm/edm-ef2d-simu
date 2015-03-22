function f_can_ne_tool = can_ne_tool(x, y)
  global tool;
  global drill;
  global be_x;
  global be_z;
  global dir_x;
  global dir_y;
  global tool_w;
  global tool_h;
  f_can_ne_tool = 1;
  if ((mark(x, y)) || (tool(x, y))) f_can_ne_tool = 0;
  else if ((x <= 0) || (x > tool_h) || (y <= 0) || (y > tool_w))
          f_can_ne_tool = 0;
      else
         adj_to_wh = 0;
         for di = 1:4
           cp_x = x + dir_x(di);
           cp_y = y + dir_y(di);
           if (tool(cp_x, cp_y))
               adj_to_wh = 1;
               break;
           end
         end
         f_can_ne_tool = adj_to_wh;
      end
  end
end