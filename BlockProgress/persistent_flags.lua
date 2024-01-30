-- If a mod is affected by ours but wants to overrule us for whatever reason,
-- it can use
-- `local real_HasFlagPersistent = real_HasFlagPersistent or HasFlagPersistent`
-- in the relevant places.

real_HasFlagPersistent = HasFlagPersistent
real_AddFlagPersistent = AddFlagPersistent
real_RemoveFlagPersistent = RemoveFlagPersistent

local function as_run_flag(flag_name)
    return "block_progress_" .. flag_name
end

function HasFlagPersistent(flag)
    local run_flag = as_run_flag(flag)
    return not GameHasFlagRun("NOT_" .. run_flag) and
        (GameHasFlagRun(run_flag) or real_HasFlagPersistent(flag))
end

function AddFlagPersistent(flag)
    local has_flag = HasFlagPersistent(flag)
    if has_flag then
        return false
    end

    flag = as_run_flag(flag)
    GameAddFlagRun(flag)
    GameRemoveFlagRun("NOT_" .. flag)
    return true
end

function RemoveFlagPersistent(flag)
    flag = as_run_flag(flag)
    GameRemoveFlagRun(flag)
    GameAddFlagRun("NOT_" .. flag)
end
