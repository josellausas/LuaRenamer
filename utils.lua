-- My Utils by jose@josellausas.com

local utils = {}

--[[ splitTextToTable(str)
		Splits a string into table elements when it finds the newline 
  ]]
function utils.splitTextToTable(str)
	t={}
	for line in str:gmatch("[^\r\n]+") do  
		table.insert(t, line)
	end
	return t
end

--[[ justRunCmd(command)
		Runs the command and suppresses output. Returns true if successful
  ]]
function utils.justRunCmd(command)
	local success = nil
	local signal  = nil
	local number  = nil

	success, signal, number = os.execute(command)

	if not success then print('Error running command') return false end

	return true
end

--[[ runCmd(command)
		Runs the command and returns its output
  ]]
function utils.runCmd(command)
	local handle = io.popen(command)
	local result = handle:read("*a")
	handle:close()

	if not result then 
		print('Error with cmd ' .. command) 
	end

	return result
end

--[[ returns the Extension .xxx of a string blahblah.xxx ]]
function utils.getFileExtension(string)
	-- returns 3 params: full filename extension
	-- local x = nil
	-- local y = nil
	-- local extension = nil
	local a, b, extension = string.match(string, "(.-)([^\\/]-%.?([^%.\\/]*))$")
	return extension
end

return utils