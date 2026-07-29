local Battery = {}

local BASE = "/sys/class/power_supply/bd71827_bat/"

local function readFile(name)
    local file = io.open(BASE .. name, "r")
    if not file then
        return nil
    end

    local value = file:read("*all")
    file:close()

    if value then
        value = value:gsub("%s+", "")
    end

    return value
end

local function number(name)
    return tonumber(readFile(name) or "0")
end

function Battery:getInfo()

    local info = {}

    --------------------------------------------------
    -- Percentuale batteria
    --------------------------------------------------

    info.capacity = number("capacity")

    --------------------------------------------------
    -- Stato
    --------------------------------------------------

    info.status = readFile("status") or "Unknown"

    --------------------------------------------------
    -- Salute
    --------------------------------------------------

    info.health = readFile("health") or "Unknown"

    --------------------------------------------------
    -- Temperatura (°C)
    --------------------------------------------------

    info.temperature = number("temp")

    --------------------------------------------------
    -- Tensione (Volt)
    --------------------------------------------------

    info.voltage = number("voltage_now") / 1000000
    info.voltageMax = number("voltage_max") / 1000000
    info.voltageMin = number("voltage_min") / 1000000

    --------------------------------------------------
    -- Corrente (mA)
    --------------------------------------------------

    info.current = number("current_now") / 1000
    info.currentAvg = number("current_avg") / 1000
    info.currentMax = number("current_max") / 1000

    --------------------------------------------------
    -- Capacità (mAh)
    --------------------------------------------------

    info.chargeNow = number("charge_now") / 1000
    info.chargeFull = number("charge_full") / 1000
    info.chargeDesign = number("charge_full_design") / 1000

    -- Capacità stimata dal fuel gauge
    info.batteryMah = number("battery_mah")

    --------------------------------------------------
    -- Cicli
    --------------------------------------------------

    info.cycles = number("battery_cycle")

    --------------------------------------------------
    -- Protezioni
    --------------------------------------------------

    info.safeCharging = number("battery_safe_charging") == 1
    info.stressed = number("battery_stressed") == 1

    --------------------------------------------------
    -- Usura
    --------------------------------------------------

    if info.chargeDesign > 0 then
        info.wear = 100 - (info.chargeFull / info.chargeDesign * 100)

        if info.wear < 0 then
            info.wear = 0
        end
    else
        info.wear = 0
    end

    return info
end

return Battery