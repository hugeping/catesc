i18 = {
	["ru"] = {
		["1"] = "Начало...";
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
