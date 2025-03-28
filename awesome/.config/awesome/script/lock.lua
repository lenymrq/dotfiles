local awful = require('awful')

return function()
   awful.spawn.with_shell('lock')
end
