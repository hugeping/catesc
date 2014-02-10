snake = {
	step = function(s)
		local k, v
		local dx = 0
		local dy = 0
		if not s.pos then s.pos = 1 end
		local to = s.path[s.pos]
		local x, y = s.snake[1][1], s.snake[1][2]
		if to[1] == x and to[2] == y then
			s.pos = s.pos + 1
			to = s.path[s.pos]
			if s.pos > #s.path then
				s.pos = 1
				to = s.path[s.pos]
			end
		end
		if to[1] < x then dx = -1 elseif to[1] > x then dx = 1 end
		if to[2] < y then dy = -1 elseif to[2] > y then dy = 1 end
		print(x, y, "to", to[1], to[2])
		x = x + dx
		x = y + dy

		for k, v in ipairs(s.snake) do
			local ox, oy = v[1], v[2]
			v[1], v[2] = x, y
			x, y = ox, oy
		end
	end;
	draw = function(s)
		local k, v
		for k, v in ipairs(s.snake) do
			sprite.fill(sprite.screen(), v[1] * BW, v[2] * BH, BW, BH, 'red');
		end
	end;
}

maps = {
	{
		title = "1:Cats cant swim";
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
		title = "2:Be careful!",
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
		title = "3:Tramboline",
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
'                        %%%%%%          ';
'                                        ';
'                                        ';
'                %%%%%%                  ';
'                                        ';
'                                        ';
'        %%%%%%                          ';
'                                        ';
'>                                       ';
'########                        ########';
'       #                        #       ';
'       #                        #       ';
'       #                        #       ';
'       #                        #       ';
'       #~~~~~~~~~~~~~~~~~~~~~~~~#       ';
};
},
	{
		title = "4:Ladder";
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
'                                ########';
'                        *########       ';
'        +       *########               ';
'>       #########                       ';
'#########                               ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
};

},
	{
		title = "5:Laser";
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
'>                  *                    ';
'########################################';
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
life = function(s)
	if hero.x < 10 * BW then
		s.laser = false
	end
	if hero.x > 10 * BW and hero:state() == WALK then
		s.laser = true
	end
	if s.laser then
		local c = 'red'
		if rnd(50) > 25 then
			c = 'yellow'
		end
		sprite.fill(sprite.screen(), 19 * BW + BW / 2 - 2, 0, 3, 19 * BH, c);
		laser_play()
		if hero:collision(19 * BW + BW / 2 - 2, 0, 3, 19 * BH) then
			hero:state(FLY)
		end
	else
		laser_mute();
	end
end
},
	{
		title = "6:Dont be so fast";
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
'>                                       ';
'#########        ######        #########';
'#                                       ';
'#                                       ';
'#                                       ';
'#                                       ';
'#                                       ';
'#                                       ';
'#                                       ';
'#                                       ';
'#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~';
};
life = function(s)
	if not s.step then
		s.step = 0
	end
	s.step = s.step + 1
	local y, x
	y = 20
	for x = 16, 23 do
		local c = map:cell(x, y)
		if math.floor(s.step / 50) % 2 == 0 then
			c[1] = BLOCK
		else
			c[1] = 0
		end
	end
end
},

	{
		title = "7:Dont stop!";
		map = {
'         #####   #####   #####          ';
'          ###     ###     ###           ';
'           *       *       *            ';
'                                        ';
'          # #     # #     # #           ';
'          # #     # #     # #           ';
'########### ####### ####### ############';
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
'>                                       ';
'########### ############### ############';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~';
};
life = function(s)
	if not s.y then
		s.y = 3
	end
	local c = map:cell(11, s.y)
	c[1] = 0
	c = map:cell(27, s.y)
	c[1] = 0

	c = map:cell(19, s.y)
	c[1] = 0

	s.y = s.y + 1

	if s.y >= 29 then
		s.y = 3
	end 
	c = map:cell(11, s.y)
	c[1] = EMERGENCY

	c = map:cell(19, s.y)
	c[1] = EMERGENCY

	c = map:cell(27, s.y)
	c[1] = EMERGENCY
end
},

	{
		title = "8:Walk!";
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
'  ###########^^^^^^^^^^^^^###########   ';
'                                        ';
'                                        ';
'                                        ';
'>                                       ';
'#########                      #########';
'        #                      #        ';
'        #                      #        ';
'        #                      #        ';
'        #                      #        ';
'        #                      #        ';
'        #                      #        ';
'        #                      #        ';
'        #                      #        ';
'~~~~~~~~#                      #        ';
};
life = function(s)
	local c
	if not s.x then
		s.x = 9
	end
	local x
	for x = 9, 9 + 21 do
		c = map:cell(x, 20)
		c[1] = 0
	end
	local sx = math.floor(s.x)
	x = sx - 4
	for x = sx - 3, sx do
		if x >= 9 and x < 32 then
			c = map:cell(x, 20)
			c[1] = BLOCK
		end
	end
	s.x = s.x + 0.2
	if s.x > 38 then
		s.x = 9
	end
end
},

	{
		title = "9:Jump!";
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
'###############^^^^^^^^^^^##############';
'                                        ';
'                                        ';
'                                        ';
'>                                       ';
'#########                      #########';
'        #*                    *#        ';
'        ########################        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
};
life = function(s)
	local c
	if not s.laser then
		s.laser = 50
	end
	s.laser = s.laser + 1 
	local c = 'red'
	if rnd(50) > 25 then
		c = 'yellow'
	end
	if math.floor(s.laser / 80) % 2 == 1 then 
		laser_play()
		sprite.fill(sprite.screen(), 10 * BW, 21 * BH + BH/2 - 2, 20 * BW, 3, c);
		if hero:collision(10 * BW, 21 * BH + BH/2 - 2, 20 * BW, 3) then
			hero:state(FLY)
		end
	else
		laser_mute()
	end
end
},

	{
		title = "10:Rope";
		map = {
'             +                         *';
'                                        ';
'                                        ';
'                                        ';
'=====-----------------------------------';
'                                        ';
'                                        ';
'                                        ';
'=====                                   ';
'                                        ';
'                                        ';
'                                        ';
'=====                                   ';
'                                        ';
'                                        ';
'                                        ';
'=====                                   ';
'                                        ';
'                                        ';
'>                                       ';
'#######                          #######';
'    #                              #    ';
'    #                              #    ';
'    #                              #    ';
'    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#    ';
'    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#    ';
'    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#    ';
'    ################################    ';
'                                        ';
'                                        ';
};
},


	{
		title = "11:Dont afraid";
		color = 'black';
		map = {
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~';
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~';
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~';
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~';
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~';
'                                        ';
'                                        ';
'                                        ';
'                                 #######';
'                                 #     #';
'                                 #     #';
'                                 #     #';
'                                 #     #';
'                                 #     #';
'                                 #     #';
'                                 #     #';
'                                 #     #';
'                                 #     #';
'                                 #     #';
'>                                #     #';
'#######     #####     #####      #     #';
'                                 #######';
'                                        ';
'                                        ';
'                                        ';
'      -------###-------###              ';
'             ###       ###              ';
'             ###       ###  ###         ';
'+        *   ###   *   ###  #*#         ';
'########################################';
};
},

	{
		title = "12:Lift";
		color = 'white';
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
'                            ====########';
'                                *       ';
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
'>                               *       ';
'########################################';
};
life = function(s)
	local y = 29 * BH
	local x = 28 * BW
	local draw_lift = function(s)
		sprite.fill(sprite.screen(), x, s.y, 64, 4, 'black')
	end

	if hero.x >= 29 * BW then
		local c = 'red'
		if rnd(50) > 25 then
			c = 'yellow'
		end
		laser_play();
		sprite.fill(sprite.screen(), 32 * BW + BW / 2 - 2, 17 * BH, 4, 11 * BH, c);
		if hero:collision(32 * BW + BW / 2 - 2, 17 * BH, 4, 11 * BH) then
			hero:state(FLY)
		end
	else
		laser_mute()
	end

	if not s.y then s.y = y end
	if s.y == 15 * BH then return end
	if (hero.y + hero.h) - BH <= s.y and hero.x >= x and (hero.x + hero.w) <= x + 64 then
		if not s.lift and hero:state() ~= WALK or math.abs(hero.speed_x) > 0 then
			return
		end
		s.lift = true
		if s.y ~= 15 * BH then
			hero.y = s.y - hero.h - 1
			hero:state(WALK)
			hero.speed_x = 0
		end
	end
	if s.lift then
		s.y = s.y - 1
		if s.y <= 15 * BH then s.y = 15 * BH end
		draw_lift(s)
	end
end

},

	{
		title = "13:Snake";
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
'########                                ';
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
'>                                       ';
'########################################';
};
life = function(s)
	local v = { {10,2}, {11, 2}, {12, 2}, {13, 2}, {14, 2} };
	local path = { { 3, 2 }, { 3, 20}, {10, 20}, {10, 2} };
	if not s.snake then
		s.snake = v
	end
	if not s.path then
		s.path = path
	end
	snake.step(s)
	snake.draw(s)
end

},

	{
		title = "4:",
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
				laser_play()
				sprite.fill(sprite.screen(), 0, 24 * 16 - hero.h, 340, 3, 'red');
				if hero:collision(0, 24 * 16 - hero.h, 340, 3) then
					hero:state(FLY)
				end
			else
				laser_mute()
			end
		end;

},


}
