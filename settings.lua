data:extend{
    {
        type = "bool-setting",
        name = "picker-enable-sign-entities",
        setting_type = "startup",
        default_value = true,
        order = "[sticky-notes]-a"
    }
}

data:extend {
    {
        type = 'string-setting',
        name = 'picker-notes-default-message',
        setting_type = 'runtime-global',
        default_value = '',
        allow_blank = true,
        order = 'picker-notes-aa'
    },
    {
        type = 'bool-setting',
        name = 'picker-notes-default-autoshow',
        setting_type = 'runtime-global',
        default_value = false,
        order = 'picker-notes-bb'
    },
    {
        type = 'bool-setting',
        name = 'picker-notes-default-mapmark',
        setting_type = 'runtime-global',
        default_value = false,
        order = 'picker-notes-cb'
    },
    {
        type = 'bool-setting',
        name = 'picker-notes-use-color-picker',
        setting_type = 'runtime-global',
        default_value = true,
        order = 'picker-notes-db'
    }
}
