Archipelago:AddClearHandler("clear handler", OnClear)
Archipelago:AddItemHandler("item handler", OnItem)
Archipelago:AddLocationHandler("location handler", OnLocation)

Archipelago:AddSetReplyHandler("notify handler", OnNotify)
Archipelago:AddRetrievedHandler("notify launch handler", OnNotifyLaunch)

-- Tie the original toggle items for the pig bags to their new progressive form.
local function SyncPigBagToggleToProgressive(toggle_code, progressive_code)
  local toggle_item = Tracker:FindObjectForCode(toggle_code)
  local progressive_item = Tracker:FindObjectForCode(progressive_code)

  if (not toggle_item or not progressive_item) then
    return
  end

  -- Can't be too overzealous: make sure we can still toggle the pig bag separately.
  if toggle_item.Active and progressive_item.CurrentStage == 0 then
    progressive_item.CurrentStage = 1
  end
end

-- Tie an event and item together.
local function SyncPigBagLocationEvent(state, item_code, event_code)
  local item = Tracker:FindObjectForCode(item_code)
  local event = Tracker:FindObjectForCode(event_code)
  
  if (not item or not event) then
    return
  end

  local item_changed = item.CurrentStage ~= state.last_stage
  local event_changed = event.Active ~= state.last_event_active
  
  -- Item → event
  if item_changed and item.CurrentStage == 2 then
    event.Active = true
  elseif item_changed and item.CurrentStage < 2 then
    event.Active = false
  end
  
  -- Event → item
  if event_changed and event.Active and item.CurrentStage ~= 2 then
    item.CurrentStage = 2
  elseif event_changed and not event.Active and item.CurrentStage == 2 then
    item.CurrentStage = 1
  end
  
  state.last_stage = item.CurrentStage
  state.last_event_active = event.Active
end

local red_pig_state = {
  last_stage = 0,
  last_event_active = false
}
local orange_pig_state = {
  last_stage = 0,
  last_event_active = false
}
local yellow_pig_state = {
  last_stage = 0,
  last_event_active = false
}
local green_pig_state = {
  last_stage = 0,
  last_event_active = false
}
local blue_pig_state = {
  last_stage = 0,
  last_event_active = false
}
local navy_pig_state = {
  last_stage = 0,
  last_event_active = false
}
local pink_pig_state = {
  last_stage = 0,
  last_event_active = false
}

ScriptHost:AddOnFrameHandler("sync_red_pig_phoenix", function()
  SyncPigBagLocationEvent(red_pig_state, "red_evil_pig_bag_layout", "event_phoenix_mountain")
end)
ScriptHost:AddOnFrameHandler("sync_orange_pig_baccus", function()
  SyncPigBagLocationEvent(orange_pig_state, "orange_evil_pig_bag_layout", "event_baccus_village")
end)
ScriptHost:AddOnFrameHandler("sync_yellow_pig_phoenix", function()
  SyncPigBagLocationEvent(yellow_pig_state, "yellow_evil_pig_bag_layout", "event_trick_village")
end)
ScriptHost:AddOnFrameHandler("sync_green_pig_phoenix", function()
  SyncPigBagLocationEvent(green_pig_state, "green_evil_pig_bag_layout", "event_lava_caves")
end)
ScriptHost:AddOnFrameHandler("sync_blue_pig_phoenix", function()
  SyncPigBagLocationEvent(blue_pig_state, "blue_evil_pig_bag_layout", "event_the_hundred_flower_forest")
end)
ScriptHost:AddOnFrameHandler("sync_navy_pig_phoenix", function()
  SyncPigBagLocationEvent(navy_pig_state, "navy_evil_pig_bag_layout", "event_the_deep_jungle_pig")
end)
ScriptHost:AddOnFrameHandler("sync_pink_pig_phoenix", function()
  SyncPigBagLocationEvent(pink_pig_state, "pink_evil_pig_bag_layout", "event_the_haunted_mansion")
end)

ScriptHost:AddOnFrameHandler("sync_toggle_progressive_red_pig", function()
  SyncPigBagToggleToProgressive("red_evil_pig_bag", "red_evil_pig_bag_layout")
end)
ScriptHost:AddOnFrameHandler("sync_toggle_progressive_orange_pig", function()
  SyncPigBagToggleToProgressive("orange_evil_pig_bag", "orange_evil_pig_bag_layout")
end)
ScriptHost:AddOnFrameHandler("sync_toggle_progressive_yellow_pig", function()
  SyncPigBagToggleToProgressive("yellow_evil_pig_bag", "yellow_evil_pig_bag_layout")
end)
ScriptHost:AddOnFrameHandler("sync_toggle_progressive_green_pig", function()
  SyncPigBagToggleToProgressive("green_evil_pig_bag", "green_evil_pig_bag_layout")
end)
ScriptHost:AddOnFrameHandler("sync_toggle_progressive_blue_pig", function()
  SyncPigBagToggleToProgressive("blue_evil_pig_bag", "blue_evil_pig_bag_layout")
end)
ScriptHost:AddOnFrameHandler("sync_toggle_progressive_navy_pig", function()
  SyncPigBagToggleToProgressive("navy_evil_pig_bag", "navy_evil_pig_bag_layout")
end)
ScriptHost:AddOnFrameHandler("sync_toggle_progressive_pink_pig", function()
  SyncPigBagToggleToProgressive("pink_evil_pig_bag", "pink_evil_pig_bag_layout")
end)

-- ScriptHost:AddWatchForCode("settings autofill handler", "autofill_settings", AutoFill)
