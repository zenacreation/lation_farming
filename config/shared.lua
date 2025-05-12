return {

    -- ⚠️ WARNING: When you are working with this script, never do "restart lation_farming"
    -- ⚠️ This will cause issues, data loss & more! You must restart the script like this:
    -- ⚠️ "stop lation_farming" ..wait a couple seconds.. then "ensure lation_farming"

    -- 🔎 Looking for more high quality scripts?
    -- 🛒 Shop Now: https://lationscripts.com
    -- 💬 Join Discord: https://discord.gg/9EbY4nM5uu
    -- 😢 How dare you leave this option false?!
    YouFoundTheBestScripts = false,

    ----------------------------------------------
    --        🛠️ Setup the basics below
    ----------------------------------------------

    setup = {
        -- Use only if needed, directed by support or know what you're doing
        -- Notice: enabling debug features will significantly increase resmon
        -- And should always be disabled in production
        debug = false,
        -- Set your interaction system below
        -- Available options are: 'ox_target', 'qb-target', 'interact' & 'custom'
        -- 'custom' needs to be added to client/functions.lua
        interact = 'ox_target',
        -- Set your notification system below
        -- Available options are: 'ox_lib', 'esx', 'qb', 'okok', 'sd-notify', 'wasabi_notify' & 'custom'
        -- 'custom' needs to be added to client/functions.lua
        notify = 'ox_lib',
        -- Set your progress bar system below
        -- Available options are: 'ox_lib', 'qbcore' & 'custom'
        -- 'custom' needs to be added to client/functions.lua
        -- Any custom progress bar must also support animations
        progress = 'ox_lib',
        -- Do you want to be notified via server console if an update is available?
        -- True if yes, false if no
        version = true,
    },

    ----------------------------------------------
    --       📈 Customize the XP system
    ----------------------------------------------

    experience = {
        -- The number in these [brackets] are the level
        -- The number after = is the exp required to reach that level
        -- Be sure levels *always* start at level 1 with 0 exp
        [1] = 0,
        [2] = 2500,
        [3] = 10000,
        [4] = 20000,
        [5] = 50000,
        -- You can add or remove levels as you wish
    },

    ----------------------------------------------
    --       🪓 Customize your shovels
    ----------------------------------------------

    shovels = {
        -- The number in [brackets] is the level required to buy/craft/use this shovel
        -- item: is the actual shovel item spawn name
        -- degrade: is how much the shovel degrades per farming action
        -- By default, normal shovel can mine 100 farm before breaking
        [1] = { item = 'ls_shovel', degrade = 1 },
        -- The copper shovel can mine 133 farm before breaking
        [2] = { item = 'ls_copper_shovel', degrade = 0.75 },
        -- The iron shovel can mine 200 farm before breaking
        [3] = { item = 'ls_iron_shovel', degrade = 0.5 },
        -- The silver shovel can mine 400 farm
        [4] = { item = 'ls_silver_shovel', degrade = 0.25 },
        -- And the gold shovel can mine 1,000 farm
        [5] = { item = 'ls_gold_shovel', degrade = 0.1 },
        -- The number of farm mined per shovel is simply: 100 / X
    },

    ----------------------------------------------
    --          🛒 Setup your shops
    ----------------------------------------------

    shops = {
        -- The location to spawn the main ped at the mine
        -- Both shops are available at this main ped, but you can toggle
        -- Either shop on or off as needed
        location = vec4(2434.62, 5011.58, 46.83, 306.65),
        -- The ped model used
        -- More models: https://docs.fivem.net/docs/game-references/ped-models/
        model = 'a_m_m_farmer_01',
        -- The scenario assigned to the ped (or nil/false for no scenario)
        -- More scenarios: https://github.com/DioneB/gtav-scenarios
        scenario = 'WORLD_HUMAN_DRINKING',
        -- What hours is this shop available?
        -- By default, it's 24/7, but for example - if you wish to only
        -- Allow access during the day, set hours = { min = 6, max = 20 }
        hours = { min = 0, max = 24 },
        -- Customize the mines supply shop
        -- This shop sells items to player
        mine = {
            -- Optionally disable this shop if you wish to grant access to
            -- farming supplies via another method
            enable = true,
            -- Use cash or bank when purchasing here?
            account = 'cash',
            -- Items available for sale in this shop
            items = {
                -- item: item spawn name
                -- price: price of item
                -- icon: icon for item
                -- metadata: optional metadata for item
                -- metadata: ⚠️ use 'durability' if using ox_inventory, otherwise use 'quality'
                -- level: optional player level requirement to purchase item
                [1] = { item = 'ls_shovel', price = 150, icon = 'hammer', metadata = { ['durability'] = 100 }, level = 1 },
                [2] = { item = 'ls_copper_shovel', price = 300, icon = 'hammer', metadata = { ['durability'] = 100 }, level = 2 },
                [3] = { item = 'ls_iron_shovel', price = 750, icon = 'hammer', metadata = { ['durability'] = 100 }, level = 3 },
                [4] = { item = 'ls_silver_shovel', price = 1500, icon = 'hammer', metadata = { ['durability'] = 100 }, level = 4 },
                [5] = { item = 'ls_gold_shovel', price = 3000, icon = 'hammer', metadata = { ['durability'] = 100 }, level = 5 },
                
                -- Add or remove items as you wish
            },
        },
        -- Customize the mines pawn shop
        -- This shop will buy items from players
        pawn = {
            enable = false,
            account = 'cash',
            items = {
                [1] = { item = 'ls_coal_ore', price = 2, icon = 'hand-holding-dollar' },
                [2] = { item = 'ls_copper_ore', price = 3, icon = 'hand-holding-dollar' },
                [3] = { item = 'ls_iron_ore', price = 5, icon = 'hand-holding-dollar' },
                [4] = { item = 'ls_silver_ore', price = 10, icon = 'hand-holding-dollar' },
                [5] = { item = 'ls_gold_ore', price = 20, icon = 'hand-holding-dollar' },
                [6] = { item = 'ls_copper_ingot', price = 35, icon = 'hand-holding-dollar' },
                [7] = { item = 'ls_iron_ingot', price = 60, icon = 'hand-holding-dollar'},
                [8] = { item = 'ls_silver_ingot', price = 100, icon = 'hand-holding-dollar' },
                [9] = { item = 'ls_gold_ingot', price = 175, icon = 'hand-holding-dollar' },
                -- Add or remove items as you wish
            }
        },
        -- Manage blip settings if desired
        blip = {
            enable = true, -- Enable or disable the blip for this shop
            sprite = 469, -- Sprite ID (https://docs.fivem.net/docs/game-references/blips/)
            color = 25, -- Color (https://docs.fivem.net/docs/game-references/blips/#blip-colors)
            scale = 0.8, -- Size/scale
            label = 'Farmer' -- Label
        }
    },


    ----------------------------------------------
    --           ⛏️ Build the farms
    ----------------------------------------------

    farming = {
        -- The center-most coords of the entire farming area
        center = vec3(2318.13, 5064.60, 45.71),
        -- What hours is farming allowed to happen?
        -- By default, it's 24/7, but for example - if you wish to only
        -- Allow farming during the day, set hours = { min = 6, max = 20 }
        hours = { min = 0, max = 24 },
        -- Build individual farming areas with specific farm
          
        zones = {
            [1] = {
               
                -- The models spawned in this area
                -- You can use one or more models, it will select at random for each ore spawn
                models = { 'prop_plant_fern_02a', 'prop_plant_fern_02a', 'prop_plant_fern_02a' },
                -- What level must the player be to mine these?
                level = 1,
                -- How long it takes to mine these farm (in milliseconds)
                duration = { min = 5000, max = 5000 },
                -- A table containing all possible rewards from these rocks
                -- item: the item spawn name
                -- min: the minimum amount to reward
                -- max: the maximum amount to reward
                -- chance: optional percentage chance variable
                -- (if no chance is set, it will be considered 100%)
                reward = {
                    { item = 'potato', min = 1, max = 2 },
                    -- { item = 'example_rare_item', min = 1, max = 1, chance = 5 },
                    -- Add or remove items as desired following the format above
                },
                -- How much XP is given for each (x1) ore mined?
                xp = { min = 1, max = 3 },
                -- How long after being mined do these farm respawn (in milliseconds)
                respawn = 25000,
                -- The coordinates these farm spawn at
                
                  
                
                farm = {
                    [1] = vec3(2336.77, 5113.28, 46.81),
                    [2] = vec3(2328.77, 5105.13, 46.28),
                    [3] = vec3(2321.58, 5096.61, 45.77),
                    [4] = vec3(2311.13, 5106.75, 46.79),
                    [5] = vec3(2318.32, 5114.14, 47.15),
                    [6] = vec3(2325.94, 5122.22, 47.50),
                    [7] = vec3(2313.58, 5136.05, 47.62),
                    [8] = vec3(2306.44, 5127.55, 47.19),
                    [9] = vec3(2299.11, 5119.50, 48.48),
                    [10] = vec3(2287.14, 5130.88, 50.47),
                    [11] = vec3(2293.32, 5137.03, 51.05),
                    [12] = vec3(2300.83, 5147.25, 52.23),
                
                },
            },
    
            
            [2] = {
                models = { 'prop_fib_plant_02', 'prop_fib_plant_02', 'prop_fib_plant_02' },
                level = 1,
                duration = { min = 5000, max = 5000 },
                reward = {
                    { item = 'pineapple', min = 1, max = 2 },
                },
                xp = { min = 1, max = 3 },
                respawn = 25000,
                farm = {
                    [1] = vec3(2292.45, 5068.66, 44.45),
                    [2] = vec3(2288.57, 5063.01, 45.08),
                    [3] = vec3(2280.72, 5054.54, 44.09),
                    [4] = vec3(2270.75, 5064.38, 44.40),
                    [5] = vec3(2277.03, 5071.30, 45.20),
                    [6] = vec3(2282.93, 5078.63, 46.06),
                    [7] = vec3(2268.38, 5093.56, 47.20),
                    [8] = vec3(2261.55, 5086.46, 45.95),
                    [9] = vec3(2255.15, 5080.20, 45.69),
                    [10] = vec3(2241.59, 5094.37, 48.06),
                    [11] = vec3(2247.72, 5101.00, 48.55),
                    [12] = vec3(2254.19, 5107.89, 49.57),
                }
            },
            [3] = {
                models = { 'prop_bush_med_06', 'prop_bush_med_06', 'prop_bush_med_06' },
                level = 2,
                duration = { min = 7500, max = 7500 },
                reward = {
                    { item = 'tomato', min = 1, max = 2 },
                },
                xp = { min = 2, max = 6 },
                respawn = 45000,
                farm = {
                    [1] = vec3(2208.54, 5175.69, 57.39),
                    [2] = vec3(2202.66, 5170.95, 56.72),
                    [3] = vec3(2195.70, 5164.44, 55.47),
                    [4] = vec3(2184.37, 5176.53, 56.45),
                    [5] = vec3(2190.70, 5181.18, 57.37),
                    [6] = vec3(2198.75, 5189.06, 58.47),
                    [7] = vec3(2185.72, 5195.16, 58.46),
                    [8] = vec3(2179.21, 5191.13, 57.98),
                    [9] = vec3(2172.82, 5186.89, 57.27),
                }
            },
            [4] = {
                models = { 'prop_bush_lrg_01c', 'prop_bush_lrg_01c', 'prop_bush_lrg_01c' },
                level = 3,
                duration = { min = 7500, max = 7500 },
                reward = {
                    { item = 'pumpkin', min = 1, max = 2 },
                },
                xp = { min = 3, max = 9 },
                respawn = 75000,
                farm = {
                    [1] = vec3(2178.11, 5150.93, 51.38),
                    [2] = vec3(2166.53, 5165.60, 53.02),
                    [3] = vec3(2153.42, 5178.93, 54.49),
                    [4] = vec3(2140.86, 5191.95, 55.20),
                    [5] = vec3(2128.21, 5204.89, 55.37),
                    [6] = vec3(2156.10, 5143.74, 48.62),
                    [7] = vec3(22143.67, 5156.92, 50.36),
                    [8] = vec3(2133.57, 5167.53, 51.46),
                    [9] = vec3(2121.43, 5181.19, 52.71),
                    [10] = vec3(2106.05, 5199.05, 54.02),
                    [11] = vec3(2098.04, 5180.59, 52.10),
                    [12] = vec3(2112.25, 5161.68, 49.96),
                    [13] = vec3(2126.98, 5147.14, 48.28),
                    [14] = vec3(2145.72, 5127.15, 45.77),
                    [15] = vec3(2144.07, 5156.60, 50.33),
                }
            },
            [5] = {
                models = { 'prop_plant_cane_02b', 'prop_plant_cane_02b', 'prop_plant_cane_02b' },
                level = 4,
                duration = { min = 13000, max = 13000 },
                reward = {
                    { item = 'apple', min = 1, max = 2 },
                },
                xp = { min = 4, max = 12 },
                respawn = 120000,
                farm = {
                    [1] = vec3(2049.02, 4960.69, 40.10),
                    [2] = vec3(2054.34, 4955.16, 40.10),
                    [3] = vec3(2063.06, 4946.59, 40.09),
                    [4] = vec3(2056.40, 4939.23, 40.11),
                    [5] = vec3(2050.46, 4945.29, 40.11),
                    [6] = vec3(2041.34, 4954.18, 40.07),
                    [7] = vec3(2031.31, 4944.91, 40.08),
                    [8] = vec3(2038.65, 4937.14, 40.12),
                    [9] = vec3(2046.43, 4929.13, 40.10),
                    [10] = vec3(2033.79, 4927.50, 40.10),
                    [11] = vec3(2051.32, 4913.28, 40.08),
                    [12] = vec3(2062.47, 4902.18, 40.11),
                    [13] = vec3(2064.98, 4908.37, 40.12),
                    [14] = vec3(2058.30, 4920.83, 40.09),
                    [15] = vec3(2074.50, 4907.52, 40.11),
                    [16] = vec3(2085.53, 4908.04, 40.05),
                    [17] = vec3(2079.81, 4922.08, 40.07),
                    [18] = vec3(2071.70, 4932.55, 40.10),
                    [19] = vec3(2077.57, 4934.71, 40.06),
                    [20] = vec3(2089.16, 4923.65, 40.07),
                }
            },
            -- You can add or remove zones as you wish
            -- Be sure to follow the same format as above
        }
    },

    ----------------------------------------------
    --           🔥 Setup smelting
    ----------------------------------------------

    smelting = {
        -- Where do you want the smelter to be?
        coords = vec3(1087.6827, -2002.1394, 31.4841),
        -- The types of ingots that can be smelted from farm
        ingots = {
            [1] = {
                -- The display name for this ingot in the menu
                name = 'Copper Ingot',
                -- The icon used
                icon = 'fas fa-fire',
                -- The player level required to smelt this
                level = 1,
                -- How long it takes to smelt x1 ingot (in milliseconds)
                duration = 10000,
                -- The maximum amount you can smelt in one session
                -- This is an optional feature to combat excessive AFK
                max = 20,
                -- How much XP to add for each ingot smelted?
                xp = { min = 3, max = 6 },
                -- farm/items that are required to smelt this
                required = {
                    { item = 'ls_coal_ore', quantity = 5 },
                    { item = 'ls_copper_ore', quantity = 5 },
                    -- You can add or remove additional items as desired
                },
                -- Ingots/items that are added after smelting
                add = {
                    { item = 'ls_copper_ingot', quantity = 1 },
                    -- You can add or remove additional items as desired
                },
            },
            [2] = {
                name = 'Iron Ingot',
                icon = 'fas fa-fire',
                level = 2,
                duration = 15000,
                max = 15,
                xp = { min = 4, max = 8 },
                required = {
                    { item = 'ls_coal_ore', quantity = 10 },
                    { item = 'ls_iron_ore', quantity = 5 },
                },
                add = {
                    { item = 'ls_iron_ingot', quantity = 1 },
                },
            },
            [3] = {
                name = 'Silver Ingot',
                icon = 'fas fa-fire',
                level = 3,
                duration = 20000,
                max = 10,
                xp = { min = 5, max = 10 },
                required = {
                    { item = 'ls_coal_ore', quantity = 15 },
                    { item = 'ls_silver_ore', quantity = 5 },
                },
                add = {
                    { item = 'ls_silver_ingot', quantity = 1 },
                },
            },
            [4] = {
                name = 'Gold Ingot',
                icon = 'fas fa-fire',
                level = 4,
                duration = 25000,
                max = 5,
                xp = { min = 6, max = 12 },
                required = {
                    { item = 'ls_coal_ore', quantity = 20 },
                    { item = 'ls_gold_ore', quantity = 5 },
                },
                add = {
                    { item = 'ls_gold_ingot', quantity = 1 },
                },
            },
        },
        -- Manage blip settings if desired
        blip = {
            enable = false, -- Enable or disable the blip for this area
            sprite = 648, -- Sprite ID (https://docs.fivem.net/docs/game-references/blips/)
            color = 17, -- Color (https://docs.fivem.net/docs/game-references/blips/#blip-colors)
            scale = 0.9, -- Size/scale
            label = 'Smelter' -- Label
        }
    }


}