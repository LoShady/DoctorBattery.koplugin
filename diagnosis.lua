local _ = require("gettext")

local Diagnosis = {}

local function translate(value, dictionary)
    return dictionary[value] or value
end

--------------------------------------------------
-- Battery Score
--------------------------------------------------

local function checkScore(info, diagnosis)

    local score = 100

    -- Penalità usura
    score = score - math.floor(info.wear)

    -- Penalità cicli
    if info.cycles >= 1000 then
        score = score - 20
    elseif info.cycles >= 700 then
        score = score - 10
    elseif info.cycles >= 300 then
        score = score - 5
    end

    -- Penalità stress
    if info.stressed then
        score = score - 15
    end

    -- Penalità temperatura
    if info.temperature < 10 or info.temperature > 45 then
        score = score - 10
    elseif info.temperature > 35 then
        score = score - 5
    end

    if score < 0 then
        score = 0
    end

    local icon

    if score >= 90 then
        icon = "🟢"
    elseif score >= 75 then
        icon = "🟡"
    elseif score >= 60 then
        icon = "🟠"
    else
        icon = "🔴"
    end

    table.insert(
        diagnosis,
        string.format(_("%s Battery Score: %d/100"), icon, score)
    )

    table.insert(diagnosis, "")

end

--------------------------------------------------
-- Controllo usura
--------------------------------------------------

local function checkWear(info, diagnosis)

    if info.wear < 5 then

        table.insert(
            diagnosis,
            _("🟢 Batteria in condizioni eccellenti")
        )

    elseif info.wear < 15 then

        table.insert(
            diagnosis,
            _("🟡 Batteria in buone condizioni")
        )

    else

        table.insert(
            diagnosis,
            _("🔴 Batteria usurata")
        )

    end

end

--------------------------------------------------
-- Controllo cicli
--------------------------------------------------

local function checkCycles(info, diagnosis)

    table.insert(
        diagnosis,
        string.format(_("• Cicli di ricarica: %d"), info.cycles)
    )

    if info.cycles < 300 then

        table.insert(
            diagnosis,
            _("🟢 Batteria ancora giovane")
        )

    elseif info.cycles < 700 then

        table.insert(
            diagnosis,
            _("🟡 Usura nella norma")
        )

    elseif info.cycles < 1000 then

        table.insert(
            diagnosis,
            _("🟠 Cicli elevati")
        )

    else

        table.insert(
            diagnosis,
            _("🔴 Numero di cicli molto elevato")
        )

    end

end

--------------------------------------------------
-- Controllo capacità
--------------------------------------------------

local function checkCapacity(info, diagnosis)

    table.insert(
        diagnosis,
        string.format(
            _("• Capacità reale: %.0f / %.0f mAh"),
            info.chargeFull,
            info.chargeDesign
        )
    )

    local percent = (info.chargeFull / info.chargeDesign) * 100

    if percent >= 95 then

        table.insert(
            diagnosis,
            string.format(
                _("🟢 Capacità eccellente (%.1f%%)"),
                percent
            )
        )

    elseif percent >= 90 then

        table.insert(
            diagnosis,
            string.format(
                _("🟡 Capacità buona (%.1f%%)"),
                percent
            )
        )

    elseif percent >= 80 then

        table.insert(
            diagnosis,
            string.format(
                _("🟠 Capacità ridotta (%.1f%%)"),
                percent
            )
        )

    else

        table.insert(
            diagnosis,
            string.format(
                _("🔴 Capacità molto degradata (%.1f%%)"),
                percent
            )
        )

    end

end

--------------------------------------------------
-- Controllo temperatura
--------------------------------------------------

local function checkTemperature(info, diagnosis)

    local t = info.temperature

    if t < 0 then

        table.insert(
            diagnosis,
            string.format(_("🔴 Temperatura critica: %.1f°C"), t)
        )

    elseif t < 10 then

        table.insert(
            diagnosis,
            string.format(_("🟡 Batteria fredda (%.1f°C)"), t)
        )

    elseif t <= 35 then

        table.insert(
            diagnosis,
            string.format(_("🟢 Temperatura ottimale (%.1f°C)"), t)
        )

    elseif t <= 45 then

        table.insert(
            diagnosis,
            string.format(_("🟠 Batteria calda (%.1f°C)"), t)
        )

    else

        table.insert(
            diagnosis,
            string.format(_("🔴 Batteria molto calda (%.1f°C)"), t)
        )

    end

end

--------------------------------------------------
-- Controllo protezione ricarica
--------------------------------------------------

local function checkCharging(info, diagnosis)

    if info.safeCharging then

        table.insert(
            diagnosis,
            _("🟢 Ricarica protetta attiva")
        )

        table.insert(
            diagnosis,
            _("• Il sistema sta limitando la ricarica per preservare la durata della batteria.")
        )

    else

        table.insert(
            diagnosis,
            _("🟢 Ricarica normale")
        )

    end

end

--------------------------------------------------
-- Controllo stress
--------------------------------------------------

local function checkStress(info, diagnosis)

    if info.stressed then

        table.insert(
            diagnosis,
            _("🔴 La batteria mostra segni di stress")
        )

        table.insert(
            diagnosis,
            _("• Evita scariche complete e temperature elevate per preservarne la durata.")
        )

    else

        table.insert(
            diagnosis,
            _("🟢 Nessun segno di stress rilevato")
        )

    end

end

--------------------------------------------------
-- Analisi completa
--------------------------------------------------

function Diagnosis:analyze(info)

    --------------------------------------------------
    -- Traduzione stato
    --------------------------------------------------

    info.status = translate(info.status, {
        Discharging = _("In scarica"),
        Charging = _("In carica"),
        Full = _("Carica completa"),
        Unknown = _("Sconosciuto"),
    })

    --------------------------------------------------
    -- Traduzione salute
    --------------------------------------------------

    info.health = translate(info.health, {
        Good = _("Ottima"),
        Dead = _("Esaurita"),
        Overheat = _("Surriscaldata"),
        Cold = _("Troppo fredda"),
        Unknown = _("Sconosciuta"),
    })

    --------------------------------------------------
    -- Diagnosi
    --------------------------------------------------

    local diagnosis = {}

    checkScore(info, diagnosis)
    checkWear(info, diagnosis)
    checkCycles(info, diagnosis)
    checkCapacity(info, diagnosis)
    checkTemperature(info, diagnosis)
    checkCharging(info, diagnosis)
    checkStress(info, diagnosis)

    info.diagnosis = table.concat(diagnosis, "\n")

    return info

end

return Diagnosis