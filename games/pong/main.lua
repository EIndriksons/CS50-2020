WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

push = require 'push'

--[[
    Runs when the game first starts up, only once; used to initialize the game.
]]
function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- more "retro-looking" font object we can use for any text
    smallFont = love.graphics.newFont('font.ttf', 8)
    scoreFont = love.graphics.newFont('font.ttf', 32)

    player1Score = 0
    player2Score = 0

    player1Y = 30
    player2Y = VIRTUAL_HEIGHT - 40

    -- initialize window with virtual resolution
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = false
    })
end

function love.update(dt)

    -- player 1 movement
    if love.keyboard.isDown('w') then

        -- add negative paddle speed to current Y scaled by deltaTime
        player1Y = player1Y - PADDLE_SPEED * dt
    elseif love.keyboard.isDown('s') then

        -- add positive paddle speed to current Y scaled by deltaTime
        player1Y = player1Y + PADDLE_SPEED * dt
    end

    -- player 2 movement
    if love.keyboard.isDown('up') then

         -- add negative paddle speed to current Y scaled by deltaTime
        player2Y = player2Y - PADDLE_SPEED * dt
    elseif love.keyboard.isDown('down') then

        -- add positive paddle speed to current Y scaled by deltaTime
        player2Y = player2Y + PADDLE_SPEED * dt
    end
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
    love.graphics.setFont(smallFont)
    love.graphics.printf("Hello Pong!", 0, 20, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(scoreFont)
    love.graphics.print(player1Score, VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
    love.graphics.print(player2Score, VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)

    -- render first paddle (left side)
    love.graphics.rectangle('fill', 10, player1Y, 5, 20)

    -- render second paddle (right side)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, player2Y, 5, 20)

    -- render ball (center)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)    

    -- end rendering at virtual resolution
    push:apply('end')
end