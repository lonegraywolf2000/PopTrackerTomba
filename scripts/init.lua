local variant = Tracker.ActiveVariantUID

IS_ITEMS_ONLY = variant:find("itemsonly")

IS_VERTICAL_BROADCAST = variant:find("_vb")

-- Items
require("scripts.items_import")

-- Logic
require("scripts.logic.logic_helper")
require("scripts.logic.base_logic")
require("scripts.logic.graph_logic.logic_main")

if not IS_ITEMS_ONLY then
    -- Maps
    Tracker:AddMaps("maps/maps.json")
    -- Locations
    require("scripts.locations_import")
end

-- Layout
require("scripts.layouts_import")

-- AutoTracking for PopTracker
if PopVersion and PopVersion >= "0.26.0" then
    require("scripts.autotracking")
end

function OnFrameHandler()
    ScriptHost:RemoveOnFrameHandler("load handler")
    -- stuff
    ScriptHost:AddWatchForCode("StateChanged", "*", StateChanged)
    ScriptHost:AddOnLocationSectionChangedHandler("location_section_change_handler", LocationHandler)
    CreateLuaManualStorageItem("manual_location_storage")
    ForceUpdate()
end
require("scripts.luaitems")
require("scripts.watches")
ScriptHost:AddOnFrameHandler("load handler", OnFrameHandler)