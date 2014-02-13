origG = G
origRGX = RGX

map = obj {
	nam = 'map';
	var {
		data = {};
		nr = 1;
		prev = 0;
		map = {};
		d = 0;
	};
	dist = function(s, n)
		local nn = s.d
		if n then s.d = n end
		return nn
	end;
	select = function(s, n)
		if n then
			s.prev = s.nr
			s.nr = n;
			if n == CONTMAP then
				save_music(game)
				set_music 'snd/nothing.ogg'
			end
		else
			n = s.nr
		end
		G = origG
		RGX = origRGX
		if s.title then
			sprite.free(s.title);
		end
		s.title = sprite.text(fn, string.format("%d: %s", n, _(maps[n].title)), "black");
		if hero:state() == DEAD or #s.map == 0 then
			sound_init()
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
					elseif c == '.' then
						c = INVI
					elseif c == '@' then
						c = SNOW
					elseif c == '^' then
						c = FAKE
					elseif c == '~' then
						c = WATER
					elseif c == '*' then
						c = EMERGENCY
					elseif c == '%' then
						c = SEMIBLOCK
					elseif c == '=' then
						c = BRIDGE
					elseif c == '-' then
						c = ROPE
					elseif c == 'm' then
						c = MINE
					elseif c == '>' then
						c = nil
						s.map.x = (x - 1) * BW
						s.map.y = (y) * BH - hero.h
					elseif c == '+' then
						c = HEART
					elseif c == ' ' then
						c = nil
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
		if s.nr == CONTMAP then 
			n = s.prev 
			game_lifes = 3
			game:dist(0)
			hero:state(DEAD)
			restore_music(game)
		end
		s.data = {}
		s.map = {}
		s:select(n)
		s:dist(0)
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
				local c = s:cell(x, y);
				if c[1] == BLOCK or c[1] == FAKE then
					sprite.fill(sprite.screen(), x * 16, y * 16, 16 - 1, 16 - 1, 'black');
				elseif c[1] == SNOW then
					sprite.fill(sprite.screen(), x * 16, y * 16, 16, 16, 'white');
				elseif c[1] == SEMIBLOCK then
					if (not c.move) or (c.move < SEMI_TO) then
						sprite.fill(sprite.screen(), x * 16, y * 16, 16 - 1, 16 - 1, SEMICOL);
					end
				elseif c[1] == WATER then
					sprite.fill(sprite.screen(), x * 16, y * 16, 16, 16, 'blue');
				elseif c[1] == EMERGENCY or c[1] == MINE then
					sprite.fill(sprite.screen(), x * 16 + 1, y * 16 + 1, 16 - 2, 16 - 2, 'red');
				elseif c[1] == BRIDGE then
					sprite.fill(sprite.screen(), x * 16, y * 16, 16 - 1, 8, 'black');
				elseif c[1] == ROPE then
					sprite.fill(sprite.screen(), x * 16, y * 16, 16 - 1, 4, 'black');
				elseif c[1] == HEART then
					if not heart_blink then heart_blink = 0 end
					if math.floor(heart_blink / 20) % 2 ~= 0 then
						sprite.draw(heart_bonus_spr, sprite.screen(), x * 16, y * 16);
					end
					heart_blink = heart_blink + 1
					if heart_blink >= 40 then heart_blink = 0 end
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
		if game_state == INTRO then
			return false
		end
		for xx = 0, math.floor((w - 1) / BW) do
			local bx, by = s:pos2block(x + xx * BW, y)
			local c = s:block(bx, by)
			if c == BLOCK or c == SNOW or c == INVI then
				rc = false
			elseif c == SEMIBLOCK then
				c = s:cell(bx, by)
				if not c.move then c.move = 0 end
				if c.move < SEMI_TO then
					rc = false
				end
			elseif c == WATER then
				water = true
			elseif c == EMERGENCY or c == MINE then
				hero:state(FLY)
				return false
			elseif c == BRIDGE and dy >= 0 and y - dy <= by * BH then
				rc = false
			elseif c == ROPE and dy == 0 and y - dy <= by * BH and hero.speed_x ~= 0 then
				rc = false
			elseif c == HEART then
				game_lifes = game_lifes + 1
				c = s:cell(bx, by)
				c[1] = 0
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
		if game_state == INTRO then
			return true
		end
		for yy = 0, math.floor((h - 1) / BH) do
			local c = s:cell(s:pos2block(x, y + yy*BH))
			if c then
				if c[1] == BLOCK or (c[1] == SEMIBLOCK and (not c.move or c.move < SEMI_TO)) then
					return false
				end
				if c[1] == SNOW or c[1] == INVI then
					return false
				end
				if c[1] == EMERGENCY or c[1] == MINE then
					hero:state(FLY)
					return false
				elseif c[1] == HEART then
					game_lifes = game_lifes + 1
					c[1] = 0
				end
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
				local yy
				local c = s.map[y][x]
				if c.move then c.move = c.move + 1 end

				if c[1] == MINE and not c.activated then
					if hero:distance(x * BW + BW / 2, y * BH + BH /2) < MINE_DIST then
						c.activated = true
						c.move = 0
					end
				end

				if c[1] == SEMIBLOCK and c.move then
					if c.move >= SEMI_TO then
						if not c.y then
							c.y = (y - 1)* BH
						end
						c.y = c.y + (c.move - SEMI_TO) * G;
						sprite.fill(sprite.screen(), (x - 1) * BW, 
							c.y, 
							16 - 1, 
							16 - 1, SEMICOL);
					end
					if c.move and c.y and c.y > 480 then
						c[1] = 0
					end
				elseif c[1] == EMERGENCY or (c[1] == MINE and c.activated) then
					if not c.step then
						sprite.fill(sprite.screen(), (x - 1) * BW, (y - 1) * BH, BW - 1, BH/2, 'yellow');
					end
					c.step = not c.step
				end
				if c[1] == MINE and c.activated and c.move > MINE_TO then
					explode.add(map.data, x - 1, y - 1)
				end
			end
		end
		explode.draw(s.data)
		if maps[s.nr].life then
			maps[s.nr].life(s.data)
		end
	end;
	after = function(s)
		if maps[s.nr].after then
			maps[s.nr].after(s.data)
		end
	end
}
dofile "levels.lua"
