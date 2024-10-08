require "objects/paddle"
require "objects/ball"

function love.load()
    love.window.setTitle("PingPong Platformer")

    -- libraries -------------------------------------------
    -- physics --
    wf = require 'libraries/windfield'
    world = wf.newWorld(1, 1, true)
    world:setGravity(0,7000)

    -- camera --
    camera = require 'libraries/camera'
    cam = camera()

    -- background
    sti = require "libraries/sti"
    gameMap = sti("maps/platformMap.lua")

    -- player sprite--
    anim8 = require 'libraries/anim8'
    love.graphics.setDefaultFilter("nearest", "nearest")
    -- --------------------------------------------------------
    -- Jumping
    allowedJump = true
    jumpDist = 50
    jumpBuild = 0
    groundY = player
    
    -- PLAYER
    player = {}
    player.collider = world:newBSGRectangleCollider(400, 400, 50, 70, 10)
    player.collider:setFixedRotation(true)
    player.x = 400
    player.y = 400
    player.speed = 300
    player.width = 20
    player.height = 30

    groundY = player.y

    -- PADDLE
    paddle = Paddle:new(30, 100, 75, 150,{1, 1, 1}, 200)

    -- Collision from Tiled Map
    walls = {}
    if gameMap.layers["Walls"] then
        for i, obj in pairs(gameMap.layers["Walls"].objects) do
            local fence = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
            fence:setType('static')
            table.insert(walls, fence)
        end
    end

end

function love.update(dt)
    local isMoving = false
    local hasBall = false

    local volocityX = 0
    local volocityY = 0

    local mapW = gameMap.width * gameMap.tilewidth
    local mapH = gameMap.height * gameMap.tileheight 
    

    -- movement of player
    if love.keyboard.isDown("d") then --right
        volocityX = player.speed
        --player.anim = player.animations.right
        isMoving = true
        --wall collision
        if player.x > mapW then
            volocityX = 0
            isMoving = false
        end
    end

    if love.keyboard.isDown("a") then --left
        volocityX = player.speed * -1
        isMoving = true
        --wall collision
        if player.x < 0 then
            volocityX = 0
            isMoving = false
        end
    end

    -- jumping
    if jumpDist == 150 then
        allowedJump = true
    end

    if jumpDist == 0 then 
            allowedJump = false
        end
    if love.keyboard.isDown("space") and allowedJump == true then --up
        volocityY = player.speed * -150
        isMoving = true
        jumpDist = jumpDist - 50
        jumpBuild = 0
    end

    if jumpDist < 150 then
        jumpBuild = jumpBuild + 1
    end

    if jumpBuild == 100 then
        jumpDist = 150
    end
    

    -- check if player is touching the ground
    -- loop to go through all platforms, when found (x) -> check it's height
    --[[ if touching the ground then jumping is allowed
    for key, value in pairs(walls) do
        if player.x > value.x and player.x < value.height then
            if player.y == value.y then
                allowedJump = true
            else
                allowedJump = false
            end
            break
        end
    end

    if love.keyboard.isDown("space") and allowedJump == true then
        volocityY = player.speed * -1
    end ]]




    player.collider:setLinearVelocity(volocityX, volocityY)

    -- world collision detection --
    world:update(dt)
    player.x = player.collider:getX()
    player.y = player.collider:getY()

    -- CAMERA
    cam:lookAt(player.x, player.y)

    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()

    -- left
    if cam.x < w/2 then
        cam.x = w/2
    end
    -- top
    if cam.y < h/2 then
        cam.y = h/2
    end

    --right
    if cam.x > (mapW - w/2) then
        cam.x = (mapW - w/2)
    end
    --bottom
    if cam.y > (mapH - h/2) then
        cam.y = (mapH - h/2)
    end
end

function love.draw()
    cam:attach()
    -- background
        gameMap:drawLayer(gameMap.layers["Tile Layer 1"])
        gameMap:drawLayer(gameMap.layers["platform"])


        love.graphics.setColor(paddle.colour)
        love.graphics.rectangle("fill", paddle.x, paddle.y, paddle.width, paddle.height)
        love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
    cam:detach()
end