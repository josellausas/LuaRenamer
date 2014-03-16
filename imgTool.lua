-- Image Maniulation Tool by jose@josellausas.com
local utils = require("utils")
local imgTool = {}



function imgTool.resize(filename, width, height)
	-- Goal: convert dragon.gif    -resize 64x64  resize_dragon.gif
	local commandString = "convert " .. filename .. " -resize " .. width .. "x" .. height .. '\\!' .." " .. filename
	print(commandString)

	utils.justRunCmd(commandString)

end




return imgTool