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
'                                 +    + ';
'                        *       ########';
'                *       #########       ';
'                #########               ';
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
		if hero:collision(19 * BW + BW / 2 - 2, 0, 3, 19 * BH) then
			hero:state(FLY)
		end
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
'     ########^^^^^^^^^^^^^########      ';
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
'     #############################      ';
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
		sprite.fill(sprite.screen(), 10 * BW, 21 * BH + BH/2 - 2, 20 * BW, 3, c);
		if hero:collision(10 * BW, 21 * BH + BH/2 - 2, 20 * BW, 3) then
			hero:state(FLY)
		end
	end
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
			end
		end;

},


}
