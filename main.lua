--$Name:Cats adventure$
instead_version "1.9.0"
require "sprites"
require "timer"
require "kbd"
require "sound"
require "prefs"
dofile "maps.lua"

function hero_draw(x, y, state, dir, xd, yd, ww, hh)
	local xoff = state * (23 * 3)
	if dir < 0 then
		xoff = (3 - state) * (23 * 3)
	else
		xoff = state * (23 * 3)
	end
	local yoff = 0;
	local w = 23 * 3;
	local h = 19 * 3;
	if xd then xoff = xoff + xd end
	if yd then yoff = yoff + yd end
	if ww then w = ww end
	if hh then h = hh end
	if dir < 0 then
		sprite.draw(hero_spr_left, xoff, yoff, w, h, sprite.screen(), x, y);
	else
		sprite.draw(hero_spr, xoff, yoff, w, h, sprite.screen(), x, y);
	end
end

function init()
	fn = sprite.font("font.ttf", 16);
	hero_spr = sprite.load "pic/cat.png"
	hero_spr_left = sprite.scale(hero_spr, -1.0, 1, false)
	hook_keys('right', 'left', 'space');
	hero_state = DEAD
	select_map(1)
end
function map_show()
	local y, x
	for y=0, 29 do
		for x=0, 39 do
			local r, g, b = sprite.pixel(map, x, y)
			if r == 255 and g == 255 and b == 255 then
				sprite.fill(sprite.screen(), x * 16 + 1, y * 16 + 1, 16 - 2, 16 - 2, 'black');
			end
			if r == 0 and g == 0 and b == 255 then
				sprite.fill(sprite.screen(), x * 16 - 1, y * 16, 16 + 2, 16, 'blue');
			end

			if r == 255 and g == 0 and b == 0 then
				sprite.fill(sprite.screen(), x * 16, y * 16, 16, 16, 'red');
			end

		end
	end
end

function map_block(x, y)
	x = x / BW;
	y = y / BH;
	local r, g, b = sprite.pixel(map, x, y)
	if r == 255 and g == 255 and b == 255 then
		return BLOCK
	end
	if r == 0 and g == 0 and b == 255 then
		hero_state = DROWN
		hero_move = 0
		return WATER
	end

	if r == 255 and g == 0 and b == 0 then
		hero_state = FLY
		hero_move = 0
		return EMERGENCY
	end

	return
end
function map_is_fall(x, y, w)
	local xx
	for xx = 0, math.floor((w - 1) / BW) do
		if map_block(x + xx * BW, y) then
			return false
		end
	end
	return true
end

function map_is_move(x, y, h)
	local yy
	for yy = 0, math.floor((h - 1) / BH) do
		if map_block(x, y + yy*BH) then
			return false
		end
	end
	return true
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

	if x < -hero_w / 2 then
		x = -hero_w / 2
	end

	return math.floor(x), math.floor(y), blockx, blocky
end

function start()
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

hero_h = 19 * 3 - 8
hero_w = 23 * 3 - 16
hero_xoff = 8
hero_yoff = 8

global {
	hero_move = 0;
	hero_x = 10;
	hero_y = 0;
	hero_speed_x = 0;
	hero_state = FALL;
	hero_dir = 1;
	hero_jump_speed = 0;
}

game.timer = function(s)
	local blockx, blocky
	sprite.fill(sprite.screen(), '#bbbbbb')
	map_show()
	map_life()
	if hero_state == JUMP then
		hero_move = hero_move + 1
		local d = hero_jump_speed - hero_move * G;
		if d <= 0 then
			d = 0
		end
		hero_x, hero_y, blockx, blocky = map_move(hero_x, hero_y, 
			hero_speed_x, -d, hero_w, hero_h);
		if blockx then
			hero_speed_x = hero_speed_x * 0.75
		end
		if d <= 0 or blocky  then
			hero_state = FALL
			hero_move = 0
		end
	elseif hero_state == FALL then
		hero_move = hero_move + 1
		local d = hero_move * G;
		hero_x, hero_y, blockx, blocky = map_move(hero_x, hero_y, 
			hero_speed_x, d, 
			hero_w, hero_h);
		if blocky then
			hero_state = WALK;
		end
	elseif hero_state == WALK then
		if key_right or key_left then
			if key_right then
				hero_dir = 1
				hero_speed_x = hero_speed_x + GX
				if hero_speed_x > MAX_SPEEDX then
					hero_speed_x = MAX_SPEEDX
				end
			else
				hero_dir = -1
				hero_speed_x = hero_speed_x - GX
				if hero_speed_x < -MAX_SPEEDX then
					hero_speed_x = -MAX_SPEEDX
				end
			end
		else
			local gx = GX
			if hero_speed_x ~= 0 then
				if hero_speed_x > 0 then
					gx = - gx
				end
				hero_speed_x = hero_speed_x + gx
				if gx < 0 and hero_speed_x < 0 or gx > 0 and hero_speed_x > 0 then
					hero_speed_x = 0
				end
			end
		end
		if key_space then
			key_space = false
			hero_state = JUMP
			hero_move = 0
			hero_jump_speed = math.abs(hero_speed_x)* 0.75 + JUMP_SPEED 
		elseif hero_speed_x ~= 0 then
			hero_move = hero_move + 1
			hero_x, hero_y, blockx, blocky = map_move(hero_x, hero_y, 
				hero_speed_x, 0, 
				hero_w, hero_h);
			if blockx then
				hero_speed_x = 0
			end
			if not blocky then
				hero_state = FALL
				hero_move = 0
			end
		end
	elseif hero_state == DROWN then
		hero_move = hero_move + 2
		if hero_move >= 19 * 3 then
			hero_state = DEAD
		end
	elseif hero_state == FLY then
		hero_move = hero_move + 3
		if hero_move > 50 then
			local d = JUMP_SPEED + (hero_move - 50) * G;
			hero_y = hero_y - d
			if hero_y < - 19 * 3 then
				hero_state = DEAD
			end
		else
			hero_dir = -1 * hero_dir
		end
	end
	if hero_state == WALK or hero_state == FLY then
		if math.abs(hero_speed_x) >= SPEED_RUN then
			hero_draw(hero_x - hero_xoff, hero_y - hero_yoff, (math.floor(hero_move / 10)) % 2 +  2, hero_dir)
		else
			hero_draw(hero_x - hero_xoff, hero_y - hero_yoff, (math.floor(hero_move / 10)) % 2, hero_dir)
		end
	elseif hero_state == JUMP then
		hero_draw(hero_x - hero_xoff, hero_y - hero_yoff, 2, hero_dir)
	elseif hero_state == FALL then
		hero_draw(hero_x - hero_xoff, hero_y - hero_yoff, 3, hero_dir)
	elseif hero_state == DROWN then
		hero_draw(hero_x - hero_xoff, hero_y - hero_yoff + hero_move, 0, hero_dir, 0, 0, 23 * 3, 19 * 3 - hero_move)
	elseif hero_state == DEAD then
		select_map(map_nr)
	end
	if hero_x >= 640 then
		map_next()
	end
	sprite.draw(title, sprite.screen(), 0, 0);
end
