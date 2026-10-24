-- Rule functions for Tomba! Archipelago tracker
-- These correspond to the Rules class in ap-tomba/worlds/tomba/helpers.py

-- Can equip grapple/grapplejack to climb
function CanGrapple()
    local grapple = Tracker:FindObjectForCode("grapple")
    local grapplejack = Tracker:FindObjectForCode("grapplejack")
    return (grapple and grapple.Active) or (grapplejack and grapplejack.Active)
end

-- Can swim (event cleared or have sacred fish)
function CanSwim()
    local eventCleared = Tracker:FindObjectForCode("event_i_cant_swim")
    local sacredFish = Tracker:FindObjectForCode("sacred_fish")
    return (eventCleared and eventCleared.Active) or (sacredFish and sacredFish.Active)
end

-- Can dive underwater
function CanDive()
    local event = Tracker:FindObjectForCode("event_whats_underwater")
    return event and event.Active
end

-- Can dash (event cleared or have sacred fish)
function CanDash()
    local eventCleared = Tracker:FindObjectForCode("event_a_hungry_monkey")
    local sacredFish = Tracker:FindObjectForCode("sacred_fish")
    return (eventCleared and eventCleared.Active) or (sacredFish and sacredFish.Active)
end

-- Have any level 1 pants (flash, dashing, or jumping)
function HasPantsLevel1()
    local flashPants = Tracker:FindObjectForCode("flash_pants")
    local dashingPants = Tracker:FindObjectForCode("dashing_pants")
    local jumpingPants = Tracker:FindObjectForCode("jumping_pants")
    return (flashPants and flashPants.Active) or (dashingPants and dashingPants.Active) or (jumpingPants and jumpingPants.Active)
end

-- Have level 2 pants (flash or dashing)
function HasPantsLevel2()
    local flashPants = Tracker:FindObjectForCode("flash_pants")
    local dashingPants = Tracker:FindObjectForCode("dashing_pants")
    return (flashPants and flashPants.Active) or (dashingPants and dashingPants.Active)
end

-- Have level 3 pants (flash only)
function HasPantsLevel3()
    local flashPants = Tracker:FindObjectForCode("flash_pants")
    return flashPants and flashPants.Active
end

-- Have any fish (sacred or psychic)
function HasAnyFish()
    local sacredFish = Tracker:FindObjectForCode("sacred_fish")
    local psychicFish = Tracker:FindObjectForCode("psychic_fish")
    return (sacredFish and sacredFish.Active) or (psychicFish and psychicFish.Active)
end

-- Have any jewel (fire, water, or wind)
function HasAnyJewel()
    local jewelFire = Tracker:FindObjectForCode("jewel_of_fire")
    local jewelWater = Tracker:FindObjectForCode("jewel_of_water")
    local jewelWind = Tracker:FindObjectForCode("jewel_of_wind")
    return (jewelFire and jewelFire.Active) or (jewelWater and jewelWater.Active) or (jewelWind and jewelWind.Active)
end

-- Can break light objects (blackjack or wood boomerang)
function CanLightBreakStuff()
    local blackjack = Tracker:FindObjectForCode("blackjack")
    local woodBoomerang = Tracker:FindObjectForCode("wood_boomerang")
    return (blackjack and blackjack.Active) or (woodBoomerang and woodBoomerang.Active)
end

-- Can break stuff (multiple options with boomerangs and jewels)
function CanBreakStuff()
    -- Light stuff
    if CanLightBreakStuff() then return true end
    
    -- Heavy stuff
    local stoneBoomerang = Tracker:FindObjectForCode("stone_boomerang")
    local ironBoomerang = Tracker:FindObjectForCode("iron_boomerang")
    local grapplejack = Tracker:FindObjectForCode("grapplejack")
    local jewelFire = Tracker:FindObjectForCode("jewel_of_fire")
    local jewelWater = Tracker:FindObjectForCode("jewel_of_water")
    
    return (stoneBoomerang and stoneBoomerang.Active) or (ironBoomerang and ironBoomerang.Active) or
           (grapplejack and grapplejack.Active) or (jewelFire and jewelFire.Active) or
           (jewelWater and jewelWater.Active)
end

-- Can do a big jump (event cleared, level 1 pants, any fish, or blue powder)
function CanBigJump()
    local eventCleared = Tracker:FindObjectForCode("event_a_hungry_monkey")
    local bluePowder = Tracker:FindObjectForCode("blue_powder")
    
    return (eventCleared and eventCleared.Active) or HasPantsLevel1() or HasAnyFish() or (bluePowder and bluePowder.Active)
end

-- Can do the biggest jump (complex rule with multiple options)
-- Option 1: Event AND (level 1 pants OR fire jewel OR water jewel)
-- Option 2: Wind jewel
-- Option 3: Any fish
-- Option 4: Blue powder
function CanBiggestJump()
    local eventCleared = Tracker:FindObjectForCode("event_a_hungry_monkey")
    local jewelWind = Tracker:FindObjectForCode("jewel_of_wind")
    local bluePowder = Tracker:FindObjectForCode("blue_powder")
    
    if jewelWind and jewelWind.Active then return true end
    if HasAnyFish() then return true end
    if bluePowder and bluePowder.Active then return true end
    
    -- Event AND (level 1 pants OR fire/water jewel)
    if eventCleared and eventCleared.Active then
        local jewelFire = Tracker:FindObjectForCode("jewel_of_fire")
        local jewelWater = Tracker:FindObjectForCode("jewel_of_water")
        return HasPantsLevel1() or (jewelFire and jewelFire.Active) or (jewelWater and jewelWater.Active)
    end
    
    return false
end

-- Can reach mushroom forest (phoenix mountain event started)
function CanReachMushroomForest()
    local event = Tracker:FindObjectForCode("event_to_phoenix_mountain")
    return event and event.Active
end

-- Have blue powder and can reach mushroom forest
function HasBluePowder()
    local bluePowder = Tracker:FindObjectForCode("blue_powder")
    return (bluePowder and bluePowder.Active) and CanReachMushroomForest()
end

-- Can access crystal balls location (complex multi-option OR)
function CanAccessCrystalBalls()
    -- Option 1: Can big jump
    if CanBigJump() then return true end
    
    -- Option 2: Any breakable tool
    local woodBoomerang = Tracker:FindObjectForCode("wood_boomerang")
    local stoneBoomerang = Tracker:FindObjectForCode("stone_boomerang")
    local ironBoomerang = Tracker:FindObjectForCode("iron_boomerang")
    local funkyParasol = Tracker:FindObjectForCode("funky_parasol")
    
    if (woodBoomerang and woodBoomerang.Active) or (stoneBoomerang and stoneBoomerang.Active) or
       (ironBoomerang and ironBoomerang.Active) or (funkyParasol and funkyParasol.Active) then
        return true
    end
    
    -- Option 3: Any jewel
    return HasAnyJewel()
end

-- Can grapple or use parasol
function CanGrappleOrParasol()
    local funkyParasol = Tracker:FindObjectForCode("funky_parasol")
    return CanGrapple() or (funkyParasol and funkyParasol.Active)
end