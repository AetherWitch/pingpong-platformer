Paddle = {
    x = 0,
    y = 0,
    width,
    height,
    colour,
    speed
}

function Paddle:new(x, y, width, height, colour)
    paddleTable = {
        x=x,
        y=y,
        width=width,
        height=height,
        colour=colour,
        speed=speed
    }
    setmetatable(paddleTable, self)
    self.__index = self
    return paddleTable
end

return Paddle