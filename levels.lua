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
'                *########               ';
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
'  +                                     ';
'########################################';
--[[
 0123456789012345678901234567890123456789
           1         2         3
]]--
};
life = function(s)
	local path = { { 32, 8 }, { 32, 22}, 
			{24, 22}, {24, 8},
			{16, 8}, {16, 22},
			{8, 22}, {8, 8}, 
			{0, 8}, {0, 22},
			{8, 22}, {8, 8},
			{16, 8}, {16, 22}, 
			{24, 22}, {24, 8},
			{32, 8}, {32, 22},
			{40, 22}, {40, 8} };
	if not s.path then
		s.path = path
	end
	if not s.snake then
		s.snake = {} 
		local k
		for k=1, 40 do
			table.insert(s.snake, {k + 50, 8})
		end
	end
	snake.step(s)
	snake.draw(s)
end

},

	{
		title = "14:Rain";
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
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'>                                       ';
'########################################';
--[[
 0123456789012345678901234567890123456789
           1         2         3
]]--
	},
life = function(s)
	if hero:state() == JUMP or hero:state() == FALL then
		hero.speed_x = hero.speed_x - GX*0.60
		if hero.speed_x < -MAX_SPEEDX then
			hero.speed_x = -MAX_SPEEDX
		end
	end
	local k, v
	if not s.move then
		s.move = 0
		s.r = 2
	end
	s.move = s.move + 0.1
	if s.move > 20 then
		s.move = 0
		s.r = 1
	end
	for k=s.r, 2 do
		v = math.ceil(s.move)
		local c = map:cell(k * 20 - v, 28)
		if c then
			c[1] = EMERGENCY
		end
		c = map:cell(k * 20 - v + 1, 28)
		if c then
			c[1] = 0
		end
		if hero:collision((k * 20 - v) * BW, 28 * BH, BW, BH) then
			hero:state(FLY)
		end
	end
end;
after = function(s)
	local x, y, i
	if not s.rain then
		s.rain = {}
		for i = 1, 80 do
			table.insert(s.rain, {rnd(640), rnd(480), rnd(8) + 8 })
		end
	end
	for i=1, 80 do
		x = s.rain[i][1]
		y = s.rain[i][2]
		sprite.fill(sprite.screen(), x, y, 2, 12, 'blue');
		s.rain[i][2] = s.rain[i][2] + s.rain[i][3]
		s.rain[i][1] = s.rain[i][1] - 3
		if s.rain[i][2] > 480 or s.rain[i][1] < 0 or hero:collision(x, y + 12, 2, 2) then
			s.rain[i][1] = rnd(740)
			s.rain[i][2] = 0
			s.rain[i][3] = rnd(8) + 8
		end
	end
end
},

	{
		title = "15:Lasers";
		map = {
'          #########################     ';
'           *          *          *      ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                     ###';
'                                     #  ';
'                                     #  ';
'                                     #  ';
'>          *          *          *   #  ';
'######################################  ';
--[[
 0123456789012345678901234567890123456789
           1         2         3
]]--
},
life = function(s)
	if not s.state then
		s.state = 1
	end
	local k = math.ceil(s.state / 25) % 3
	if k == 1 then k = 2 elseif k == 2 then k = 0 else k = 1 end
	s.state = s.state + 1
	laser.on(11 + 11 * k, 2, 26);
end
},
{
	title = "16:Press",
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
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'>                                       ';
'########################################';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
};
		life =  function(s)
			if not s.water then
				s.water = 0
			end
			if s.water then
				sprite.fill(sprite.screen(), 0, 30 * BH - math.ceil(s.water), 640, math.ceil(s.water), 'blue');
				s.water = s.water + 0.2
				if 30 * BH - s.water < hero.y + hero.h and hero:alive()then
					hero:state(DROWN)
				end
			end
		   if not s.sq then
		      s.sq = true
		      s.squeezer = {}
		      s.squeezer_speed = {}
		      for a = 1, 3 do
			 s.squeezer[a] = 64
			 s.squeezer_speed[a] = a + 1
		      end
		   end
		   for a = 1, 3 do
		      s.squeezer[a] = s.squeezer[a] + s.squeezer_speed[a]
		      if s.squeezer[a] >= 13 * 16 or s.squeezer[a] < 64 then
			 s.squeezer_speed[a] = s.squeezer_speed[a] *-1
		      end
		      sprite.fill(sprite.screen(), a * 9 * 16 , 160, 21, s.squeezer[a], '#888888')
		      sprite.fill(sprite.screen(), a * 9 * 16 + 21 , 160, 22, s.squeezer[a], '#AAAAAA')
		      sprite.fill(sprite.screen(), a * 9 * 16 + 43 , 160, 21, s.squeezer[a], '#DDDDDD')
		      if hero:collision(a * 9 * 16 , 160, 64, s.squeezer[a]) then
			 hero:state(FLY)
		      end
		   end
		end;

},
{
	title = "17:Figure out",
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
'########                        ########';
'########                        ^^^^^^^^';
'########                        ^^^^^^^^';
'########                        ^^^^^^^^';
'########                        ^^^^^^^^';
'########                        ########';
};
--[[
 0123456789012345678901234567890123456789
           1         2         3
]]--

		life =  function(s)
			if hero:state() == JUMP or hero:state() == FALL and hero.x > 4 * BW and hero.y >= 24 * BH then
				if not s.pos then
					s.pos = 0
				end 
				local x, y, c
				for x = 4 + math.ceil(s.pos), 8 + math.ceil(s.pos) do
					for y = 24, 29 do
						c = map:cell(x, y)
						c[1] = 0
					end
				end

				s.pos = s.pos + 0.1
				if s.pos >= 23 then s.pos = 23 end
				for x = 4 + math.ceil(s.pos),8 + math.ceil(s.pos) do
					for y = 24, 29 do
						c = map:cell(x, y)
						c[1] = BLOCK
					end
				end
			end
		end;
},
{
	title = "18:Easy?",
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
'                        *       ########';
'                *       #########       ';
'        +       #########               ';
'>       #########                       ';
'#########                               ';
'                                        ';
'                                        ';
'                                        ';
'                +        +              ';
'########################################';
};
--[[
 0123456789012345678901234567890123456789
           1         2         3
]]--
},
{
	title = "19:Impossible?",
	map = {
'                                       #';
'                                       #';
'                                       #';
'                                       #';
'                                       #';
'                                       #';
'                                       #';
'                  +                    #';
'          ======                       #';
'                 # #                   #';
'                  *                   *#';
'                 # #                   #';
'                  *                   *#';
'  ======         # #                   #';
'                  *                   *#';
'                 # #                   #';
'                  *                   *#';
'                 # #                   #';
'           %%%%%  *                   *#';
'>                # #                   #';
'#####                                  #';
'                                       #';
'                                       #';
'                                       #';
'                                       #';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'#------------------------------#########';
};
--[[
 0123456789012345678901234567890123456789
           1         2         3
]]--
life = function(s)
	if not s.laser then
		s.laser = 0
	end
	if s.laser <= 5 then
		laser.on(19, 10 + 2 * math.floor(s.laser), -19);
	else
		laser.off()
	end
	s.laser = s.laser + 0.1
	if s.laser > 5 then s.laser = 0 end
end
},
	{
		title = "20:Mars",
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
'                 #########              ';
'                  *  *  *               ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                 #########              ';
'                 #       #              ';
'                 #       #              ';
'                 #       #              ';
'                 #       ###############';
'                 #                      ';
'                 #                      ';
'                 #                      ';
'>                #                      ';
'##################                      ';
};
life = function(s)
	if hero:state() == JUMP or hero:state() == FALL then
		G = 0.2
	else
		G = origG
	end
end;
},

	{
		title = "21:Faster, higher, stronger!",
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
'                              %%%%      ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                  %%%%                  ';
'                                        ';
'                                        ';
'                                        ';
'      +                                 ';
'      %%%%                              ';
'>                                       ';
'####                                ####';
'   #                               *#   ';
'   #                               ##   ';
'   #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#    ';
'   #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#    ';
'   #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#    ';
};
		life =  function(s)
			if not s.laser then
				s.laser = 60
			end
			s.laser = s.laser - 1
			if s.laser <= 0 then
				s.laser = 60
			end
			if s.laser <= 20 then
				laser.on(35, 0, 25);
			else
				laser.off()
			end
		end;

},
      	{
		title = "22:Be careful!",
		map = {
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'#####                                   ';
'    #                                   ';
'    #    ###############################';
'    #    #*                           *#';
'    #    #                             #';
'    #    #                          ####';
'    ######                          #   ';
'                                    #   ';
'                                    #   ';
'                                    #   ';
'                ####        ####    #   ';
'       ====     #  #        #  #    #   ';
'                #  #        #  #    #   ';
'                #  #        #  #    #   ';
'       ====     #  #        #  #    ####';
'                #  #        #  #        ';
'                #  #        #  #        ';
'       ####     #  #        #  #        ';
'>      #  #     #  #        #  #        ';
'########  #     #  #        #  #%%%%%%%%';
'          #~~~~~#  #~~~~~~~~#  #        ';
'          #~~~~~#  #~~~~~~~~#  #        ';
'          #~~~~~#  #~~~~~~~~#  #        ';
'          #~~~~~#  #~~~~~~~~#  #        ';
'          #~~~~~#  #~~~~~~~~#  #        ';
};
		life =  function(s)
			if not s.laser then
				s.laser = 60
			end
			s.laser = s.laser - 1
			if s.laser <= 0 then
				s.laser = 60
			end
			if s.laser <= 30 then
				laser.on(11, 8, -27); 
			else
				laser.off()
			end
		end;

},
      	{
		title = "23:Winter",
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
'                                  @@@@@@';
'                                  @@@@@@';
'                                  @@@@@@';
'                  *        *      @@@@@@';
'            @@@@@@@@@@@@@@@@@@@@@@@@@@@@';
'            @@@@@@@@@@@@@@@@@@@@@@@@@@@@';
'            @@@@@@@@@@@@@@@@@@@@@@@@@@@@';
'            @@@@@@@@@@@@@@@@@@@@@@@@@@@@';
'>           @@@@@@@@@@@@@@@@@@@@@@@@@@@@';
'@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@';
'@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@';
'@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@';
'@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@';
'@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@';
'@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@';
};
		life =  function(s)
			if hero:state() == WALK then
				RGX = 0.1
			else
				RGX = origRGX
			end
		end;

after = function(s)
	local x, y, i
	if not s.snow then
		s.snow = {}
		for i = 1, 80 do
			table.insert(s.snow, {rnd(640), rnd(480), (rnd(2) + 1)/2 })
		end
	end
	for i=1, 80 do
		x = s.snow[i][1]
		y = s.snow[i][2]
		sprite.fill(sprite.screen(), x, y, 2, 2, 'white');
		s.snow[i][2] = s.snow[i][2] + s.snow[i][3]
		s.snow[i][1] = s.snow[i][1] + 2 -  rnd(3)
		if s.snow[i][1] < 0 or s.snow[i][2] > 480 or hero:collision(x, y, 2, 2) then
			s.snow[i][1] = rnd(640)
			s.snow[i][2] = 0
			s.snow[i][3] = (rnd(2) + 1)/2
		end
	end
end

},

	{
		title = "24:Tired?",
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
'>                                       ';
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
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
};
},

	{
		title = "25:?",
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
'>                                       ';
'#####                                   ';
'####                                    ';
'###                                     ';
'##                                      ';
'#                                       ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                        ........        ';
};
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

[CONTMAP] = 	{
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
}

game.enable_save = false