WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

push = require 'push'

--[[
    Runs when the game first starts up, only once; used to initialize the game.
]]
function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- more "retro-looking" font object we can use for any text
    smallFont = love.graphics.newFont('font.ttf', 8)

    -- set LOVE's active font to the smallFont object
    love.graphics.setFont(smallFont)

    -- initialize window with virtual resolution
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = false
    })
end

--[[
    Keyboard handling, called by LOVE each frame;
    passes in the key we pressed so we can access.
]]
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

--[[
    Called after update by LOVE, used to draw anything to the screen, updated or otherwise.
]]
function love.draw()

    -- begin rendering at virtual resolution
    push:apply('start')

    -- clear the screen with a specific color; in this case, a color similar
    -- to some versions of the original Pong
    love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)

    -- draw welcome text toward the top of the screen
    love.graphics.printf("Hello Pong!", 0, 20, VIRTUAL_WIDTH, 'center')

    -- render first paddle (left side)
    love.graphics.rectangle('fill', 5, 20, 5, 20)

    -- render second paddle (right side)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 40, 5, 20)

    -- render ball (center)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)    

    -- end rendering at virtual resolution
    push:apply('end')
end