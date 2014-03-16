local LBT = {}
local utils = require('utils')

function LBT.resize(filename, width, height, outputName)
	-- Goal: convert dragon.gif    -resize 64x64  resize_dragon.gif
	local commandString = "convert " .. filename .. " -resize " .. width .. "x" .. height .. '\\!' .." " .. outputName
	print(commandString)

	utils.justRunCmd(commandString)

end

return LBT