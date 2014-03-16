#!/usr/bin/env lua

-- Created by jose llausas jose@zunware.com
local utils 	= require("utils")
local renamer 	= require("renamer")
local imgTool 	= require("imgTool")
local LBT 		= require("LookbookTool")

-- Program starts here
if #arg == 0 then
	print('ERROR:\nNeed parameter: pathToFiles')
	return 0
end

-- Catches the path to the files to be renamed
local pathToFiles = arg[1]

local cdToPathCMD = ('cd ' .. pathToFiles)

-- Change dir to directory
if utils.justRunCmd(cdToPathCMD) then
	print('Renaming files inside:')
	print(pathToFiles .. '\n')

	-- Get the filenames from a ls command. This returns a chunk of text separated by newlines
	local dirContents = utils.runCmd('ls ' .. pathToFiles)
	print(dirContents)
	
	-- Split the chunk into a nice lua table
	local filenamesTable = utils.splitTextToTable(dirContents)

	if renamer.numericRename(pathToFiles,filenamesTable) then
		print("YEY")
	else 
		print("BOO!")
	end

	-- Reload the table with the new names
	local filenamesTable = utils.splitTextToTable(utils.runCmd('ls ' .. pathToFiles))
	
	utils.justRunCmd(cdToPathCMD)
	print(utils.runCmd('pwd'))

	-- Make Folders
	utils.justRunCmd('mkdir ' .. pathToFiles .. 'images')
	utils.justRunCmd('mkdir '.. pathToFiles .. 'images_thumbnails')
	utils.justRunCmd('mkdir '.. pathToFiles .. 'images_large')

	for i=1, #filenamesTable do
		print(filenamesTable[i])
		-- imgTool.resize(pathToFiles .. filenamesTable[i], 800, 600)

		local imageName = pathToFiles .. 'images/' .. filenamesTable[i]
		local thumbName = pathToFiles .. 'images_thumbnails/' .. filenamesTable[i]
		local largeName = pathToFiles .. 'images_large/' .. filenamesTable[i]

		LBT.resize(pathToFiles .. filenamesTable[i], 138, 207, thumbName)
		LBT.resize(pathToFiles .. filenamesTable[i], 333, 500, imageName)
		LBT.resize(pathToFiles .. filenamesTable[i], 640, 960, largeName)
	end




end




