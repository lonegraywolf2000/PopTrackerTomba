-- Tracker:AddLayouts("layouts/settings_popup.json") -- Not ready for this one yet.
Tracker:AddLayouts("layouts/items.json")
Tracker:AddLayouts("layouts/events.json")
if not IS_ITEMS_ONLY then
    Tracker:AddLayouts("layouts/tabs.json")
end
Tracker:AddLayouts("layouts/tracker.json")
if IS_VERTICAL_BROADCAST then
    Tracker:AddLayouts("layouts/broadcast-vertical.json")
else
    Tracker:AddLayouts("layouts/broadcast.json")
end
