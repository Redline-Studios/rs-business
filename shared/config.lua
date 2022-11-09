Config = {}

-- DEBUG CONFIGS --
Config.Debug = true -- Client / Server Debug Prints
Config.DebugPoly = true -- Debug Polyzones

-- PROGRESSBAR CONFIGS --
Config.Times = { -- Time to make items (Set in seconds)
    Food = 5,
    Drinks = 5
}

-- MINIGAME CONFIG --
Config.Minigame = {
    Circles = 2,
    Time = 20
}

-- BUSINESS CONFIGS --
Config.Job = 'beanmachine' -- Name of the job in 'qb-core > shared > jobs.lua'
Config.Business = {
    Name = 'Bean Machine', -- Blip Name / Business Name
    AutoDuty = true, -- Players on/off duty auto changes when entering/leaving the polyzone

    -- Business Blip Info
    Blip = {
        coords = vector3(119.42, -1037.94, 29.28),
        sprite = 106,
        color = 31,
        size = 0.5,
    },

    -- For on/off duty when enetering the business (Only used if AutoDuty = true)
    BusinessPoly = {
        minZ = 28,
        maxZ = 31,
        zone = {
            vector2(112.20778656006, -1045.7586669922),
            vector2(119.12358093262, -1026.5433349609),
            vector2(128.96510314941, -1029.9719238281),
            vector2(121.7850112915, -1049.6458740234)
        }
    },
}

Config.Locations = {
    ['Registers'] = {
        [1] = {
            coords = vector3(120.76, -1040.11, 29.28),
            heading = 340,
            width = 0.5,
            length = 0.5,
            info = {
                label = 'Register',
                icon = 'fas fa-dollar-sign',
                event = 'jim-payments:client:Charge', -- Use your own payments event
            }
        },
        [2] = {
            coords = vector3(122.02, -1036.51, 29.28),
            heading = 340,
            width = 0.5,
            length = 0.5,
            info = {
                label = 'Register',
                icon = 'fas fa-dollar-sign',
                event = 'jim-payments:client:Charge', -- Use your own payments event
            }
        }
    },
    ['Food'] = {
        [1] = {
            coords = vector3(121.53, -1038.43, 29.28),
            heading = 339,
            width = 1.6,
            length = 1,
            info = {
                label = 'Bean Machine Food',
                icon = 'fas fa-burger',
            }
        }
    },
    ['Drinks'] = {
        [1] = {
            coords = vector3(126.08, -1036.56, 29.28),
            heading = 249,
            width = 0.8,
            length = 0.5,
            info = {
                label = 'Bean Machine Drinks',
                icon = 'fas fa-droplet',
            }
        }
    },
    ['Coffee'] = {
        [1] = {
            coords = vector3(122.84, -1041.62, 29.28),
            heading = 251,
            width = 0.5,
            length = 1,
            info = {
                label = 'Bean Machine Coffee',
                icon = 'fas fa-mug-hot',
            }
        }
    },
    ['Alcohol'] = {
        [1] = {
            coords = vector3(0,0,0),
            heading = 0,
            width = 0,
            length = 0,
            info = {
                label = 'Alcohol',
                icon = 'fas fa-wine-glass',
            }
        }
    },
}

-- FOOD CONFIG --
Config.Food = {  -- Set 'stress' to 0 for no stress relief
    [1] = {
        Item = 'tosti', -- Oooh yeah, a grilled cheese
        Emote = 'bbq',
        Required = {
            [1] = {
                item = 'water_bottle',
                amount = 2,
                stress = 2
            },
        }
    }
}

-- DRINKS CONFIG --
Config.Drinks = { -- Set 'stress' to 0 for no stress relief
    [1] = {
        Item = 'water_bottle', -- Yeah, you make that water bottle...
        Emote = 'handshake',
        Required = {
            [1] = {
                item = '',
                amount = 1,
                stress = 2
            },
        }
    }
}

-- COFFEE CONFIG --
Config.Coffee = { -- Set 'stress' to 0 for no stress relief
    [1] = {
        Item = 'coffee',
        Emote = 'handshake',
        Required = {
            [1] = {
                item = 'water_bottle',
                amount = 1,
                stress = 2
            },
        }
    }
}

-- ALCOHOL CONFIG --
Config.Alcohol = { -- Set 'stress' to 0 for no stress relief
    [1] = {
        Item = 'vodka',
        Emote = 'handshake',
        Required = {
            [1] = {
                item = 'water_bottle',
                amount = 1,
                stress = 2
            },
        }
    }
}
