return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.11.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 12,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 16,
  nextobjectid = 58,
  properties = {
    ["has_tile_sounds"] = true,
    ["music"] = "bloom_f",
    ["name"] = "Blooming Forest - Flower Bed"
  },
  tilesets = {
    {
      name = "Forest",
      firstgid = 1,
      filename = "../tilesets/Forest.tsx",
      exportfilename = "../tilesets/Forest.lua"
    },
    {
      name = "trees",
      firstgid = 1201,
      filename = "../tilesets/trees.tsx",
      exportfilename = "../tilesets/trees.lua"
    },
    {
      name = "debug",
      firstgid = 1205,
      filename = "../tilesets/debug.tsx",
      exportfilename = "../tilesets/debug.lua"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 12,
      height = 12,
      id = 12,
      name = "below",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 224, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 224, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 224, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        223, 223, 223, 223, 223, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        223, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 12,
      height = 12,
      id = 11,
      name = "cliff",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        94, 94, 94, 94, 94, 224, 0, 0, 0, 0, 0, 0,
        94, 94, 94, 94, 94, 224, 0, 0, 0, 0, 0, 0,
        94, 94, 94, 94, 94, 224, 0, 0, 0, 0, 0, 0,
        94, 94, 94, 94, 94, 224, 0, 0, 0, 0, 0, 0,
        94, 94, 94, 94, 94, 224, 0, 0, 0, 0, 0, 0,
        94, 94, 94, 94, 94, 224, 0, 0, 0, 0, 0, 0,
        94, 94, 94, 94, 94, 224, 0, 0, 0, 0, 0, 0,
        94, 94, 94, 94, 94, 224, 0, 0, 0, 0, 0, 0,
        94, 94, 94, 94, 94, 224, 0, 0, 0, 0, 0, 0,
        134, 134, 134, 134, 134, 224, 0, 0, 0, 0, 0, 0,
        222, 223, 223, 223, 223, 224, 0, 0, 0, 0, 0, 0,
        262, 223, 223, 223, 223, 224, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 15,
      name = "objects",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 57,
          name = "shadow",
          type = "",
          shape = "point",
          x = 44,
          y = 99,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 14,
      name = "objects_party",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {}
    },
    {
      type = "imagelayer",
      image = "../../../assets/sprites/world/clouds.png",
      id = 13,
      name = "Image Layer 1",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 320,
      parallaxx = 1,
      parallaxy = 1,
      repeatx = true,
      repeaty = false,
      properties = {}
    }
  }
}
