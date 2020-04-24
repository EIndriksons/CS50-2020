WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

--[[
    Screen size for that retro look (16:9 aspect ratio)
]]
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

push = require 'push'               -- Library that handles screen rendering

--[[
    Runs when the game first starts up, only once; used to initialize the game.
]]
function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest') -- To prevent blurry font due to resizing, we must change screen filtering
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = false
    })
end

function love.keypressed(key)       -- Handles when a key is pressed
    if key == 'escape' then
        love.event.quit()
    end
end

--[[
    Called after update by LOVE, used to draw anything to the screen, updated or otherwise.
]]
function love.draw()
    push:apply('start')             -- Switch ON for push screen rendering

    love.graphics.printf(
        "Hello Pong!",              -- Text to render
        0,                          -- starting X (0 since we're going to center it based on width)
        VIRTUAL_HEIGHT / 2 - 6,     -- starting Y (halfway down the screen)
        VIRTUAL_WIDTH,              -- number of pixels to center within (the entire screen here)
        'center')                   -- alignment mode, can be 'center', 'left', or 'right'

    push:apply('end')               -- Switch OFF for push screen rendering
end