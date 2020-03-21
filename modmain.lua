if not GLOBAL.TheNet:GetIsServer() then
    return
end

local GROUND = GLOBAL.GROUND

local daystoturn = 10 --GetModConfigData("daystoturn") * 480
local turntowhich = GetModConfigData("turntowhich")

local function CheckTile(tile)
    local available_tiles = {
        GROUND.GRASS,           --Grass Turf
        GROUND.FOREST,          --Forest Turf
        GROUND.SAVANNA,         --Savanna Turf
        GROUND.CAVE,            --Guano Turf
        GROUND.FUNGUS,          --Blue Fungal Turf
        GROUND.FUNGUS_RED,      --Red Fungal Turf
        GROUND.FUNGUS_GREEN,    --Green Fungal Turf
        GROUND.SINKHOLE,        --Slimey Turf
        GROUND.MUD,             --Mud Turf
    }
    for k,v in pairs(available_tiles) do
        if tile == v then
            return true
        end
    end
    return false
end

local  function OnDropped(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local tile = GLOBAL.TheWorld.Map:GetTileAtPoint(x, y, z)
    if CheckTile(tile) then
        inst.components.timer:StartTimer("turntoflower", daystoturn)
    end
end

local function OnPickup(inst)
    inst.components.timer:StopTimer("turntoflower")
end

local function OnTimerDone(inst)
    if inst.components.inventoryitem and inst.components.inventoryitem.owner == nil then
        local x, y, z = inst.Transform:GetWorldPosition()
        inst:Remove()
        GLOBAL.SpawnPrefab(turntowhich).Transform:SetPosition(x, y, z)
    end
end

local function Turn2Flower(inst)
    inst:AddComponent("timer")
    inst:ListenForEvent("ondropped", OnDropped)
    if inst.components and inst.components.inventoryitem then
        inst.components.inventoryitem:SetOnPutInInventoryFn(OnPickup)
        if inst.components.inventoryitem.owner == nil then
            local x, y, z = inst.Transform:GetWorldPosition()
            local tile = GLOBAL.TheWorld.Map:GetTileAtPoint(x, y, z)
            if CheckTile(tile) then
                inst.components.timer:StartTimer("turntoflower", daystoturn)
            end
        end
    end
    inst:ListenForEvent("timerdone", OnTimerDone)
end

AddPrefabPostInit("abigail_flower", Turn2Flower)

if GetModConfigData("evilflowerprotection") then

    AddPrefabPostInit("flower_evil", function(inst)
        if inst.components.pickable then
            inst:RemoveComponent("pickable")
        end
        if inst.components.burnable then
            inst.components.burnable.canlight = false
        end
        inst:AddTag("fireimmune")

        local function dig_up(inst, worker)
            inst.components.lootdropper:SpawnLootPrefab("petals_evil")
            if worker.components.sanity then
                worker.components.sanity:DoDelta(-GLOBAL.TUNING.SANITY_TINY)
            end
            inst:Remove()
        end

        inst:AddComponent("lootdropper")
        inst:AddComponent("workable")
        inst.components.workable:SetWorkAction(GLOBAL.ACTIONS.DIG)
        inst.components.workable:SetOnFinishCallback(dig_up)
        inst.components.workable:SetWorkLeft(3)
    end)
    
end