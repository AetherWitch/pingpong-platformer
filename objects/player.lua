wf = require 'libraries/windfield'
world = wf.newWorld(0,0)

Player = {
    x = 0,
    y = 0,
    speed,
    width,
    height,
    propImg,
    restitution,
    angularImpulse
}

function Player:new(x, y, speed, width, height)
    playerTable = {
        x=x,
        y=y,
        speed=speed,
        width=width,
        height=height
    }
    setmetatable(playerTable, self)
    self.__index = self
    return playerTable
end

return Player