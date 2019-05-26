local Event = require('__stdlib__/stdlib/event/event')
local Gui = require('__stdlib__/stdlib/event/gui')
--local table = require('__stdlib__/stdlib/utils/table')

-- (( GUI LAYOUT ))--
local function menu_note(player, pdata, open_or_close)
    if open_or_close == nil then
        open_or_close = (player.gui.center.flow_stknt == nil)
    end

    if player.gui.center.flow_stknt then
        player.gui.center.flow_stknt.destroy()
    end

    if open_or_close then
        local flow, frame, color_button
        local note = pdata.note_sel

        if note then
            flow =
                player.gui.center.add {
                type = 'flow',
                name = 'flow_stknt',
                style = 'achievements_vertical_flow',
                direction = 'vertical'
            }
            frame =
                flow.add {
                type = 'frame',
                name = 'frm_stknt',
                caption = {'notes-gui.title', (player.selected and player.selected.unit_number) or note.n},
                style = 'frame_stknt_style',
                direction = 'vertical'
            }

            local table_main =
                frame.add {
                type = 'table',
                name = 'tab_stknt_main',
                column_count = 1,
                style = 'picker_table'
            }
            local txt_box =
                table_main.add {
                type = 'text-box',
                name = 'txt_stknt',
                text = note.text,
                style = 'textbox_stknt_style',
                word_wrap = true
            }

            if not settings.global['picker-notes-use-color-picker'].value then
                local table_colors =
                    table_main.add {
                    type = 'table',
                    name = 'tab_stknt_colors',
                    style = 'picker_table',
                    column_count = 10
                }
                for name, color in pairs(defines.color) do
                    color_button =
                        table_colors.add {
                        type = 'button',
                        name = 'but_stknt_col_' .. name,
                        caption = '@',
                        style = 'button_stknt_style'
                    }
                    color_button.style.font_color = color
                end
            end

            local table_checks =
                table_main.add {
                type = 'table',
                name = 'tab_stknt_check',
                column_count = 2,
                style = 'picker_table'
            }
            table_checks.add {
                type = 'checkbox',
                name = 'chk_stknt_autoshow',
                caption = {'notes-gui.autoshow'},
                state = note.autoshow or false,
                tooltip = {'notes-gui-tt.autoshow'},
                style = 'checkbox_stknt_style'
            }
            table_checks.add {
                type = 'checkbox',
                name = 'chk_stknt_mapmark',
                caption = {'notes-gui.mapmark'},
                state = note.mapmark ~= nil,
                tooltip = {'notes-gui-tt.mapmark'},
                style = 'checkbox_stknt_style'
            }
            table_checks.add {
                type = 'checkbox',
                name = 'chk_stknt_locked_force',
                caption = {'notes-gui.locked-force'},
                state = note.locked_force or false,
                tooltip = {'notes-gui-tt.locked-force'},
                style = 'checkbox_stknt_style'
            }
            table_checks.add {
                    type = 'checkbox',
                    name = 'chk_stknt_locked_admin',
                    caption = {'notes-gui.locked-admin'},
                    state = note.locked_admin or false,
                    tooltip = {'notes-gui-tt.locked-admin'},
                    style = 'checkbox_stknt_style'
                }.enabled = player.admin

            local table_but =
                table_main.add {
                type = 'table',
                name = 'tab_stknt_but',
                column_count = 6,
                style = 'picker_table'
            }
            table_but.add {
                type = 'button',
                name = 'but_stknt_delete',
                caption = {'notes-gui.delete'},
                tooltip = {'notes-gui-tt.delete'},
                style = 'button_stknt_style'
            }
            table_but.add {
                type = 'button',
                name = 'but_stknt_close',
                caption = {'notes-gui.close'},
                tooltip = {'notes-gui-tt.close'},
                style = 'button_stknt_style'
            }
            -- Use Color Picker mod if enabled.
            if settings.global['picker-notes-use-color-picker'].value and remote.interfaces[color_picker_interface] then
                table_but.add {
                    type = 'button',
                    name = open_color_picker_button_name,
                    caption = {'gui-train.color'},
                    style = 'button_stknt_style'
                }
            end
            txt_box.focus()
            player.opened = flow
        end
    end
end

local Note = {}
Note.__index = Note

function new(entity)
    local note = {}
    note.map_mark = false
    note.display_force = true
    note.locked_force = true
    note.locked_admin = true
    note.surface = entity.surface
    note.force = entity.force

    return setmetatable(note, {__index = Note})
end

function Note:save()
end

function Note:load()
end

function Note:delete()
end

function Note:show()
    if self.fly and self.fly.valid then
        self.fly.render_to_forces = self.force_only and self.force or nil
    else
        self.fly = self.surface.create_entity{name = 'picker-note-text', pos = self.position}
        self.fly.render_to_forces = self.force_only and self.force or nil
    end
end

function Note:mapmark()
end

local function on_selected_entity_changed(event)
    local player = game.players[event.player_index]
    local selected = player.selected
    if selected and selected.unit_number then
        local note = global.notes[player.selected.unit_number]
        if note then
            note:show()
        end
    end
end
Event.register(defines.events.on_selected_entity_changed, on_selected_entity_changed)


local function setup_metatables()
    for _, note in pairs(global.notes) do
        setmetatable(note, Note.note_mt)
    end
end
Event.register(Event.core_events.load, setup_metatables)

local function on_init()
    global.notes = {}
end
Event.register(Event.core_events.init, on_init)

-- ))
--(( GUI Events ))--

--))
