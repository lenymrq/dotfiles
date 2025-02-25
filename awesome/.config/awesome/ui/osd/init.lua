local path = ... .. '.'

return function(s)
   return {
      volume = require(path .. '.volume')(s),
      brightness = require(path .. '.brightness')(s)
   }
end
