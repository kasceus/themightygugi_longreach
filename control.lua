require "util"
require "event"

local userSetBuildDistance = 0
local userDropDistanceBonus = 0
local userReachDistanceBonus = 0
local userResourceReachDistanceBonus = 0

local var_check
local apply_settings
local get_user_settings

get_user_settings =  function()
    --game.print("get user settings")
    local settings = settings.global
    userSetBuildDistance =settings["themightygugi_longreach-build-distance-bonus"]["value"]
    userDropDistanceBonus = settings["themightygugi_longreach-item-drop-distance-bonus"]["value"]
    userReachDistanceBonus = settings["themightygugi_longreach-reach-distance-bonus"]["value"]
    userResourceReachDistanceBonus = settings["themightygugi_longreach-resource-reach-distance-bonus"]["value"]  

    if userSetBuildDistance == nil then userSetBuildDistance = 1 end
    if userDropDistanceBonus == nil then userDropDistanceBonus = 1 end
    if userReachDistanceBonus == nil then userReachDistanceBonus = 1 end
    if userResourceReachDistanceBonus == nil then userResourceReachDistanceBonus = 1 end
end

var_check = function ()
    if userSetBuildDistance == nil or userSetBuildDistance == 0 then get_user_settings() end
end
local function apply_settings()    
    --game.print("apply settings")
    var_check()
    --game.print("user reach distance = "  .. userReachDistanceBonus)
    game.forces["player"].character_build_distance_bonus = userSetBuildDistance
    game.forces["player"].character_item_drop_distance_bonus = userDropDistanceBonus
    game.forces["player"].character_reach_distance_bonus = userReachDistanceBonus
    game.forces["player"].character_resource_reach_distance_bonus = userResourceReachDistanceBonus          
end

local function update_settings()
    --game.print("update settings")
    get_user_settings()
    apply_settings()
end
local function apply_defaults()
    game.forces["player"].character_build_distance_bonus = 1000
    game.forces["player"].character_item_drop_distance_bonus = 1000
    game.forces["player"].character_reach_distance_bonus = 1000
    game.forces["player"].character_resource_reach_distance_bonus = 1000
end

local function set_join_options(event)    
    --game.print("set join options")
    if userDropDistanceBonus == 0 and userReachDistanceBonus == 0 and userResourceReachDistanceBonus == 0 then
        apply_defaults()
    else
        apply_settings()
    end

end
function On_Init() get_user_settings() apply_settings() end
function On_Change()  apply_settings() end

script.on_init(function()
    global = global or {} -- Ensure `global` is initialized before calling On_Init
    On_Init()
end)

script.on_configuration_changed(function() On_Change() end)
script.on_event(defines.events.on_runtime_mod_setting_changed,function ()  update_settings()  end)
Event.register(defines.events.on_player_joined_game, set_join_options)




    
