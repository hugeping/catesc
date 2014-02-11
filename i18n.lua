i18 = {
	["ru"] = {
		["Score"] = "Пройдено:";
		["Hiscore"] = "Рекорд:";
		["1"] = "Кошки не умеют плавать";
		["2"] = "Осторожно!";
		["3"] = "Трамплин";
		["4"] = "Лестница";
		["5"] = "Лазер";
		["6"] = "Не спеши";
		["7"] = "Не стой!";
		["8"] = "Иди!";
		["9"] = "Прыгай!";
		["10"] = "Канат";
		["11"] = "Не бойся";
		["12"] = "Лифт";
		["13"] = "Змея";
	}
}

_ = function(s)
	local l = LANG
	local a = s:gsub("^([^:]+):.*$", "%1")
	s = s:gsub("^[^:]+:", "")
	if not l or not i18[l] then
		return s
	end
	local ss = i18[l][a] 
	if ss then return ss end
	return s
end
