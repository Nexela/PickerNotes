local Event = require('__stdlib__/stdlib/event/event')
Event.protected_mode = true
local interface = require('__stdlib__/stdlib/scripts/interface')
require('__stdlib__/stdlib/event/player').register_events()

require('scripts/notes')

remote.add_interface(script.mod_name, interface)
