hs.window.animationDuration = 0

local mash = {"ctrl", "alt", "cmd"}

hs.hotkey.bind(mash, "M", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h
  win:maximize(0)
end)


-- hs.hotkey.bind(mash, "Left", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()
--   local screen = win:screen()
--   local max = screen:frame()

--   f.x = max.x
--   f.y = max.y
--   f.w = max.w / 3
--   f.h = max.h
--   win:setFrame(f, 0)
-- end)


hs.hotkey.bind(mash, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f, 0)
end)


hs.hotkey.bind(mash, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f, 0)
end)


hs.hotkey.bind(mash, "Up", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f, 0)
end)


hs.hotkey.bind(mash, "Down", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y + (max.h / 2)
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f, 0)
end)




-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Y", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()

--   f.x = f.x - 10
--   f.y = f.y - 10
--   win:setFrame(f, 0)
-- end)

-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "K", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()

--   f.y = f.y - 10
--   win:setFrame(f, 0)
-- end)

-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "U", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()

--   f.x = f.x + 10
--   f.y = f.y - 10
--   win:setFrame(f, 0)
-- end)

-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "H", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()

--   f.x = f.x - 10
--   win:setFrame(f, 0)
-- end)

-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "L", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()

--   f.x = f.x + 10
--   win:setFrame(f, 0)
-- end)

-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "B", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()

--   f.x = f.x - 10
--   f.y = f.y + 10
--   win:setFrame(f, 0)
-- end)

-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "J", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()

--   f.y = f.y + 10
--   win:setFrame(f, 0)
-- end)

-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "N", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()

--   f.x = f.x + 10
--   f.y = f.y + 10
--   win:setFrame(f, 0)
-- end)



function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")



-- local tiling = require "hs.tiling"
-- local mash = {"ctrl", "cmd"}

-- hs.hotkey.bind(mash, "c", function() tiling.cyclelayout() end)
-- hs.hotkey.bind(mash, "j", function() tiling.cycle(1) end)
-- hs.hotkey.bind(mash, "k", function() tiling.cycle(-1) end)
-- hs.hotkey.bind(mash, "space", function() tiling.promote() end)

-- If you want to set the layouts that are enabled
-- tiling.set('layouts', {
--   'fullscreen', 'main-vertical'
-- })
