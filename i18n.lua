i18 = {
	["ru"] = {
		["Score"] = "Пройдено:";
		["1"] = "Начало...";
		["2"] = "Будь осторожен...";
	}
}

_ = function(s)
	local l = LANG
	local a = s:gsub("^([^:]+):.*$", "%1")
	s = s:gsub("^[^:]+:", "")
	local ss = i18[l][a] 
	if ss then return ss end
	return s
end
