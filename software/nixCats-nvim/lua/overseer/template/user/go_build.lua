return {
  name = "go build",
  builder = function()
    return {
      cmd = { "go" },
      args = { "build", "." },
      components = { "default" },
    }
  end,
  condition = {
    filetype = { "go" },
  },
}