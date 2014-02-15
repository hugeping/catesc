require "sound"
mew_snd = sound.load 'snd/mew.ogg'
laser_snd = sound.load 'snd/laser.ogg'
bonus_snd = sound.load 'snd/bonus.wav'
beep_snd = sound.load 'snd/beep.wav'
boom_snd = sound.load 'snd/boom.wav'
rain_snd = sound.load 'snd/rain.ogg'
teleport_snd = sound.load 'snd/teleport.ogg'

function rain_play()
	if not rain_playing then
		sound.play(rain_snd, 3, 0)
		rain_playing = true
	end
end

function rain_mute()
	sound.stop(3)
	rain_playing = false
end

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
	rain_mute()
end

