if not GLOBAL.TheNet:GetIsServer() then
    return
end

local daystoturn = GetModConfigData("daystoturn") * 480
local turntowhich = GetModConfigData("turntowhich")

local function OnDropped(inst)
    if inst.components.inventoryitem and inst.components.inventoryitem.owner == nil then
        if inst.turntask == nil then
            inst.turntask = inst:DoTaskInTime(10, function(inst)
                local x, y, z = inst.Transform:GetWorldPosition()
                inst:Remove()
                GLOBAL.SpawnPrefab(turntowhich).Transform:SetPosition(x, y, z)
            end)
        end
    end
end

local function OnPickup(inst)
    if inst.turntask ~= nil then
        inst.turntask:Cancel()
        inst.turntask = nil
    end
end

local function Turn2Flower(inst)
    inst:ListenForEvent("ondropped", OnDropped)
    if inst.components and inst.components.inventoryitem then
        inst.components.inventoryitem:SetOnPutInInventoryFn(OnPickup)
    end
    OnDropped(inst)
end

AddPrefabPostInit("abigail_flower", Turn2Flower)