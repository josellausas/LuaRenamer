-- Created by jose llausas jose@zunware.com
local utils = require("utils")

local renamer = {}

--[[ Renames files in path numerically : 01.x , 02.x , .. 
	 Returs true if success. False if not success ]]
function renamer.numericRename(pathToFiles, filenamesTable)
	if not pathToFiles or not filenamesTable then return false end

	-- Loops the table and renames each file with its number: 01.xxx
	for i=1, #filenamesTable do
		-- Buld a full qualified path to the file
		local fullPathName = pathToFiles .. filenamesTable[i]

		local extension = utils.getFileExtension(filenamesTable[i])

		-- Puts the 0 in the filenames < 10
		local newName = "error"
		if i < 10 then
			newName = pathToFiles .. "0" .. i
		else
			newName = pathToFiles .. i
		end

		local completeNewName = newName .. "." .. extension
		
		os.rename(fullPathName, completeNewName)
	end

	return true

end

return renamer






