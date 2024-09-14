-- To add
-- animation, wall collision, map


function love.load()
    love.window.setTitle("PingPong Platformer")

    -- libraries -------------------------------------------
    -- physics --
    wf = require 'libraries/windfield'
    world = wf.newWorld(0,0)

    -- camera --
    camera = require 'libraries/camera'
    cam = camera()

    --background
    sti = require "libraries/sti"
    --gameMap = sti("") -- enter map

    --player sprite--
    anim8 = require 'libraries/anim8'
    love.graphics.setDefaultFilter("nearest", "nearest")
    -- --------------------------------------------------------

    -- PLAYER
    player = {}
    player.collider = world:newBSGRectangleCollider(400, 250, 50, 70, 10)
    player.collider:setFixedRotation(true)
    player.x = 400
    player.y = 200
    player.speed = 300
    player.width = 20
    player.height = 30


end

function love.update(dt)
    local isMoving = false
    local hasBall = false

    local volocityX = 0
    local volocityY = 0

    -- movement of player
    if love.keyboard.isDown("d") then --right
        volocityX = player.speed
        --player.anim = player.animations.right
        isMoving = true
        --[[wall collision
        if player.x > mapW then
            volocityX = 0
            isMoving = false
        end]]
    end

    if love.keyboard.isDown("a") then --left
        volocityX = player.speed * -1
        --player.anim = player.animations.left
        isMoving = true
        --[[wall collision
        if player.x < 0 then
            volocityX = 0
            isMoving = false
        end]]
    end
    
    if love.keyboard.isDown("s") then --down
        volocityY = player.speed
        --player.anim = player.animations.down
        isMoving = true
        --[[wall collision
        if player.y > mapH then
            volocityY = 0
            isMoving = false
        end]]
    end

    if love.keyboard.isDown("w") then --up
        volocityY = player.speed * -1
        --player.anim = player.animations.up
        isMoving = true
        --[[wall collision
        if player.y < 0 then
            volocityY = 0
            isMoving = false
        end]]
    end

    player.collider:setLinearVelocity(volocityX, volocityY)

    -- world collision detection --
    world:update(dt)
    player.x = player.collider:getX()
    player.y = player.collider:getY()
end

function love.draw()
    love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
end