Ball = {
    x = 0,
    y = 0,
    radius,
    colour
}

function Ball:new(x, y, radius, colour)
    ballTable = {
        x=x,
        y=y,
        radius=radius,
        colour=colour
    }
    setmetatable(ballTable, self)
    self.__index = self
    return ballTable
end

return Ball