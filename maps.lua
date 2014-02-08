global {
	map_nr = 1;
	map_data = {};
}

function select_map(n)
	map_nr = n;
	if title then
		sprite.free(title);
	end
	title = sprite.text(fn, string.format("%d: %s", n, maps[n].title), "black");
	map = maps[n].map;
	if hero.state == DEAD then
		hero.x = maps[n].x
		hero.y = maps[n].y
		map_data = {}
		hero.state = FALL;
		hero.speed_x = 0
		hero.move = 0
	end
end

function map_next()
	local n
	n = map_nr + 1;
	map_data = {}
	select_map(n)
	if hero.state ~= DEAD then
		hero.x = 0
		hero.dir = 1
	end
end

function map_life()
	if maps[map_nr].life then
		maps[map_nr].life()
	end
end

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
		lifex =  function()
			if not map_data.x then
				map_data.x = 640
				map_data.y = 216
			end
			sprite.fill(sprite.screen(), map_data.x, map_data.y, 16, 16, 'red');
			map_data.x = map_data.x - 2
			if map_data.x < -10 then map_data.x = 640; map_data.y = map_data.y + 0 end
			if hero:collision(map_data.x, map_data.y, 16, 16) then
				hero.state = FLY
				hero.move = 0
			end
		end;
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
		life =  function()
			if not map_data.laser then
				map_data.laser = 60
			end
			map_data.laser = map_data.laser - 1
			if map_data.laser <= 0 then
				map_data.laser = 60
			end
			if map_data.laser <= 10 then
				sprite.fill(sprite.screen(), 0, 24 * 16 - hero.h, 340, 3, 'red');
				if hero:collision(0, 24 * 16 - hero.h, 340, 3) then
					hero.state = FLY
					hero.move = 0
				end
			end
		end;

},


}
