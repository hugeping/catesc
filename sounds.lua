require "sound"
mew_snd = sound.load 'snd/mew.ogg'
laser_snd = sound.load 'snd/laser.ogg'

function laser_play()
	if not laser_playing then
		sound.play(laser_snd, 2, 0)
		laser_playing = true
	end
end

function laser_mute()
	laser_playing = false
	sound.stop(2)
end

function sound_init()
	laser_mute()
end