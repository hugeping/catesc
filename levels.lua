maps = {
	{
		title = "first:Cats cant swim";
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
		title = "2dots:Be careful!",
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
		title = "tramp:Tramboline",
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
		title = "ladder:Ladder";
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
		title = "laser:Laser";
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
		title = "trap:Dont be so fast";
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
		title = "panic:Dont stop!";
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
		title = "walk:Walk";
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
		title = "jump:Jump!";
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
		title = "monolit:Monolith";
		map = {
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'              #############             ';
'              #############             ';
'              #############             ';
'              #############             ';
'              #############             ';
'              #############             ';
'              #############             ';
'              #############             ';
'              #############             ';
'              #############             ';
'              #############             ';
'              #############             ';
'              #############             ';
'>             #############             ';
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
	if hero:state() == WALK and hero.speed_x == 0 then
		if not s.trig then
			s.trig = 0
		end
	else
		s.trig = false
	end
	if s.trig and not s.fall then
		s.trig = s.trig + 1
		if s.trig > 150 then s.fall = 6 end
	end
	if s.fall and s.fall < 18 then
		local y = math.floor(s.fall)
		local x
		for x = 14, 26 do
			local c = map:cell(x, y)
			c[1] = 0
		end
		s.fall = s.fall + 0.1
	end
end
},
	   	{
		title = "moving:Moving";
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
'######                            ######';
'     ##############################     ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
};
life = function (s)
   local i
   if not s.x then
      s.x = {}
      s.x[1] = 6 * BW
      s.x[2] = 15 * BW
      s.x[3] = 24 * BW
      s.speed = 1
   end
   for i = 1, 3 do
      sprite.fill (sprite.screen(), s.x[i], 20 * BW, BW, BW, 'red')
      if hero:collision(s.x[i], 20 * BW, BW, BW) and hero:alive() then
	 hero:state(FLY)
      end
      s.x[i] = s.x[i] + s.speed
   end
   if s.x[1] == 15 * BW or s.x[1] == 6 * BW then
      s.speed = s.speed * -1
   end
end
},

	{
		title = "rope:Rope";
		map = {
'             +                        * ';
'                                        ';
'                                        ';
'                                        ';
' ====-----------------------------------';
'                                        ';
'                                        ';
'                                        ';
'     ====                               ';
'                                        ';
'                                        ';
'                                        ';
' ====                                   ';
'                                        ';
'                                        ';
'                                        ';
'     ====                               ';
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
		title = "teleports:Teleports";
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
'        ###                  ###        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'>       xxx                             ';
'###########                  ###########';
'                                        ';
'                                        ';
'              +                         ';
'             #####                      ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~';
};
life = function(s)
	local x = 8
	local y = 16
	local c = 'blue'
	if not tel_trigger then c = 'white' end
	tel_trigger = not tel_trigger 
	sprite.fill(sprite.screen(), x * BW, y * BH - BH, 3 * BW, 5 * BH, c);
	
	if hero:collision((x + 1) * BW, (y + 2)* BH, BW, 1 * BH) then
		hero.x = 30*BW + BW/2 - hero.dir * (3*BW) - hero.w/2
		hero.speed_x = - hero.speed_x
		hero.dir = -1
		sound.play(teleport_snd)
	end
	x = 29
	sprite.fill(sprite.screen(), x * BW, y * BH - BH, 3 * BW, 5 * BH, c);
	if hero:collision((x + 1) * BW, (y + 2)* BH, BW, 1 * BH) then
		hero.x = 9*BW + BW/2 - hero.dir * (3*BW) - hero.w/2
		hero.speed_x = - hero.speed_x
		hero.dir = -1
		sound.play(teleport_snd)
	end
end
},

	{
		title = "black:Dont afraid";
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
'      ------####-------###              ';
'             ###       ###              ';
'             ###       ###  ###         ';
'+        *   ###   *   ###  #*#         ';
'########################################';
};
},
	{
		title = "lift:Lift";
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
		title = "snake:Snake";
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
		title = "rain:Rain";
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
	rain_play()
	if hero:state() == JUMP or hero:state() == FALL then
		hero.speed_x = hero.speed_x - GX*0.75
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
	local c = map:cell(0, 28)
	c[1] = 0
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
		if s.rain[i][2] > 480 - BH - 8 or s.rain[i][1] < 0 or hero:collision(x, y + 12, 2, 2) then
			s.rain[i][1] = rnd(740)
			s.rain[i][2] = 0
			s.rain[i][3] = rnd(8) + 8
		end
	end
end
},
 {
      title = "spacehere:Dont panic!";
      map = {
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'########################################';
'#                                      #';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                              #####     ';
'                         ######   ##    ';
'                    ######         ##   ';
'               ######               ##  ';
'          ######                     ## ';
'>    ######                           ##';
'######                                 #';
};
life = function(s)
   local position, index
   if not s.x then
      s.x = 38 * BW
      s.speed = -2
      s.length = {22, 22, 22, 22, 22, 21, 21, 21, 21, 21, 20, 20, 20, 20, 20, 19, 19, 19, 19, 19, 18, 18, 18, 18, 18, 17, 17, 17, 17, 17, 16, 16, 16, 16, 16, 17, 18, 19, 20, 21 }
      s.laser = false
   end
   if (rnd(100) > 50) then
	   sprite.fill (sprite.screen(), s.x, 6 * BW, BW, BW, "yellow")
    else
	sprite.fill (sprite.screen(), s.x, 6 * BW, BW, BW, "gold")
    end
   if s.laser then
	laser_play()
      if s.speed < 0 then
	 index = math.floor ((s.x + 6) / BW) + 1
	 sprite.fill (sprite.screen(), s.x + 6, 7 * BW, 3, s.length[index] * BW, 'red')
	 if hero:collision(s.x + 6, 7 * BW, 3, s.length[index] * BW) and hero:alive() then
	    hero:state(FLY)
	 end
      else
	 index = math.floor ((s.x + 7) / BW) + 1
	 sprite.fill (sprite.screen(), s.x + 7, 7 * BW, 3, s.length[index] * BW, 'red')
	 if hero:collision(s.x + 7, 7 * BW, 3, s.length[index] * BW) and hero:alive() then
	    hero:state(FLY)
	 end
      end
   else
	laser_mute()
   end
   s.x = s.x + s.speed
   if s.x == BW or s.x == 38 * BW then
      s.speed = s.speed * -1
   end
   position = hero.x + hero.w
   if (position > 9 * BW and position < 10 * BW
	  or position > 14 * BW and position < 15 * BW
	  or position > 19 * BW and position < 20 * BW
	  or position > 24 * BW and position < 25 * BW
	  or position > 29 * BW and position < 30 * BW)
   and hero:state() == WALK then
      s.laser = true
   end
end
},

	{
		title = "lasers:Lasers";
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
	title = "press:Press",
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
	title = "run:Run",
	map = {
'                                        ';
'                                        ';
'                                        ';
'                                   #    ';
'                                   #~~~~';
'                                   #~~~~';
'                                   #~~~~';
'                                   #~~~~';
'                                   #~~~~';
'                                   #~~~~';
'                                   #####';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                          %%%%%%        ';
'                                        ';
'                                        ';
'                                        ';
'                 %%%%%%            #####';
'                                   #    ';
'                                   #~~~~';
'>                                  #~~~~';
'%%%%%%%%%%%%%%                     #~~~~';
'                                   #~~~~';
'                                   #~~~~';
'                                   #~~~~';
'                                   #~~~~';
'                                   #~~~~';
};
},
{
		title = "flow:Flow";
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
'########################################';
'                        #  #            ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'>                                       ';
'##########%%%%%%%%######################';
'                                        ';
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~';
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~';
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~';
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~';
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~';
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~';
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~';
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~';
};
life = function(s)
   local i
   if not s.w1 then
      s.switched = false
      s.w1 = 6 * BW
      s.w2 = 0
      s.flow = 0
   end
   sprite.fill (sprite.screen(), 0, 10 * BW - s.w1 + 1, 41 * BW, s.w1, "blue")
   sprite.fill (sprite.screen(), 0, 22 * BW - s.w2 + 1, 41 * BW, s.w2, "blue")
   if hero.x > 7 * BW and hero.x < 18 * BW and hero:state() == WALK and not s.switched then
      s.switched = true
      for i = 25, 26 do
	 c = map:cell(i, 10)
	 c[1] = 0
      end
   end
   if s.switched then
      sprite.fill (sprite.screen(), 25 * BW, 10 * BW, 2 * BW, s.flow, "blue")
      if s.flow <= 12 * BW then
	 s.flow = s.flow + 4
      end
      s.w1 = s.w1 - 0.1
      if s.flow > 12 * BW then
	 s.w2 = s.w2 + 0.1
      end
   end
   if hero:collision(25 * BW, 10 * BW, 2 * BW, s.flow) and hero:alive() then
      hero:state(FLY)
   elseif 22 * BH - s.w2 < hero.y + hero.h and hero:alive()then
      hero:state(DROWN)
   end
end
},
{
		title = "propeller:Propeller",
		map = {
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'       ##*##*##*##*##*##*##*##*##       ';
'       #                        #       ';
'       #                        #       ';
'########                        ########';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                   +                    ';
'                                        ';
'>                                       ';
'########                        ########';
'       #                        #       ';
'       #                        #       ';
'       #                        #       ';
'       #                        #       ';
'       #                        #       ';
'       #                        #       ';
'       #                        #       ';
'       #    xxxxxxxXXxxxxxxx    #       ';
'       ##########################       ';
};
life = function(s)
	local max = 1
	if not s.vent then
		s.vent = 1
		s.speed = 0.001
	end
	s.speed = s.speed + 0.002
	if s.speed > max then s.speed = max end
	if hero.x > 7 * BW and hero.x + hero.w <= 32 * BW then
		local h = 29 - (hero.y + hero.h)/ BH
		h = (38 - h)/38 -- 1..0
		if hero:alive() then
			G = origG - (s.speed * s.speed * h * 2 * origG)
		else
			G = origG
		end
		if math.abs(G) < 0.05 then G = G * 0.1 end
		if G < 0 then hero.y = hero.y + G end
	else
		G = origG
	end
	local v = { 7, 6, 4, 2, 0, 1, 2, 4, 6, 7 }
	s.vent = s.vent + s.speed * 2
	local n = math.floor(s.vent)
	if n >#v then s.vent = 1;n = 1; end
	local c
	local x, y, xx
	x = 19
	y = 28
	xx = x - v[n]
	sprite.fill(sprite.screen(), xx * BW, y * BH + 4, (v[n] * 2 + 2) * BW, 4, 'black')
	sprite.fill(sprite.screen(), x * BW, y * BH, 2 * BW, BH, '#333333')
	if hero:collision(xx * BW, y * BH, (v[n] * 2 + 2) * BW, 4) then
		hero:state(FLY)
	end
end
},

{
		title = "stairs:Stairs";
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
'#######*                                ';
'       #######*                         ';
'              #######*                  ';
'                     #######*         + ';
'                            ############';
'                                       #';
'                                       #';
'                                       #';
'                                       #';
'                                       #';
};
},
{
	title = "figure:Figure out",
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
	title = "easy:Easy?",
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
	title = "impossible:Impossible?",
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
		title = "mars:Mars",
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
		title = "meteors:Meteors",
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
'                                       #';
'                                      ##';
'                                     ###';
'                                     ###';
'                                     ###';
'                                     ###';
'                                     ###';
'                                    ####';
'                      #######       ####';
'                     #########   + #####';
'>                   ###########  #######';
'###              #######################';
'########################################';
'########################################';
'########################################';
'########################################';
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~';
};
life = function(s)
	local x, y, i, xx, yy
	if not s.meteo then
		s.r = 0
		s.meteo = {}
		for i = 1, 3 do
			table.insert(s.meteo, {rnd(640) - BW * 4, rnd(480) - 480, rnd(2) + 1 })
		end
	end
	local exp
	for i=1, #s.meteo do
		exp = false
		x = s.meteo[i][1]
		y = s.meteo[i][2]
		if rnd(50) > 25 then
			sprite.fill(sprite.screen(), x, y, BW, BH, 'white');
		else
			sprite.fill(sprite.screen(), x, y, BW, BH, 'red');
		end
		s.meteo[i][2] = s.meteo[i][2] + s.meteo[i][3]
		xx, yy = map:pos2block(x + BW / 2, y + BH / 2)
		if xx >= 0 and yy >= 0 then
			local c = map:cell(xx, yy)
			if c and c[1] ~= 0 and c[1] ~= HEART then
				explode.add(s, xx, yy)
				exp = true
			end
		end
		if hero:collision(x, y, BW, BH) then
			exp = true
			explode.add(s, xx, yy)
			hero:state(FLY)
		end
		if s.meteo[i][1] < 0 or s.meteo[i][2] > 480 - BH or exp then
			if i == s.right then
				s.right = false
			end
			s.meteo[i][1] = rnd(640) - BW * 4
			s.meteo[i][2] = -BH
			s.meteo[i][3] = rnd(2) + 1
			if not s.right and s.r <= 4 then
				s.meteo[i][1] = 640 - BW * ((s.r % 3)) - BW
				s.r = s.r + 1
				s.meteo[i][3] = 3
				s.right = i
			end
		end
	end
end;
},
	{
		title = "valley:Valley",
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
'>                                       ';
'@@                                      ';
'@@@                                     ';
'@@@                                     ';
'@@@@                                    ';
'#@#@                                    ';
'###@                                    ';
'#####                                   ';
'#####                                   ';
'######                                  ';
'######                                  ';
'########                                ';
'##############        +           ######';
'             #~~~~~~#####~~~~~~~~~#     ';
'             ######################     ';
'                                        ';
'                                        ';
'                                        ';
};
after = function(s)
	sprite.fill(sprite.screen(), 35 * BW, 2 * BH, 4 * BW, BH*4, 'yellow');
	sprite.fill(sprite.screen(), 0 * BW, 24 * BH, 40 * BW, BH*3, 'green');
	sprite.fill(sprite.screen(), 0 * BW, 27 * BH, 40 * BW, BH*3, '#444444');
	sprite.fill(sprite.screen(), 14 * BW, 24 * BH, 20 * BW, BH*2, 'blue');
end
},

	{
		title = "faster:Faster, higher, stronger!",
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
		title = "careful:Be careful!",
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
		title = "winter:Winter",
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
		title = "tired:Tired?",
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
'########################################';
'########################################';
'########################################';
'########################################';
'########################################';
'########################################';
'########################################';
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
		title = "danger:Danger",
		map = {
'                ########                ';
'                ########                ';
'                ########                ';
'                ########                ';
'                ########                ';
'                ########                ';
'                ########                ';
'                ########                ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'>                                       ';
'################========################';
'################        ################';
'################        ################';
'################        ################';
'################        ################';
'################        ################';
'################        ################';
'################        ################';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
};
life = function(s)
	if not s.fall and hero.x > 16 * BW and hero.speed_x >= SPEED_RUN * 0.65 and hero.x < 22 * BW then
		s.fall = 0
	end
	if s.fall and s.fall * BH < 480 then
		local yy = math.floor(s.fall)
		local xx = 0
		local x, y
		for x = 0, 7 do
			for y = yy, yy + 7 do 
				local c = map:cell(16 + x, y)
				if c then
					c[1] = 0
				end
			end
		end
		s.fall = s.fall + G;
		if hero.y > (s.fall * BH) then
			if s.fall and hero.y <= (s.fall + 8) * BH and hero.x < 24 * BW - hero.w and hero.x > 16 * BW then
				hero.y = (s.fall + 8) * BH + hero.yoff
			end
		end
		yy = math.floor(s.fall)
		for x = 0, 7 do
			for y = yy, yy + 7 do 
				local c = map:cell(16 + x, y)
				if c then
					c[1] = BLOCK
				end
			end
		end
	end
end
},



	{
		title = "?",
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
'                        ........      ..';
};
},

	{
		title = "mines:Mines",
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
'          m          +          m       ';
'>         ##############################';
'###########                             ';
};
},
   	{
		title = "wait:Wait";
		map = {
'                             #          ';
'                             #          ';
'                             #          ';
'                             #          ';
'                             #          ';
'                             #          ';
'                             #          ';
'                             #          ';
'                             #          ';
'                             #          ';
'                             #          ';
'                             #          ';
'                             #          ';
'                             #          ';
'                             #          ';
'                             #          ';
'                             ##         ';
'        %%%%                  ##        ';
'                               ##       ';
'                                ##      ';
'%%%%               #####         ##     ';
'                   #   #          ##    ';
'                   #   #           #####';
'      %%%%        *#   #                ';
'                   #   #                ';
'                   #   #                ';
'                   #   #                ';
'>                  #   #           xm   ';
'####################   #     ###########';
'                       #~~~~~#          ';
};
},
{
		title = "mines2:Мины II";
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
'                 #####                  ';
'             #####mmm#####              ';
'         #####mmmm   mmmm#####          ';
'     #####mmmm           mmmm#####      ';
'######mmmm                   mmmm#######';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                 #####                  ';
'             #####   #####              ';
'         #####           #####          ';
'>    #####                   #####      ';
'######                           #####  ';
'                                     ###';
},
},

	{
		title = "power:Power",
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
'                           %%%%%########';
'                                ########';
'                                ########';
'                                ########';
'                                ########';
'            ####                ########';
'            ####                ########';
'            ####                ########';
'>           ####      m         ########';
'########################################';
};
life = function(s)
	if not s.pos then s.pos = 12 end
	local c, y, x
	
	for x = 0, 3 do
		for y = 1, 4 do
			c = map:cell(math.floor(s.pos) + x, 24 + y)
			c[1] = 0
		end
	end
	if hero.y >= 25 * BH and hero.speed_x <= GX and hero:state() == WALK and key_right 
		    and hero.x + hero.w >= math.floor(s.pos) * BW and hero.x + hero.w < (math.floor(s.pos) + 4) * BW then
		s.pos = s.pos + 0.1
	end
	if s.pos >= 18 then s.pos = 18 end
	for x = 0, 3 do
		for y = 1, 4 do
			c = map:cell(math.floor(s.pos) + x, 24 + y)
			c[1] = BLOCK
		end
	end

end
},

	{
		title = "darkness:Darkness",
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
'##############             #############';
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
after = function(s)
	local y = 0
	for y = 0, 30 * BW - 1 do
		sprite.fill(sprite.screen(), 10 * BW + rnd(3) - 2, y, 20 * BW - 1 + rnd(3) - 2, 1, 'black');
	end
end
},
	{
		title = "bunker:Bunker",
		map = {
'                                        ';-- 0
'                                        ';-- 1
'                                        ';-- 2
'                                        ';-- 3
'                                        ';-- 4
'                                        ';-- 5
'                                        ';-- 
'                                        ';-- 7
'                                        ';-- 8
'                                        ';-- 9
'                                        ';-- 10
'                                        ';-- 11
'                                        ';-- 12
'                                        ';-- 13
'########################################';-- 14
'#m#####   m   ###   m   ###   m   #m####';-- 15
'                                        ';-- 16
'                                        ';-- 17
'                                        ';-- 18
'>   +                                  m';-- 19
'########################################';-- 20
'########################################';-- 21
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
},

	{
		title = "platforms:Platforms",
		map = {
'           m   m   m   m   m   m        ';-- 0
'                                        ';-- 1
'                                        ';-- 2
'                                        ';-- 3
'                                        ';-- 4
'                                    ####';-- 5
'                                    ####';-- 
'                                       #';-- 7
'                                       #';-- 8
'                                       #';-- 9
'                                       #';-- 10
'                                       #';-- 11
'                                       #';-- 12
'                                       #';-- 13
'                                       #';-- 14
'                                       #';-- 15
'                                       #';-- 16
'                                       #';-- 17
'                                       #';-- 18
'>                                      #';-- 19
'####                                   #';-- 20
'####                                   #';-- 21
'#                                      #';-- 22
'#                                      #';-- 23
'#                                      #';-- 24
'#                                      #';-- 25
'#                                      #';-- 26
'#                                      #';-- 27
'#                                      #';-- 28
'#                                      #';-- 29
};
--[[
 0123456789012345678901234567890123456789
           1         2         3
]]--
before = function(s)
	if not s.lifts then
		s.lifts = {{}, {}, {}, {}}
--		lift.activate(s.lifts[1], 5, 1, 4, 0.25, 1, 28)
		lift.activate(s.lifts[2], 14, 28, 4, -0.3, 1, 28)
		lift.activate(s.lifts[3], 23, 1, 4, 0.3, 1, 28)
		lift.activate(s.lifts[4], 32, 28, 4, -0.3, 1, 28)
	end
--	lift.draw(s.lifts[1])
	lift.draw(s.lifts[2])
	lift.draw(s.lifts[3])
	lift.draw(s.lifts[4])
end
},

	{
		title = "entrance:Entrance", 
		map = {
'......                           ......m';-- 0
'                                       m';-- 1
'                                       m';-- 2
'                                       m';-- 3
'>                                      m';-- 4
'==================================######';-- 5
'                                  ######';-- 
'                                        ';-- 7
'                                        ';-- 8
'                                        ';-- 9
'                                        ';-- 10
'                                        ';-- 11
'                                        ';-- 12
'                                        ';-- 13
'                                        ';-- 14
'                                        ';-- 15
'                                        ';-- 16
'                                        ';-- 17
'                                        ';-- 18
'                                        ';-- 19
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
},

	{
		title = "well:Well", 
		map = {
'                                        ';-- 0
'                                        ';-- 1
'                                        ';-- 2
'                                        ';-- 3
'>                                       ';-- 4
'########     #                         #';-- 5
'       #     #~~~~~~~~~~~~~~~~~~~~~~~~~#';-- 
'       #     #~~~~~~~~~~~~~~~~~~~~~~~~~#';-- 7
'       #     #~~~~~~~~~~~~~~~~~~~~~~~~~#';-- 8
'       #     #~~~~~~~~~~~~~~~~~~~~~~~~~#';-- 9
'       #     #~~~~~~~~~~~~~~~~~~~~~~~~~#';-- 10
'       #     ###########################';-- 11
'       #     #                          ';-- 12
'       #     #                          ';-- 13
'       #     #                          ';-- 14
'       #     #                          ';-- 15
'       #     #                          ';-- 16
'       #     #                          ';-- 17
'       #     #                          ';-- 18
'       #     #                          ';-- 19
'       #                              ##';-- 20
'       #                         ###### ';-- 21
'       #                    ######      ';-- 22
'       #               ######           ';-- 23
'       #          ######                ';-- 24
'       #     ######                     ';-- 25
'       #     #                          ';-- 26
'       #     #                          ';-- 27
'       #     #                          ';-- 28
'       #  *  #                          ';-- 29
};
--[[
 0123456789012345678901234567890123456789
           1         2         3
]]--
life = function(s)
	local x, y
	x = 8
	y = 25

	if not s.step then
		s.step = 0
	end
	s.step = s.step +1
	if s.step < 100 then
		for x = 8, 8 + 4 do
			local c = map:cell(x, y)
			c[1] = 0
		end
	elseif s.step >= 100 and s.step <= 115 then
		for x = 8, 8 + 4 do
			local c = map:cell(x, y)
			c[1] = BRIDGE
		end
	else
		s.step = 0
	end
end
},



	{
		title = "snake2:Snake II",
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
'>                  +                    ';-- 19
'########################################';-- 20
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
life = function(s)
	local path = { { 12, 6 }, { 12, 19}, 
			{27, 19}, {27, 6} };
	if not s.path then
		s.path = path
		s.step = 0
	end
	if not s.snake then
		s.snake = {} 
		local k
		for k=1, 47 do
			table.insert(s.snake, {k + 12, 6})
		end
	end
	if s.step > 3 then
		snake.step(s)
		s.step = 0
	end
	snake.draw(s)
	s.step = s.step + 1 
end

},
	{
		mirror = true,
		title = "strange:Strange place",
		map = {
'                                        ';-- 0
'                                        ';-- 1
'         #######################        ';-- 2
'          m                   m         ';-- 3
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
'>         m                   m         ';-- 19
'########################################';-- 20
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
life = function(s)
	local st, m
	st, m = game:state()
	if st == CHANGE_LEVEL and m >= 16 and hero.x > 600 and not s.skip then
		map.nr = map.nr - 1
	elseif hero.x < - (hero.w * 3) and s ~= CHANGE_LEVEL then
		hero.x = 700
		hero.y = 0
		hero.speed_x = 0
		game:state(CHANGE_LEVEL)
		hero:state(WALK)
		s.skip = true
	end
	map:dist(0)
end
},
	{
		title = "gate:Gate",
		map = {
'>                    ###################';
'                     #                 #';
'                     #                 #';
'                     #                 #';
'                     #                 #';
'                     #                 #';
'%%%                  #                 #';
'%%%                  #                 #';
'                     #                 #';
'                     #                 #';
'       %%%%          #                 #';
'       %%%%          #                 #';
'                     #                 #';
'                     #                 #';
'%%%                  #                 #';
'%%%                  #                 #';
'                     #                 #';
'                     #                 #';
'                     #                 #';
'                     #                  ';
'                    *#                  ';
'                     #                  ';
'                     #                  ';
'       m             #                  ';
'###############      #                ##';
'              #                     ####';
'              #                   ####  ';
'              #                 ####    ';
'              #               ####      ';
'              ##################        ';
};
		life =  function(s)
			if not s.timer then
				s.timer = 0
			end
			s.timer = s.timer + 1
			if s.timer < 250 then
				laser.on(0, 20, -20)
				s.l1on = true
			else
				s.l1on = false
				laser.off()
			end
			if not s.x then
				s.x = 0
				s.dx = 0.5
				
			end
			if rnd(50) > 25 then
				sprite.fill(sprite.screen(), 22 * BW + s.x, BH * 2, 16, 16, 'gold')
			else
				sprite.fill(sprite.screen(), 22 * BW + s.x, BH * 2, 16, 16, 'red')
			end
			s.x = s.x + s.dx
			if s.x >= 16 * BW then s.dx = -0.5 end
			if s.x <= 0 then s.dx = 0.5 end
			local h = 26
			if s.x > 7 * BW + 8 then h = h - 1 end
			if s.x > 9 * BW + 8 then h = h - 1 end
			if s.x > 11 * BW + 8  then h = h - 1 end
			if s.x > 13 * BW + 8 then h = h - 1 end
			if s.x > 15 * BW + 8 then h = h - 1 end
			if not s.pos then s.pos = 0 end
			if s.pos > 30 then
				local c = 'red'
				if not phaser_step then
					c = 'yellow'
				end
				phaser_step = not phaser_step
				sprite.fill(sprite.screen(), 22 * BW + s.x + BW / 2 - 3, BH * 2 + BH, 4, BH * h, c)
				laser_play()
				if hero:collision(22 * BW + s.x + BW / 2 - 3, BH * 2 + BH, 4, BH * h) then
					hero:state(FLY)
				end
			elseif not s.l1on then
				laser_mute()
			end
			if s.pos > 60 then s.pos = 0 end
			s.pos = s.pos + 1
		end;

},

	{
		title = "exit:Exit",
		color = "blue",
		map = {
'                                       #';
'                                      ##';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                        ';
'                                       *';
'                                      ##';
'                                       #';
'                                       #';
'                                       #';
'                                       #';
'                                       #';
'                                       #';
'>                                      #';
'########################################';
'                                       #';
'                                       #';
'                                       #';
'                                       #';
'                                       #';
}, 
life = function(s)
	if not s.door then
		s.door = 0
	end
	if math.floor(s.door) < 7 then
		s.door = s.door + 0.004
	end
	local x, y, i, xx, yy
	x = math.floor(s.door)
	local c = map:cell(39, 24 - x)
	if x ~= 0 then
		c[1] = 0
	end
	if not s.robots then
		s.robots = {}
		for i = 1, 3 do
			table.insert(s.robots, {rnd(640) + 640, rnd(160) +BH+BH, i, rnd(60) })
		end
	end
	local exp
	local laser_on = false
	for i=1, #s.robots do
		x = s.robots[i][1]
		y = s.robots[i][2]
		if rnd(50) > 25 then
			sprite.fill(sprite.screen(), x, y, BW, BH, 'white');
		else
			sprite.fill(sprite.screen(), x, y, BW, BH, 'red');
		end
		s.robots[i][4] = s.robots[i][4] + 1
		if s.robots[i][4] > 60 then
			if s.robots[i][4] > 80 then
				s.robots[i][4] = 0
			end
			if x < 640 - BW - BW then
				local c = 'red'
				if not phaser_step then
					c = 'yellow'
				end
				phaser_step = not phaser_step
				laser_on = true
				sprite.fill(sprite.screen(), x + BW / 2 - 3, y + BH, 4, 22 * BH - y + BH, c)
				laser_play()
				if hero:collision(x + BW / 2 - 3, y + BH, 4, 22 * BH - y + BH) then
					hero:state(FLY)
				end
			end
		end
		s.robots[i][1] = x - s.robots[i][3]
		if s.robots[i][1] <= 0 then
			s.robots[i][3] = - (rnd(2) + 1)
			s.robots[i][4] = rnd(60)
		elseif s.robots[i][1] >= 640 - BW and s.robots[i][3] < 0 then
			s.robots[i][3] = (rnd(2) + 1)
			s.robots[i][4] = rnd(60)
		end
	end
	if not laser_on then laser_mute() end
end;
},

}
