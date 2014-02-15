i18 = {
	["ru"] = {
		["gameover"] = "ИГРА ОКОНЧЕНА";
		["space"] = "НАЖМИТЕ ПРОБЕЛ";
		["help1"] = "КЛАВИШИ: ВЛЕВО, ВПРАВО, ВВЕРХ или ПРОБЕЛ";
		["help2"] = "НАЖМИТЕ ESC ДЛЯ ВЫХОДА В МЕНЮ";
		["Score"] = "Пройдено:";
		["Hiscore"] = "Рекорд:";
		["continue"] = "ПРОДОЛЖИТЬ?";
		["cont"] = "Продолжить?";

		["end1"] ="ПОЗДРАВЛЯЕМ!",
		["end2"] ="ВЫ ПОМОГЛИ КОТУ СПАСТИСЬ С ЗЛОВЕЩЕЙ СТАНЦИИ!",
		["end3"] ="СПАСИБО!",
		["end4"] =":)",
		["end5"] ="КОД: ПЕТР КОСЫХ",
		["end6"] ="ДВИЖОК: ПЕТР КОСЫХ",
		["end7"] ="http://instead.syscall.ru",
		["end8"] ="УРОВНИ: ПЕТР КОСЫХ, АНДРЕЙ ЛОБАНОВ",
		["end9"] ="МУЗЫКА: RoccoW",
		["end10"] ="ПО МОТИВАМ ИГР:",
		["end11"] ="Snoopy (ВЗЯТЫ НЕКОТОРЫЕ УРОВНИ)",
		["end12"] ="Sqrzx",
		["end13"] ="Giana's Return...",
		["end14"] ="ВЫ МОЖЕТЕ ВВЕСТИ НОМЕР УРОВНЯ КЛАВИШАМИ 0..9",
		["end15"] ="И НАЖАТЬ ВВОД",
		["stat_score"] = "ВАШ СЧЕТ: %d",
		["stat_record"] = "РЕКОРД: %d",
		["first"] = "Кошки не умеют плавать";
		["2dots"] = "Осторожно!";
		["tramp"] = "Трамплин";
		["ladder"] = "Лестница";
		["laser"] = "Лазер";
		["trap"] = "Не спеши";
		["panic"] = "Не стой!";
		["walk"] = "Иди!";
		["jump"] = "Прыгай!";
		["monolit"] = "Монолит";
		["rope"] = "Канат";
		["teleports"] = "Телепортаторы";
		["black"] = "Не бойся";
		["lift"] = "Лифт";
		["snake"] = "Змея";
		["rain"] = "Дождь";
		["spacehere"] = "Не бойся есть место";
		["lasers"] = "Лазеры";
		["press"] = "Пресс";
		["flow"] = "Поток";
		["propeller"] = "Пропеллер";
		["run"] = "Беги!";
		["stairs"] = "Ступеньки";
		["figure"] = "Догадайся";
		["easy"] = "Просто?";
		["impossible"] = "Невозможно?";
		["mars"] = "Марс";
		["meteors"] = "Метеориты";
		["faster"] = "Быстрее, выше, сильнее!",
		["careful"] = "Аккуратней!";	
		["winter"] = "Зима";
		["tired"] = "Устал?";
		["danger"] = "Угроза";
		["mines"] = "Мины";
		["mines2"] = "Мины II";
		["power"] = "Сила кота";
		["darkness"] = "Тьма";
		["bunker"] = "Бункер";
		["snake2"] = "Змея II";
		["platforms"] = "Платформы";
		["entrance"] = "Вход";
		["well"] = "Шахта";
		["strange"] = "Странное место";
		["gate"] = "Шлюз";
		["free"] = "Свобода";
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
