laser = {
	on = function(x, y, len)
		local w, h
		local c = 'red'
		if rnd(50) > 25 then
			c = 'yellow'
		end
		if len > 0 then
			x = x * BW + BW / 2 - 2
			y = y * BH
			w = 3
			h = len * BH
		else
			x = x * BW
			y = y * BH + BH/2 - 2
			w = -len * BW
			h = 3
		end
		sprite.fill(sprite.screen(), x, y, w, h, c)
		laser_play()
		if hero:collision(x, y, w, h) then
			hero:state(FLY)
		end
	end;
	off = function()
		laser_mute();
	end
}

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


		x = x + dx
		y = y + dy
		
		for k, v in ipairs(s.snake) do
			local ox, oy = v[1], v[2]
			v[1], v[2] = x, y
			x, y = ox, oy
		end
	end;
	draw = function(s)
		local k, v
		for k, v in ipairs(s.snake) do
			if k == 1 then
				sprite.fill(sprite.screen(), v[1] * BW, v[2] * BH, BW, BH, 'yellow');
			else
				sprite.fill(sprite.screen(), v[1] * BW, v[2] * BH, BW, BH, 'red');
			end
			if hero:collision(v[1] * BW, v[2] * BH, BW, BH) then
				hero:state(FLY)
			end
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
		laser.on(19, 0, 19);
	else
		laser.off()
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
	if math.floor(s.laser / 80) % 2 == 1 then 
		laser.on(10, 21, -20);
	else
		laser.off()
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
		laser.on(32, 17, 11);
	else
		laser.off()
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
'########################################';
'                                       #';
'                                       #';
'                                       #';
'                                       #';
'                                       #';
'>                                      #';
'#################################      #';
'                                       #';
'                                       #';
'                                       #';
'                                       #';
'                                       #';
'                                       #';
'      ##################################';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'########################################';
--[[
 0123456789012345678901234567890123456789
           1         2         3
]]--
};
life = function(s)
	local path = { { 32, 8 }, { 32, 29}, 
			{24, 29}, {24, 8},
			{16, 8}, {16, 29},
			{8, 29}, {8, 8}, 
			{0, 8}, {0, 29},
			{8, 29}, {8, 8},
			{16, 8}, {16, 29}, 
			{24, 29}, {24, 8},
			{32, 8}, {32, 29},
			{40, 29}, {40, 8} };
	if not s.path then
		s.path = path
	end
	if not s.snake then
		s.snake = {} 
		local k
		for k=1, 50 do
			table.insert(s.snake, {k + 50, 8})
		end
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
