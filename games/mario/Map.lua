require 'Util'

Map = Class{}

TILE_BRICK = 1
TILE_EMPTY = 4

local SCROLL_SPEED = 62

function Map:init()
    self.spritesheet = love.graphics.newImage('graphics/spritesheet.png')
    self.tileWidth = 16
    self.tileHeight = 16
    self.mapWidth = 30
    self.mapHeight = 28
    self.tiles = {}

    -- camera offsets
    self.camX = 0
    self.camY = -3

    -- generate a quad (individual frame/sprite) for each tile
    self.tileSprite = generateQuads(self.spritesheet, self.tileWidth, self.tileHeight)

    self.mapWidthPixels = self.mapWidth * self.tileWidth
    self.mapHeightPixels = self.mapHeight * self.tileHeight

    -- filling the map with empty tiles
    for y = 1, self.mapHeight do 
        for x = 1, self.mapWidth do
            self:setTile(x, y, TILE_EMPTY)
        end
    end

    -- starts halfway down the map, populates with bricks
    for y = self.mapHeight / 2, self.mapHeight do
        for x = 1, self.mapWidth do
            self:setTile(x, y, TILE_BRICK)
        end
    end
end

function Map:update(dt)
    if love.keyboard.isDown('w') then
        -- up movement
        self.camY = math.max(0, math.floor(self.camY + dt * -SCROLL_SPEED))
    elseif love.keyboard.isDown('a') then
        -- left movement
        self.camX = math.max(0, math.floor(self.camX + dt * -SCROLL_SPEED))
    elseif love.keyboard.isDown('s') then
        -- down movement
        self.camY = math.min(self.mapHeightPixels - VIRTUAL_HEIGHT, math.floor(self.camY + dt * SCROLL_SPEED))
    elseif love.keyboard.isDown('d') then
        -- right movement
        self.camX = math.min(self.mapWidthPixels - VIRTUAL_WIDTH, math.floor(self.camX + dt * SCROLL_SPEED))
    end
end

-- returns an integer value for the tile at a given x-y coordinate
function Map:getTile(x, y)
    return self.tiles[(y - 1) * self.mapWidth + x]
end

-- sets a tile at a given x-y coordinate to an integer value
function Map:setTile(x, y, tile)
    self.tiles[(y - 1) * self.mapWidth + x] = tile
end

function Map:render()
    for y = 1, self.mapHeight do
        for x = 1, self.mapWidth do
            love.graphics.draw(self.spritesheet, self.tileSprite[self:getTile(x, y)],
                (x - 1) * self.tileWidth, (y - 1) * self.tileHeight)
        end
    end
end