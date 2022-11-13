Config = {}

-- DEBUG CONFIGS --
Config.Debug = true -- Client / Server Debug Prints
Config.DebugPoly = true -- Debug Polyzones

-- PROGRESSBAR CONFIGS --
Config.Times = { -- Time to make items (Set in seconds)
    Food = 5,
    Drinks = 5,
    WashHands = 5
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
        sprite = 1,
        color = 1,
        size = 0.5,
    },

    -- For on/off duty when enetering the business (Only used if AutoDuty = true)
    BusinessPoly = {
        Zones = {
            [1] = {
                minZ = 28,
                maxZ = 31,
                zone = {
                    vector2(112.20778656006, -1045.7586669922),
                    vector2(119.12358093262, -1026.5433349609),
                    vector2(128.96510314941, -1029.9719238281),
                    vector2(121.7850112915, -1049.6458740234)
                }
            }
        }
    },
}

Config.Locations = {
    ['Registers'] = { -- Cash Register Locations
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
    ['Duty'] = { -- On / Off Duty Locations
        [1] = {
            coords = vector3(126.39, -1034.39, 29.28),
            heading = 340,
            width = 0.9,
            length = 0.5,
            info = {
                label = 'On / Off Duty',
                icon = 'fas fa-clock',
            }
        }
    },
    ['Stashes'] = { -- Stash Locations
        [1] = {
            coords = vector3(120.54, -1043.94, 29.28),
            heading = 340,
            width = 0.8,
            length = 1.0,
            info = {
                label = 'Stash',
                icon = 'fas fa-box',
            }
        }
    },
    ['Trays'] = { -- Locations for Trays (Give Food to Customers)
        [1] = {
            coords = vector3(120.66, -1040.78, 29.28),
            heading = 340,
            width = 0.6,
            length = 1,
            info = {
                label = 'Tray',
                icon = 'fas fa-box',
            }
        },
        [2] = {
            coords = vector3(122.0, -1037.14, 29.28),
            heading = 340,
            width = 0.6,
            length = 1,
            info = {
                label = 'Tray',
                icon = 'fas fa-box',
            }
        }
    },
    ['Sink'] = { -- Sink Locations
        [1] = {
            coords = vector3(123.73, -1039.27, 29.28),
            heading = 340,
            width = 1.6,
            length = 1.0,
            info = {
                label = 'Wash Hands',
                icon = 'fas fa-soap',
            }
        }
    },
    ['Food'] = { -- Make Food Locations
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
    ['Drinks'] = { -- Make Drink Locations
        [1] = {
            coords = vector3(126.08, -1036.56, 29.28),
            heading = 249,
            width = 0.8,
            length = 0.5,
            info = {
                label = 'Drinks',
                icon = 'fas fa-droplet',
            }
        }
    },
    ['Coffee'] = { -- Make Coffee Locations
        [1] = {
            coords = vector3(122.84, -1041.62, 29.28),
            heading = 251,
            width = 0.5,
            length = 1,
            info = {
                label = 'Coffee',
                icon = 'fas fa-mug-hot',
            }
        }
    },
    ['Alcohol'] = { -- Make Alcohol Locations
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

-- STASH CONFIG --
Config.Stashes = {
    MaxSlots = 10,
    MaxWeight = 2000
}

-- TRAY CONFIG --
Config.Trays = {
    MaxSlots = 10,
    MaxWeight = 2000
}

-- FOOD CONFIG --
Config.Food = {
    [1] = {
        Item = 'tosti', -- Oooh yeah, a grilled cheese
        CraftEmote = 'bbq', -- Emote used when making the item
        UseEmote = 'burger', -- Emote used when using the item
        UseTime = 5, -- How long you use the item for (set in seconds)
        Hunger = 2, -- How much hunger it refills
        Required = {
            [1] = {
                item = 'water_bottle',
                amount = 2,
            },
        }
    }
}

-- DRINKS CONFIG --
Config.Drinks = {
    [1] = {
        Item = 'water_bottle', -- Yeah, you make that water bottle...
        CraftEmote = 'handshake', -- Emote used when making the item
        UseEmote = 'water', -- Emote used when using the item
        UseTime = 5, -- How long you use the item for (set in seconds)
        Thirst = 2, -- How much thirst it refills
        Required = {
            [1] = {
                item = 'water_bottle',
                amount = 1,
            },
        }
    }
}

-- COFFEE CONFIG --
Config.Speed = {
    Multiplier = 1.1, -- How fast you run
    Length = math.random(20, 30) -- How long you run fast for (Set in seconds)
}
Config.Coffee = {
    [1] = {
        Item = 'coffee',
        CraftEmote = 'handshake', -- Emote used when making the item
        UseEmote = 'coffee', -- Emote used when using the item
        UseTime = 5, -- How long you use the item for (set in seconds)
        Thirst = 2, -- How much thirst it refills
        Required = {
            [1] = {
                item = 'water_bottle',
                amount = 1,
            },
        }
    }
}

-- ALCOHOL CONFIG --
Config.Drunk = {
    Liquor = { -- Values for liquor
        Min = 1, -- Slight Buzz
        Max = 3, -- Riggity-Wrecked, my guy
        Length = math.random(2, 3) -- How long you are drunk for, in minutes
    },
    Beer = { -- Values for beer
        Min = 1, -- Slight Buzz
        Max = 3, -- Riggity-Wrecked, my guy
        Length = math.random(2, 3) -- How long you are drunk for, in minutes
    }
}
Config.Alcohol = {
    [1] = {
        Item = 'vodka',
        CraftEmote = 'handshake', -- Emote used when making the item
        UseEmote = 'drink', -- Emote used when using the item
        UseTime = 5, -- How long you use the item for (set in seconds)
        Thirst = 2, -- How much thirst it refills
        Required = {
            [1] = {
                item = 'water_bottle',
                amount = 1,
            },
        }
    }
}
