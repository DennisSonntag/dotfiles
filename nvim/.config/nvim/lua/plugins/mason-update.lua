return {
	'RubixDev/mason-update-all',
	config = function()
		local mason_update_status, mason_update = pcall(require, "mason-update-all")
		if (not mason_update_status) then return end
		mason_update.setup()
	end
}
