return function()
	local leader = vim.g.mapleader
	if not leader then
		--- default is \ (backslash) if not defined
		leader = "\\"
	end

	if leader == " " then
		-- replace the space char with space modifier
		leader = "<Space>"
	end

	return leader
end
