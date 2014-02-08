--$Name:Cats adventure$
instead_version "1.9.0"
require "sprites"
require "timer"
require "kbd"
require "sound"
require "prefs"

function init()
	fn = sprite.font("font.ttf", 16);
	hero_spr = sprite.load "pic/cat.png"
	hero_spr_left = sprite.scale(hero_spr, -1.0, 1, false)
	hook_keys('right', 'left', 'space');
	hero.state = DEAD
	
end

function map_show()
	local y, x
	for y=0, 29 do
		for x=0, 39 do
			local l = map[y + 1];
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
end

function map_block(x, y)
	x = math.floor(x / BW);
	y = math.floor(y / BH);
	if x < 0 or y < 0 or x >= 60 or y >= 30 then
		return
	end
	local l = map[y + 1];
	local c = string.sub(l, x + 1, x + 1);

	if c == '#' then
		return BLOCK
	end

	if c == '~' then
		hero.state = DROWN
		hero.move = 0
		return WATER
	end

	if c == '*' then
		hero.state = FLY
		hero.move = 0
		return EMERGENCY
	end

	return
end
function map_is_fall(x, y, w)
	local xx
	local rc = true
	for xx = 0, math.floor((w - 1) / BW) do
		if map_block(x + xx * BW, y) then
			rc = false
		end
	end
	return rc
end

function map_is_move(x, y, h)
	local yy
	local rc = true
	for yy = 0, math.floor((h - 1) / BH) do
		if map_block(x, y + yy*BH) then
			rc = false
		end
	end
	return rc
end

function map_move(x, y, dx, dy, w, h)
	local blockx = false
	local blocky = false
	local xx = x
	local yy = y
	if dx >= 0 then
		xx = xx + w
	end
	if dy >= 0 then
		yy = yy + h
	end
	if map_is_fall(x, yy + dy, w) then
		y = y + dy
	else
		y = math.floor((yy + dy) / BH) * BH
		if dy >= 0 then
			y = y - h
		else
			y = y + BH
		end
		blocky = true
	end

	if map_is_move(xx + dx, y, h) then
		x = x + dx
	else
		x = math.floor((xx + dx) / BW) * BW 
		if dx >= 0 then
			x = x - w
		else
			x = x + BW
		end
		blockx = true
	end

	if x < -hero.w / 2 then
		x = -hero.w / 2
	end

	return math.floor(x), math.floor(y), blockx, blocky
end

function start()
	select_map(map_nr)
	timer:set(20);
end

key_input = {}
key_space_pass = true
game.kbd = function(s, down, key)
	if down then
		if key == 'left' or key == 'right' and key_input[1] ~= key then
			table.insert(key_input, 1, key)
			if #key_input >=3 then
				table.remove(key_input, 3)
			end
		elseif key == 'space' then
			if key_space_pass then
				key_space = true;
				key_space_pass = false
			end
		end
	else
		if key == 'left' or key == 'right'  then
			if key_input[2] == key then
				table.remove(key_input, 2)
			end
			if key_input[1] == key then
				table.remove(key_input, 1)
			end
		elseif key == 'space' then
			key_space = false;
			key_space_pass = true;
		end
	end
	if key_input[1] == 'left' then
		key_left, key_right = true, false
	elseif key_input[1] == 'right' then
		key_left, key_right = false, true
	else
		key_left, key_right = false, false
	end
end

BLOCK = 1
WATER = 2
EMERGENCY = 3

WALK = 1
JUMP = 2
FALL = 3
DROWN = 4
DEAD = 5
FLY = 6

JUMP_SPEED = 5
SPEED_RUN = 5
MAX_SPEEDX = 5

G = 0.5
GX = 0.25

BW = 16
BH = 16


global {
}
hero = obj {
	nam = 'hero';
	var {
		move = 0;
		x = 10;
		y = 0;
		speed_x = 0;
		state = FALL;
		dir = 1;
		jump_speed = 0;
		h = 19 * 3 - 8;
		w = 23 * 3 - 16;
		xoff = 8;
		yoff = 8;
	};
	life = function (s)
		local block_x, block_y
		if s.state == JUMP then
			s.move = s.move + 1
			local d = s.jump_speed - hero.move * G;
			if d <= 0 then
				d = 0
			end
			s.x, s.y, block_x, block_y = map_move(s.x, s.y, 
				s.speed_x, -d, s.w, s.h);
			if block_x then
				s.speed_x = s.speed_x * 0.75
			end
			if d <= 0 or block_y  then
				s.state = FALL
				s.move = 0
			end
		elseif s.state == FALL then
			s.move = s.move + 1
			local d = s.move * G;
			s.x, s.y, block_x, block_y = map_move(s.x, s.y, 
				s.speed_x, d, 
				s.w, s.h);
			if block_y then
				s.state = WALK;
			end
		elseif s.state == DROWN then
			s.move = s.move + 2
			if s.move >= 19 * 3 then
				s.state = DEAD
			end
		elseif s.state == FLY then
			s.move = s.move + 3
			if s.move > 50 then
				local d = JUMP_SPEED + (s.move - 50) * G;
				s.y = s.y - d
				if s.y < - 19 * 3 then
					s.state = DEAD
				end
			else
				s.dir = -1 * s.dir
			end
		elseif s.state == WALK then
			if s.speed_x ~= 0 then
				s.move = s.move + 1
				s.x, s.y, block_x, block_y = map_move(s.x, s.y, 
					s.speed_x, 0, 
					s.w, s.h);
				if block_x then
					s.speed_x = 0
				end
				if not block_y then
					s.state = FALL
					s.move = 0
				end
			end
			s:input()
		else
			return false
		end
		return true;
	end;
	input = function(s)
		if s.state == WALK then
			if key_right or key_left then
				if key_right then
					s.dir = 1
					s.speed_x = s.speed_x + GX
					if s.speed_x > MAX_SPEEDX then
						s.speed_x = MAX_SPEEDX
					end
				else
					s.dir = -1
					s.speed_x = s.speed_x - GX
					if s.speed_x < -MAX_SPEEDX then
						s.speed_x = -MAX_SPEEDX
					end
				end
			else
				local gx = GX
				if s.speed_x ~= 0 then
					if s.speed_x > 0 then
						gx = - gx
					end
					s.speed_x = s.speed_x + gx
					if gx < 0 and s.speed_x < 0 or gx > 0 and s.speed_x > 0 then
						s.speed_x = 0
					end
				end
			end
			if key_space then
				key_space = false
				s.state = JUMP
				s.move = 0
				s.jump_speed = math.abs(s.speed_x)* 0.75 + JUMP_SPEED 
			end
		end
	end;
	draw = function (s)
		local x, y, state, fx, fy, fw, fh
		x = s.x - s.xoff
		y = s.y - s.yoff
		if s.state == WALK or s.state == FLY then
			if math.abs(s.speed_x) >= SPEED_RUN then
				state = (math.floor(s.move / 10)) % 2 +  2
			else
				state = (math.floor(s.move / 10)) % 2 
			end
		elseif s.state == JUMP then
			state = 2
		elseif hero.state == FALL then
			state = 3
		elseif hero.state == DROWN then
			y = s.y - s.yoff + s.move
			state = 0
			fx = 0
			fy = 0
			fw = 23 * 3
			fh = 19 * 3 - s.move
		else
			state = s.state
		end

		local xoff = state * (23 * 3)
		if s.dir < 0 then
			xoff = (3 - state) * (23 * 3)
		else
			xoff = state * (23 * 3)
		end
		local yoff = 0;
		local w = 23 * 3;
		local h = 19 * 3;
		if fx then xoff = xoff + fx end
		if fy then yoff = yoff + fy end
		if fw then w = fw end
		if fh then h = fh end
		if s.dir < 0 then
			sprite.draw(hero_spr_left, xoff, yoff, w, h, sprite.screen(), x, y);
		else
			sprite.draw(hero_spr, xoff, yoff, w, h, sprite.screen(), x, y);
		end
	end;
	collision = function(s, x, y, w, h)
		if s.state == HERO_DEAD or s.state == HERO_FLY or s.state == HERO_DROWN then
			return
		end
		if s.x + s.w <= x then
			return
		end
		if s.y + s.h <= y then
			return
		end
		if s.x > x + w then
			return
		end
		if s.y > y + h then
			return
		end
		return true
	end
}

game.timer = function(s)
	sprite.fill(sprite.screen(), '#bbbbbb')
	map_show()
	map_life()
	hero:draw();
	hero:life();
	if hero.state == DEAD then
		select_map(map_nr)
	elseif hero.x >= 640 then
		map_next()
	end

	sprite.draw(title, sprite.screen(), 0, 0);
end

dofile "maps.lua"
