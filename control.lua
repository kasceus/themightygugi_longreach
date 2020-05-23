require "util"
require "event"

local function apply_settings()    
    local settings = settings.global  
    game.forces["player"].character_build_distance_bonus = settings["themightygugi_longreach-build-distance-bonus"]["value"]
    game.forces["player"].character_item_drop_distance_bonus = settings["themightygugi_longreach-item-drop-distance-bonus"]["value"]
    game.forces["player"].character_reach_distance_bonus = settings["themightygugi_longreach-reach-distance-bonus"]["value"]
    game.forces["player"].character_resource_reach_distance_bonus = settings["themightygugi_longreach-resource-reach-distance-bonus"]["value"]          
end

local function set_join_options(event)    
    apply_settings()

    -- an earlier version of this mod set these two settings, and causes major game lag if 1000. Ajust them to something acceptable
    if game.players[event.player_index].force_item_pickup_distance_bonus > 10 then
        game.players[event.player_index].force_item_pickup_distance_bonus = 1
    end
    if game.players[event.player_index].force_loot_pickup_distance_bonus > 10 then
        game.players[event.player_index].force_loot_pickup_distance_bonus = 1
    end   
end

function On_Init() apply_settings() end
function On_Change() apply_settings() end

script.on_init(function() On_Init() end)
script.on_configuration_changed(function() On_Change() end)
script.on_event(defines.events.on_runtime_mod_setting_changed,function () apply_settings() end)
Event.register(defines.events.on_player_joined_game, set_join_options)




    
