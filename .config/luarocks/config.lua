-- luacheck: ignore 111 113

rocks_trees = {
   {
      name = "user",
      root = home.."/.local"
   },
   {
      name = "system",
      root = "/usr"
   }
}
home_tree = home.."/.local"
homeconfdir = home.."/.config/luarocks"
lua_version = "5.3"
