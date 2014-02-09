map = obj {
	nam = 'map';
	var {
		data = {};
		nr = 1;
		map = {};
	};
	select = function(s, n)
		if n then
			s.nr = n;
		else
			n = s.nr
		end
		if s.title then
			sprite.free(s.title);
		end
		s.title = sprite.text(fn, string.format("%d: %s", n, _(maps[n].title)), "black");
		if hero:state() == DEAD or #s.map == 0 then
			if maps[n].color then
				bg_color = maps[n].color;
			else
				bg_color = '#9cccfc';
			end
			local y, x
			s.map = {}
			for y = 1, 30 do 
				s.map[y] = {}
				for x = 1, 40 do
					local c = string.sub(maps[n].map[y], x, x);
					if c == '#' then
						c = BLOCK
					elseif c == '~' then
						c = WATER
					elseif c == '*' then
						c = EMERGENCY
					elseif c == '%' then
						c = SEMIBLOCK
					elseif c == '=' then
						c = BRIDGE
					elseif c == '>' then
						c = nil
						s.map.x = (x - 1) * BW
						s.map.y = (y) * BH - hero.h
					end
					table.insert(s.map[y], { c })
				end
			end
		end
		if hero:state() == DEAD then
			hero.x = s.map.x
			hero.y = s.map.y
			map.data = {}
			hero:state(WALK);
			hero.speed_x = 0
			hero.dir = 1
		end
	end;
	next = function(s)
		local n
		n = s.nr + 1;
		s.data = {}
		s.map = {}
		s:select(n)
		if hero:state() ~= DEAD then
			hero.x = 0
			hero.dir = 1
		end
	end;
	pos2block = function(s, x, y)
		x = math.floor(x / BW);
		y = math.floor(y / BH);
		return x, y
	end;
	show = function(s)
		local y, x
		for y=0, 29 do
			for x=0, 39 do
				local c = s:block(x, y);
				if c == BLOCK  then
					sprite.fill(sprite.screen(), x * 16, y * 16, 16 - 1, 16 - 1, 'black');
				elseif c == SEMIBLOCK then
					sprite.fill(sprite.screen(), x * 16, y * 16, 16 - 1, 16 - 1, 'gray');
				elseif c == WATER then
					sprite.fill(sprite.screen(), x * 16, y * 16, 16, 16, 'blue');
				elseif c == EMERGENCY then
					sprite.fill(sprite.screen(), x * 16 + 1, y * 16 + 1, 16 - 2, 16 - 2, 'red');
				elseif c == BRIDGE then
					sprite.fill(sprite.screen(), x * 16, y * 16, 16 - 1, 8, 'brown');
				end
			end
		end
	end;
	cell = function(s, x, y)
		if x < 0 or y < 0 or x >= 40 or y >= 30 then
			return
		end
		return s.map[y + 1][x + 1];
	end,
	block = function(s, x, y)
		if x < 0 or y < 0 or x >= 40 or y >= 30 then
			return
		end
		local l = s.map[y + 1];
		local c = l[x + 1][1];
		return c
	end;
	is_fall = function(s, x, y, w, dy)
		local xx
		if not dy then dy = 0 end
		local rc = true
		local water = false
		local emerg = false
		for xx = 0, math.floor((w - 1) / BW) do
			local bx, by = s:pos2block(x + xx * BW, y)
			local c = s:block(bx, by)
			if c == BLOCK then
				rc = false
			elseif c == SEMIBLOCK then
				c = s:cell(bx, by)
				if not c.move then c.move = 0 end
				rc = false
			elseif c == WATER then
				water = true
			elseif c == EMERGENCY then
				hero:state(FLY)
				return false
			elseif c == BRIDGE and dy >= 0 and y - dy <= by * BH then
				rc = false
			end
		end
		if rc and dy >= 0 and water then
			hero:state(DROWN)
			rc = false
		end
		return rc
	end;
	is_move = function(s, x, y, h)
		local yy
		local rc = true
		for yy = 0, math.floor((h - 1) / BH) do
			local c = s:block(s:pos2block(x, y + yy*BH))
			if c == BLOCK or c == SEMIBLOCK then
				return false
			end
			if c == EMERGENCY then
				hero:state(FLY)
				return false
			end
		end
		return true
	end;
	move = function(s, x, y, dx, dy, w, h)
		local block_x = false
		local block_y = false
		local xx = x
		local yy = y
		if dx >= 0 then
			xx = xx + w
		end
		if dy >= 0 then
			yy = yy + h
		end
		if s:is_fall(x, yy + dy, w, dy) then
			y = y + dy
		else
			y = math.floor((yy + dy) / BH) * BH
			if dy >= 0 then
				y = y - h
			else
				y = y + BH
			end
			block_y = true
		end
	
		if s:is_move(xx + dx, y, h) then
			x = x + dx
		else
			x = math.floor((xx + dx) / BW) * BW 
			if dx >= 0 then
				x = x - w
			else
				x = x + BW
			end
			block_x = true
		end
		if x < -hero.w / 2 then
			x = -hero.w / 2
		end
		return math.floor(x), math.floor(y), block_x, block_y
	end;
	life = function(s)
		local y, x
		for y = 1, 30 do
			for x = 1, 40 do
				local c = s.map[y][x]
				if c.move then c.move = c.move + 1 end
				if c[1] == SEMIBLOCK and c.move then
					if c.move > 10 then
						c[1] = 0
					end
				end
			end
		end
		if maps[s.nr].life then
			maps[s.nr].life(s.data)
		end
	end
}


maps = {
	{
--		x = 0,
--		y = -19 * 3,
		title = "1:Beginning...", 
		map = {
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'        ========                        ';
'                                        ';
'                                        ';
'>                                       ';
'#############            ###############';
'            #            #              ';
'            #            #              ';
'            #            #              ';
'            #            #              ';
'            #~~~~~~~~~~~~#              ';
};
},
	{
		title = "2:Be careful...",
		color = '#008080',
		map = {
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'>             *         *               ';
'########################################';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
		};
	},
	{
		title = "3",
		map = {
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                     #                  ';
'                     #                  ';
'                     #                  ';
'                     #                  ';
'                     #                  ';
'>             *      #                  ';
'###############      #                ##';
'              #                     ####';
'              #                   ####  ';
'              #                 ####    ';
'              #               ####      ';
'              ##################        ';
};
		life =  function(s)
			if not s.laser then
				s.laser = 60
			end
			s.laser = s.laser - 1
			if s.laser <= 0 then
				s.laser = 60
			end
			if s.laser <= 10 then
				sprite.fill(sprite.screen(), 0, 24 * 16 - hero.h, 340, 3, 'red');
				if hero:collision(0, 24 * 16 - hero.h, 340, 3) then
					hero:state(FLY)
				end
			end
		end;

},


}
