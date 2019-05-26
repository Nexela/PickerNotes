-------------------------------------------------------------------------------
--[StickyNotes]--
-------------------------------------------------------------------------------
local Data = require('__stdlib__/stdlib/data/data')
local Item = require('__stdlib__/stdlib/data/item')
local Recipe = require('__stdlib__/stdlib/data/recipe')
local Entity = require('__stdlib__/stdlib/data/entity')

local style = data.raw['gui-style'].default

data:extend {
    {
        type = 'font',
        name = 'font_stknt',
        from = 'default',
        border = false,
        size = 15
    },
    {
        type = 'font',
        name = 'font_bold_stknt',
        from = 'default-bold',
        border = false,
        size = 15
    }
}

style.frame_stknt_style = {
    type = 'frame_style',
    parent = 'frame',
    top_padding = 0,
    right_padding = 0,
    bottom_padding = 0,
    left_padding = 0,
    resize_row_to_width = true,
    resize_to_row_height = false
    -- max_on_row = 1,
}

style.flow_stknt_style = {
    type = 'flow_style',
    top_padding = 0,
    bottom_padding = 0,
    left_padding = 0,
    right_padding = 0,
    horizontal_spacing = 2,
    vertical_spacing = 2,
    resize_row_to_width = true,
    resize_to_row_height = false,
    max_on_row = 1,
    graphical_set = {type = 'none'}
}

style.label_stknt_style = {
    type = 'label_style',
    parent = 'label',
    font = 'font_stknt',
    align = 'left',
    default_font_color = {r = 1, g = 1, b = 1},
    hovered_font_color = {r = 1, g = 1, b = 1},
    top_padding = 1,
    right_padding = 1,
    bottom_padding = 0,
    left_padding = 1
}

style.label_bold_stknt_style = {
    type = 'label_style',
    parent = 'label_stknt_style',
    font = 'font_bold_stknt',
    default_font_color = {r = 1, g = 1, b = 0.5},
    hovered_font_color = {r = 1, g = 1, b = 0.5}
}

style.textfield_stknt_style = {
    type = 'textbox_style',
    font = 'font_bold_stknt',
    align = 'left',
    font_color = {},
    default_font_color = {r = 1, g = 1, b = 1},
    hovered_font_color = {r = 1, g = 1, b = 1},
    selection_background_color = {r = 0.66, g = 0.7, b = 0.83},
    top_padding = 0,
    bottom_padding = 0,
    left_padding = 1,
    right_padding = 5,
    minimal_width = 300,
    maximal_width = 600,
    graphical_set = {
        type = 'composition',
        filename = '__core__/graphics/gui.png',
        priority = 'extra-high-no-scale',
        corner_size = {3, 3},
        position = {16, 0}
    }
}

style.textbox_stknt_style = {
    type = 'textbox_style',
    font = 'font_bold_stknt',
    font_color = {},
    default_font_color = {r = 1, g = 1, b = 1},
    hovered_font_color = {r = 1, g = 1, b = 1},
    selection_background_color = {r = 0.66, g = 0.7, b = 0.83},
    top_padding = 0,
    bottom_padding = 0,
    left_padding = 1,
    right_padding = 5,
    minimal_width = 275,
    minimal_height = 75,
    maximal_width = 275,
    graphical_set = {
        type = 'composition',
        filename = '__core__/graphics/gui.png',
        priority = 'extra-high-no-scale',
        corner_size = {3, 3},
        position = {16, 0}
    }
}

style.button_stknt_style = {
    type = 'button_style',
    parent = 'button',
    font = 'font_bold_stknt',
    align = 'center',
    default_font_color = {r = 1, g = 1, b = 1},
    hovered_font_color = {r = 1, g = 1, b = 1},
    top_padding = 0,
    right_padding = 0,
    bottom_padding = 0,
    left_padding = 0,
    left_click_sound = {
        {
            filename = '__core__/sound/gui-click.ogg',
            volume = 1
        }
    }
}

style.checkbox_stknt_style = {
    type = 'checkbox_style',
    parent = 'checkbox',
    font = 'font_bold_stknt',
    font_color = {r = 1, g = 1, b = 1},
    top_padding = 0,
    bottom_padding = 0,
    left_padding = 0,
    right_padding = 2
    -- minimal_height = 32,
    -- maximal_height = 32,
}

Data {type = 'custom-input', name = 'picker-notes', key_sequence = 'ALT + W'}

Data {
    type = 'sprite',
    name = 'picker-sticky-sprite',
    filename = '__PickerNotes__/graphics/sticky-note.png',
    priority = 'extra-high',
    width = 32,
    height = 32
}

Entity {
    type = 'programmable-speaker',
    name = 'picker-note-proxy',
    icon = '__PickerNotes__/graphics/sticky-note.png',
    icon_size = 32,
    flags = {'player-creation', 'placeable-off-grid', 'not-repairable', 'not-on-map'},
    collision_mask = {'not-colliding-with-itself'},
    minable = nil,
    max_health = 150,
    energy_source = {
        type = 'void'
    },
    energy_usage_per_tick = '1W',
    sprite = Data.Sprites.empty_picture(),
    audible_distance_modifier = 1, --multiplies the default 40 tiles of audible distance by this number
    maximum_polyphony = 1, --maximum number of samples that can play at the same time
    instruments = {},
    circuit_wire_max_distance = 0
}

Entity('flying-text', 'flying-text'):copy('picker-note-text'):set_fields {
    icon = '__PickerNotes__/graphics/sticky-note.png',
    icon_size = 32,
    speed = 0,
    time_to_live = 300
}

if settings.startup['picker-enable-sign-entities'].value then
    Data {
        type = 'technology',
        name = 'picker-notes',
        icon = '__PickerNotes__/graphics/sticky-notes.png',
        icon_size = 128,
        effects = {},
        unit = {
            count = 20,
            ingredients = {
                {'automation-science-pack', 1}
            },
            time = 10
        },
        order = 'k-c'
    }

    Recipe {
        type = 'recipe',
        name = 'picker-note',
        enabled = false,
        energy_required = 0.5,
        ingredients = {
            {'wood', 3}
        },
        result = 'picker-note',
        result_count = 1
    }:add_unlock('picker-notes')

    Data {
        type = 'item',
        name = 'picker-note',
        icon = '__PickerNotes__/graphics/sticky-note.png',
        icon_size = 32,
        subgroup = 'terrain',
        order = 'y',
        place_result = 'picker-note',
        stack_size = 100
    }

    Data('simple-entity-with-owner', 'simple-entity-with-owner'):copy('picker-note'):set_fields {
        icon = '__PickerNotes__/graphics/sticky-note.png',
        icon_size = 32,
        flags = {'placeable-player', 'placeable-neutral', 'player-creation'},
        picture = {
            filename = '__PickerNotes__/graphics/sticky-note.png',
            priority = 'extra-high',
            width = 32,
            height = 32,
            shift = {0, 0}
        },
        tile_width = 1,
        tile_height = 1,
        selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    }:remove_fields{'collision_box'}

    Recipe {
        type = 'recipe',
        name = 'picker-sign',
        enabled = false,
        energy_required = 1,
        ingredients = {
            {'iron-stick', 2}
        },
        result = 'picker-sign',
        result_count = 1
    }:add_unlock('picker-notes')

    Item {
        type = 'item',
        name = 'picker-sign',
        icon = '__PickerNotes__/graphics/sign-icon.png',
        icon_size = 32,
        subgroup = 'terrain',
        order = 'y',
        place_result = 'picker-sign',
        stack_size = 100
    }

    Data('simple-entity-with-owner', 'simple-entity-with-owner'):copy('picker-sign'):set_fields {
        icon = '__PickerNotes__/graphics/sign-icon.png',
        icon_size = 32,
        flags = {'placeable-player', 'placeable-neutral', 'player-creation'},
        picture = {
            filename = '__PickerNotes__/graphics/sign.png',
            priority = 'extra-high',
            width = 64,
            height = 64,
            shift = {0.5, -0.5}
        },
        tile_width = 1,
        tile_height = 1,
        selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    }:remove_fields{'collision_box'}
end
