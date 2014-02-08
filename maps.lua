global {
	map_nr = 1;
	map_data = {};
}
function hero_collision(x, y, w, h)
	if hero_state == HERO_DEAD or hero_state == HERO_FLY or hero_state == HERO_DROWN then
		return
	end
	if hero_x + hero_w <= x then
		return
	end
	if hero_y + hero_h <= y then
		return
	end
	if hero_x > x + w then
		return
	end
	if hero_y > y + h then
		return
	end
	return true
end

function select_map(n)
	map_nr = n;
	if title then
		sprite.free(title);
	end
	title = sprite.text(fn, string.format("%d: %s", n, maps[n].title), "black");
	map = maps[n].map;
	if hero_state == DEAD then
		hero_x = maps[n].x
		hero_y = maps[n].y
		map_data = {}
		hero_state = FALL;
		hero_speed_x = 0
		hero_move = 0
	else
		hero_x = 0
	end
end

function map_next()
	local n
	n = map_nr + 1;
	map_data = {}
	select_map(n)
end

function map_life()
	if maps[map_nr].life then
		maps[map_nr].life()
	end
end

maps = {
	{
		x = 0,
		y = 0,
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
'#######****#############################';
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
};
		life = function()
			if not map_data.x then
				map_data.x = 640
				map_data.y = 216
			end
			sprite.fill(sprite.screen(), map_data.x, map_data.y, 16, 16, 'red');
			map_data.x = map_data.x - 2
			if map_data.x < -10 then map_data.x = 640; map_data.y = map_data.y + 0 end
			if hero_collision(map_data.x, map_data.y, 16, 16) then
				hero_state = FLY
				hero_move = 0
			end
		end;
	},
	{
		x = 0,
		y = 0,
		title = "Again", 
		map = 'pic/map1.png';
	}
}
