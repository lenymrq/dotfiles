local awful = require('awful')
return function() awful.spawn.with_shell("~/.config/awesome/script/lock.sh") end
