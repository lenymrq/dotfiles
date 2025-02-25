local path = ... .. '.'

return function(s)
   return {
      volume = require(path .. '.volume')(s),
      -- player = require(path .. '.player')(s)
      brightness = require(path .. '.brightness')(s)
   }
end
