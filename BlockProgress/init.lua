dofile_once("mods/BlockProgress/persistent_flags.lua")

function OnWorldInitialized()
    GameAddFlagRun("no_progress_flags_perk")
    GameAddFlagRun("no_progress_flags_animal")
    GameAddFlagRun("no_progress_flags_action")
end

local uses_persistent_flags = {
    "data/scripts/lib/utilities.lua",
    "data/scripts/director_helpers.lua",
    "data/scripts/item_spawnlists.lua",
    "data/scripts/gun/gun_actions.lua",
    "data/scripts/game_helpers.lua",
    "data/entities/animals/boss_centipede/rewards/spawn_rewards.lua",
    "data/scripts/buildings/teleport_meditation_cube.lua",
    "data/scripts/buildings/teleport_snowcave_buried_eye.lua",
    "data/scripts/perks/perk_utilities.lua",
}

for _, file in ipairs(uses_persistent_flags) do
    ModLuaFileAppend(file, "mods/BlockProgress/load_persistent_flags.lua")
end

local has_secret_amulet_gem = real_HasFlagPersistent("secret_amulet_gem")

function OnPlayerDied(player_id)
    if not has_secret_amulet_gem then
        real_RemoveFlagPersistent("secret_amulet_gem")
    end
end

function OnWorldPreUpdate()
    dofile_once("data/scripts/gun/gun_actions.lua")
    local missing_unlocks_set = {}

    for _, action in ipairs(actions) do
        local unlock_flag = action.spawn_requires_flag
        if unlock_flag and not real_HasFlagPersistent(unlock_flag) then
            missing_unlocks_set[unlock_flag] = true
        end
    end

    local missing_unlocks = {}
    for unlock_flag, _ in pairs(missing_unlocks_set) do
        missing_unlocks[#missing_unlocks+1] = unlock_flag
    end

    table.sort(missing_unlocks)

    OnWorldPreUpdate = function()
        for _, flag in ipairs(missing_unlocks) do
            if real_HasFlagPersistent(flag) then
                real_RemoveFlagPersistent(flag)
                AddFlagPersistent(flag)
            end
        end
    end
end
