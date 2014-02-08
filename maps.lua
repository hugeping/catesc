global {
	map_nr = 1;
	map_data = {};
}

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
		if hero.state == DEAD then
			hero.x = maps[n].x
			hero.y = maps[n].y
			map.data = {}
			hero.state = FALL;
			hero.speed_x = 0
			hero.move = 0
		end
	end;
	next = function(s)
		local n
		n = s.nr + 1;
		s.data = {}
		s:select(n)
		if hero.state ~= DEAD then
			hero.x = 0
			hero.dir = 1
		end
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
					hero.state = FLY
					hero.move = 0
				end
			end
		end;

},


}
