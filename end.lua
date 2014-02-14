end_map = {
		title = "free:Freedom",
		color = '#00001c';
		map = {
'                                        ';-- 0
'                                        ';-- 1
'                                        ';-- 2
'                                        ';-- 3
'                                        ';-- 4
'                                        ';-- 5
'                                        ';-- 6
'                                        ';-- 7
'                                        ';-- 8
'                                        ';-- 9
'                                        ';-- 1
'                                        ';-- 11
'                                        ';-- 12
'                                        ';-- 13
'                                        ';-- 14
'                                        ';-- 15
'                                        ';-- 16
'                                        ';-- 17
'                                        ';-- 18
'>                                       ';-- 19
'                                        ';-- 20
'                                        ';-- 21
'                                        ';-- 22
'                                        ';-- 23
'                                        ';-- 24
'                                        ';-- 25
'                                        ';-- 26
'                                        ';-- 27
'                                        ';-- 28
'                                        ';-- 29
};
--[[
 0123456789012345678901234567890123456789
           1         2         3
]]--
exit = function(s)
	s.title_pos = nil
	local k,v
	if end_stats then
		for k,v in pairs(end_stats) do
			sprite.free(v)
		end
	end
	end_stats = nil
end;
after = function(s)
--[[	
	if hero:state() == JUMP then
		sprite.fill(sprite.screen(0), hero.x + hero.w - 34, hero.y + hero.h / 2 + 3, 20, 3, 'black');
		sprite.fill(sprite.screen(0), hero.x + hero.w - 34, hero.y + hero.h / 2 + 1, 6, 7, 'black');
	else
		sprite.fill(sprite.screen(0), hero.x + hero.w - 34, hero.y + hero.h / 2 + 5, 20, 3, 'black');
		sprite.fill(sprite.screen(0), hero.x + hero.w - 34, hero.y + hero.h / 2 + 3, 6, 7, 'black');
	end
	if key_space then
		local c = 'cyan'
		if rnd(50) > 25 then c = 'red' end
		local d 
		if hero:state() == FALL then d = 3 else d = 0 end
		sprite.fill(sprite.screen(0), hero.x + hero.w - 8, hero.y + hero.h / 2 + 3 + d, 640, 2, c);
		laser_play()
	else
		laser_mute()
	end
]]--
end;
life = function(s)
	local SG = 0.1
	local x, y, i, c
	G = 0
	GX = 0
	set_music 'snd/music2.ogg'
	if (game_lifes > 1 or bonus_timer) and (s.title_pos and s.title_pos > 3 ) then
		if not bonus_timer then 
			bonus_timer = 0
			game_lifes = game_lifes - 1
			game:dist(game:dist() + 100)
			sound.play(bonus_snd)
		end
		bonus_timer = bonus_timer + 1
		if bonus_timer > 60 then
			bonus_timer = nil
		end
	end
	map:dist(0)
	if not s.dy then s.dy = 0 end
	if not s.dx then s.dx = 1 end
	hero.speed_y = 0
	hero.speed_x = 0
	hero.jump_speed = 0
	if hero.x <= -rnd(10) then s.dx = 1 end
	if hero.x >= rnd(hero.w*2) + 4*hero.w then s.dx = -1 end
	if key_right then
		s.dy = s.dy + SG
		if s.dy > 8 then s.dy = 8 end
	elseif key_left then
		s.dy = s.dy - SG
		if s.dy < -8 then s.dy = -8 end
	else
		s.dy = s.dy * 0.99
	end
	if s.dy >= 1 then
		hero.st = FALL
	elseif s.dy <= -1 then
		hero.st = JUMP
	else
		hero.st = JUMP
	end
	hero.y = hero.y + s.dy
	hero.x = hero.x + s.dx
	if hero.y < 0 and s.dy < 0 then hero.y = 0 end
	if hero.y > 480 - hero.h then hero.y = 480 - hero.h end
	hero.dir = 1
	sprite.fill(sprite.screen(0), 0, 0, 640, 16 * 4, 'blue');
	if not s.stars then
		s.stars = {}
		for i = 1, 80 do
			table.insert(s.stars, {rnd(640), rnd(680) - 100, (rnd(8) + 1)})
		end
	end
	for i=1, 80 do
		x = s.stars[i][1]
		y = s.stars[i][2]
		c = 'white'
		if s.stars[i][3] <= 2 then c = '#0000ff';
		elseif s.stars[i][3] <= 3 then c = '#1d1d1d';
		elseif s.stars[i][3] <= 4 then c = '#ff0000'; 
		elseif s.stars[i][3] <= 5 then c = 'cyan'; 
		elseif s.stars[i][3] <= 6 then c = 'white'; end
		sprite.fill(sprite.screen(), x, y, 2, 2, c);
		s.stars[i][1] = s.stars[i][1] - s.stars[i][3]
		if hero.y == 0 and s.dy < 0 or hero.y == 480 - hero.h and s.dy > 0 then
			s.stars[i][2] = s.stars[i][2] - s.dy / 2
		end
		if s.stars[i][1] < 0 then
			s.stars[i][1] = 640
			s.stars[i][2] = rnd(680) - 100
			s.stars[i][3] = (rnd(8) + 1)
		end
	end

	if not end_stats and s.title_pos and s.title_pos >= #ending_spr then
		end_stats = {}
		end_stats[1] = sprite.text(fn, string.format(_"stat_score:YOUR SCORE: %s", game:dist() + map:dist()), "white")
		end_stats[2] = sprite.text(fn, string.format(_"stat_record:YOUR RECORD: %s", prefs.game_record), "white")
	end

	if not s.title_pos then s.title_pos = 1 
	else
		if s.title_pos <= 3 or game_lifes == 1 then
			s.title_pos = s.title_pos + 0.005 
		end
	end

	if end_stats then
		if math.floor(s.title_pos) > #ending_spr + #end_stats then s.title_pos = 1 end
	end

	if math.floor(s.title_pos) > #ending_spr then
		local w, h = sprite.size(end_stats[math.floor(s.title_pos) - #ending_spr])
		sprite.draw(end_stats[math.floor(s.title_pos) - #ending_spr], sprite.screen(), (640 - w) / 2, 480 - h);
	else
		local w, h = sprite.size(ending_spr[math.floor(s.title_pos)])
		sprite.draw(ending_spr[math.floor(s.title_pos)], sprite.screen(), (640 - w) / 2, 480 - h);
	end
end
}

table.insert(maps, end_map)

maps[CONTMAP] = {
		title = "cont:Continue?",
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
'                    >                   ';
'########################################';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
};
life =  function(s)
	if not s.secs then s.secs = 10.9 end

	local w, h = sprite.size(gameover_spr);
	sprite.draw(gameover_spr, sprite.screen(), (640 - w)/2 + 1 - rnd(2), (100 - h)/2 + 1 - rnd(2))

	if hero.x <= -hero.w / 2 or s.secs <= 0 then
		game:state(INTRO)
		return
	end;
	w, h = sprite.size(continue_spr)
	local sec = sprite.text(fn_big, string.format("%d", s.secs))
	sprite.draw(continue_spr, sprite.screen(), (640 - w)/2, 100);
	w, h = sprite.size(sec)
	sprite.draw(sec, sprite.screen(), (640 - w)/2, 190);
	sprite.free(sec)
	s.secs = s.secs - 0.025
end
}

game.enable_save = false
