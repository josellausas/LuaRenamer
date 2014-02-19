#!/usr/bin/env lua
-- Created by jose llausas jose@zunware.com

-- function SplitMeIntolines(str)
-- 	local t = {}
-- 	local function helper(line) 
-- 		table.insert(t, line) 
-- 		return "" 
-- 	end
-- 	helper((str:gsub("(.-)r?n", helper)))
-- 	return t
-- end

function splitThis(str)
	t={}
	for line in str:gmatch("[^\r\n]+") do  
		table.insert(t, line)
	end
	return t
end

local function mySimpleExecute(command)
	local success = nil
	local signal  = nil
	local number  = nil

	success, signal, number = os.execute(command)

	if not success then print('Error running command') return false end

	return true
end

local function myExecute(command)
	local handle = io.popen(command)
	local result = handle:read("*a")
	handle:close()

	if not result then 
		print('Error with cmd ' .. command) 
	end

	return result

end

-- Starts here
if #arg == 0 then
	print('USAGE:\nrenamer.lua pathToFiles')
	return 0
end

local pathToFiles = arg[1]


local comando01 = ('cd ' .. pathToFiles)


local function getExtension(string)
	local full = nil
	local extension = nil

	return string.match(string, "(.-)([^\\/]-%.?([^%.\\/]*))$")
	
	
end

if mySimpleExecute(comando01) then
	print('Renaming files inside:')
	print(pathToFiles .. '\n')

	local filesNames = myExecute('ls ' .. pathToFiles)
	
	local splitNames = splitThis(filesNames)

	print(#splitNames)

	for i=1, #splitNames do
		-- print(splitNames[i])

		local fullPathName = pathToFiles .. splitNames[i]
		-- print(fullPathName)
		-- print(newName)

		local a, b, extension= getExtension(splitNames[i])

		local newName = "error"
		if i < 10 then
			newName = pathToFiles .. "0" .. i
		else
			newName = pathToFiles .. i
		end

		local completeNewName = newName .. "." .. extension
		
		-- print(fullPathName)
		-- print(completeNewName)
		os.rename(fullPathName, completeNewName)

	end
else
	print('Invalid Path')
end

