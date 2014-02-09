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
	hero:state(DEAD)
end


function start()
	map:select()
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
SEMIBLOCK = 4
BRIDGE = 5

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
		st = FALL;
		dir = 1;
		jump_speed = 0;
		h = 19 * 3 - 8;
		w = 23 * 3 - 16;
		xoff = 8;
		yoff = 8;
	};
	state = function(s, n)
		local os = s.st
		if n then
			if n ~= os then
				s.move = 0
			end
			s.st = n
			if n == JUMP or n == FLY then
				s.jump_speed = math.abs(s.speed_x)* 0.75 + JUMP_SPEED 
			end
		end
		return os
	end;
	life = function (s)
		local block_x, block_y
		if s:state() == JUMP then
			s.move = s.move + 1
			local d = s.jump_speed - hero.move * G;
			if d <= 0 then
				d = 0
			end
			s.x, s.y, block_x, block_y = map:move(s.x, s.y, 
				s.speed_x, -d, s.w, s.h);
			if block_x then
				s.speed_x = s.speed_x * 0.75
			end
			if d <= 0 or block_y  then
				s:state(FALL)
			end
		elseif s:state() == FALL then
			s.move = s.move + 1
			local d = s.move * G;
			s.x, s.y, block_x, block_y = map:move(s.x, s.y, 
				s.speed_x, d, 
				s.w, s.h);
			if s.y > 480 then
				s:state(DEAD)
			elseif block_y then
				s:state(WALK);
			end
		elseif s:state() == DROWN then
			s.move = s.move + 2
			if s.move >= 19 * 3 then
				s:state(DEAD)
			end
		elseif s:state() == FLY then
			s.move = s.move + 2
			local d = s.jump_speed - s.move * G;
			s.y = s.y - d
			if s.y > 480 then
				s:state(DEAD)
			end
		elseif s:state() == WALK then
			local x, y
			if s.speed_x ~= 0 then
				s.move = s.move + 1
				s.x, s.y, block_x, block_y = map:move(s.x, s.y, 
					s.speed_x, 0, 
					s.w, s.h);
				if block_x then
					s.speed_x = 0
				end
			else
				x, y, block_x, block_y = map:move(s.x, s.y, 0, 0, s.w, s.h);
			end
			if not block_y then
				s:state(FALL)
			else
				s:input()
			end
		else
			return false
		end
		return true;
	end;
	input = function(s)
		if s:state() == WALK then
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
				s:state(JUMP)
			end
		end
	end;
	draw = function (s)
		local x, y, state, fx, fy, fw, fh
		x = s.x - s.xoff
		y = s.y - s.yoff
		if s:state() == WALK or s:state() == FLY then
			if math.abs(s.speed_x) >= SPEED_RUN then
				state = (math.floor(s.move / 10)) % 2 +  2
			else
				state = (math.floor(s.move / 10)) % 2 
			end
		elseif s:state() == JUMP then
			state = 2
		elseif s:state() == FALL then
			state = 3
		elseif s:state() == DROWN then
			y = s.y - s.yoff + s.move
			state = 0
			fx = 0
			fy = 0
			fw = 23 * 3
			fh = 19 * 3 - s.move
		else
			state = s:state()
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
		if s:state() == HERO_DEAD or s:state() == HERO_FLY or s:state() == HERO_DROWN then
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
	map:show()
	map:life()
	hero:draw();
	hero:life();
	if hero:state() == DEAD then
		map:select()
	elseif hero.x >= 640 then
		map:next()
	end

	sprite.draw(map.title, sprite.screen(), 0, 0);
end

dofile "maps.lua"
dofile "i18n.lua"
