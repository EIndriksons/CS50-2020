Class = require 'class'
push = require 'push'

require 'Map'

-- actual window resolution
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- close resolution to NES but 16:9
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243


function love.load()

    math.randomseed(os.time())

    -- an object to contain our map
    map = Map()

    -- makes upscaling look pixel-y instead of blurry
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- sets up virtual screen resolution for an authentic retro feel
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    love.keyboard.keysPressed = {}
end

-- called whenever a key is pressed
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    love.keyboard.keysPressed[key] = true
end


-- global key pressed function
function love.keyboard.wasPressed(key)
    if (love.keyboard.keysPressed[key]) then
        return true
    else
        return false
    end
end


function love.update(dt)
    map:update(dt)

    love.keyboard.keysPressed = {}
end


function love.draw()
    -- begin virtual resolution drawing
    push:apply('start')

    love.graphics.translate(-map.camX, -map.camY)

    -- clear screen using Mario background blue
    love.graphics.clear(108/255, 140/255, 255/255, 255)

    -- renders our map objects onto the screen
    map:render()

    -- end virtual resolution
    push:apply('end')
end