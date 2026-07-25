ENABLE_DEBUG_LOG = true

local variant = Tracker.ActiveVariantUID

print("-- Tomba! Tracker --")
print("Loaded variant: ", variant)
if ENABLE_DEBUG_LOG then
    print("Debug logging is enabled!")
end

Tracker:AddItems("items/items.json")
Tracker:AddItems("items/events.json")

Tracker:AddMaps("maps/maps.json")

-- Layout
Tracker:AddLayouts("layouts/areas.json")
Tracker:AddLayouts("layouts/events.json")
Tracker:AddLayouts("layouts/items.json")
