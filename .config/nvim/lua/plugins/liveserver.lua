return {
	{
	  'https://git.barrettruth.com/barrettruth/live-server.nvim',
	  config = function()
		vim.g.live_server = {
		  port = 8080,
		  browser = true,
		}
	  end,
	}
}
