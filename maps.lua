map = obj {
	nam = 'map';
	var {
		data = {};
		nr = 1;
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
		s.title = sprite.text(fn, string.format("%d: %s", n, maps[n].title), "black");
		s.map = maps[n].map;
		if hero:state() == DEAD then
			hero.x = maps[n].x
			hero.y = maps[n].y
			map.data = {}
			hero:state(FALL);
			hero.speed_x = 0
		end
	end;
	next = function(s)
		local n
		n = s.nr + 1;
		s.data = {}
		s:select(n)
		if hero:state() ~= DEAD then
			hero.x = 0
			hero.dir = 1
		end
	end;
	show = function(s)
		local y, x
		for y=0, 29 do
			for x=0, 39 do
				local l = s.map[y + 1];
				local c = string.sub(l, x + 1, x + 1);
				if c == '#' then
					sprite.fill(sprite.screen(), x * 16 + 1, y * 16 + 1, 16 - 2, 16 - 2, 'black');
				end
				if c == '~' then
					sprite.fill(sprite.screen(), x * 16 - 1, y * 16, 16 + 2, 16, 'blue');
				end
				if c == '*' then
					sprite.fill(sprite.screen(), x * 16, y * 16, 16, 16, 'red');
				end
			end
		end
	end;
	block = function(s, x, y)
		x = math.floor(x / BW);
		y = math.floor(y / BH);
		if x < 0 or y < 0 or x >= 60 or y >= 30 then
			return
		end
		local l = s.map[y + 1];
		local c = string.sub(l, x + 1, x + 1);	
		if c == '#' then
			return BLOCK
		end
		if c == '~' then
			return WATER
		end
		if c == '*' then
			return EMERGENCY
		end
		return
	end;
	is_fall = function(s, x, y, w)
		local xx
		local rc = true
		local water = false
		local emerg = false
		for xx = 0, math.floor((w - 1) / BW) do
			local c = s:block(x + xx * BW, y)
			if c == BLOCK then
				rc = false
			elseif c == WATER then
				water = true
			elseif c == EMERGENCY then
				hero:state(FLY)
				return false
			end
		end
		if rc and water then
			hero:state(DROWN)
		end
		return rc
	end;
	is_move = function(s, x, y, h)
		local yy
		local rc = true
		for yy = 0, math.floor((h - 1) / BH) do
			local c = s:block(x, y + yy*BH)
			if c == BLOCK then
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
		if s:is_fall(x, yy + dy, w) then
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
		if maps[s.nr].life then
			maps[s.nr].life(s.data)
		end
	end
}


maps = {
	{
--		x = 0,
--		y = -19 * 3,
		x = 0,
		y = 24 * 16 - hero.h,
		title = "Be smart", 
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
'                                        ';
'#############            ###############';
'            #            #              ';
'            #            #              ';
'            #            #              ';
'            #            #              ';
'            #~~~~~~~~~~~~#              ';
};
},
	{
		x = 0,
		y = 24 * 16 - hero.h,
		title = "2",
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
'              *         *               ';
'########################################';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
		};
	},
	{
		x = 0,
		y = 24 * 16 - hero.h,
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
'              *      #                  ';
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
