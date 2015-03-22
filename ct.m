function f_ct = ct(li)
  z = find(li == 0, 1, 'first');
  if z
      f_ct = z - 1; 
  else
      f_ct = round(100 / 0.5);
  end
end

