require("doctorbattery_l10n").install()

local Diagnosis = require("diagnosis")
local Battery = require("battery")

local WidgetContainer = require("ui/widget/container/widgetcontainer")
local UIManager = require("ui/uimanager")
local InfoMessage = require("ui/widget/infomessage")
local ButtonDialog = require("ui/widget/buttondialog")

local _ = require("gettext")
local DoctorBattery = WidgetContainer:extend{
    name = "doctorbattery",
}

-- Forward declaration
local showMainMenu

----------------------------------------------------------
-- PAGINA 1 - RIEPILOGO
----------------------------------------------------------

local function buildSummary(info)

    return string.format(

        _("🩺 DoctorBattery\n" ..
        "━━━━━━━━━━━━━━━━\n\n" ..

        "📋 STATO BATTERIA\n\n" ..

        "🔋 Carica: %d%%\n" ..
        "❤️ Salute: %s\n" ..
        "⚡ Stato: %s\n" ..
        "🔄 Cicli di ricarica: %d"),

        info.capacity,
        info.health,
        info.status,
        info.cycles
    )
end

----------------------------------------------------------
-- PAGINA 2 - DIAGNOSI
----------------------------------------------------------

local function buildDiagnosis(info)

    return
        _("🩺 DoctorBattery\n" ..
        "━━━━━━━━━━━━━━━━\n\n" ..
        "🩺 DIAGNOSI\n\n") ..
        info.diagnosis
end

----------------------------------------------------------
-- PAGINA 3 - PARAMETRI TECNICI
----------------------------------------------------------

local function buildTechnical(info)

    return string.format(

        _("🩺 DoctorBattery\n" ..
        "━━━━━━━━━━━━━━━━\n\n" ..

        "⚙️ PARAMETRI ELETTRICI\n\n" ..

        "🌡️ Temperatura: %d °C\n" ..
        "🔌 Tensione attuale: %.3f V\n" ..
        "⬆️ Tensione massima: %.3f V\n" ..
        "⬇️ Tensione minima: %.3f V\n\n" ..

        "⚡ Corrente attuale: %.1f mA\n" ..
        "📊 Corrente media: %.1f mA\n" ..
        "⬆️ Corrente massima: %.0f mA\n\n" ..

        "🔋 Capacità attuale: %.0f mAh\n" ..
        "📈 Capacità reale: %.0f mAh\n" ..
        "🏭 Capacità progetto: %.0f mAh\n" ..
        "📦 Gauge stimato: %.0f mAh\n\n" ..

        "📉 Usura: %.1f%%\n" ..
        "🛡️ Parametri sicuri: %s\n" ..
        "⚠️ Stress: %s"),

        info.temperature,
        info.voltage,
        info.voltageMax,
        info.voltageMin,

        info.current,
        info.currentAvg,
        info.currentMax,

        info.chargeNow,
        info.chargeFull,
        info.chargeDesign,
        info.batteryMah,

        info.wear,
        info.safeCharging and _("Attiva") or _("Non attiva"),
        info.stressed and _("Presente") or _("Assente")
    )
end

----------------------------------------------------------
-- PAGINA 4 - INFORMAZIONI
----------------------------------------------------------

local function buildInfo()

    return
        _("🩺 DoctorBattery\n" ..
        "━━━━━━━━━━━━━━━━\n\n" ..

        "ℹ️ INFORMAZIONI\n\n" ..

        "DoctorBattery analizza lo stato della batteria\n" ..
        "utilizzando i dati esposti dal sistema del Kindle.\n\n" ..

        "Le valutazioni sono stime e non sostituiscono\n" ..
        "gli strumenti diagnostici del produttore.\n\n" ..

        "Sviluppato per KOReader.\n" ..
        "By Lo Shady")
end

----------------------------------------------------------
-- APERTURA PAGINE
----------------------------------------------------------

local function showPage(title, text, info)

    UIManager:show(
        InfoMessage:new{
            title = title,
            text = text,
            dismiss_callback = function()
                showMainMenu(info)
            end,
        }
    )

end

----------------------------------------------------------
-- MENU PRINCIPALE
----------------------------------------------------------

showMainMenu = function(info)

    local dialog

    dialog = ButtonDialog:new{

        title = _("🩺 DoctorBattery"),

        buttons = {

            {
                {
                    text = _("📋 Riepilogo"),
                    callback = function()
                        UIManager:close(dialog)
                        showPage(_("Riepilogo"), buildSummary(info), info)
                    end,
                },
            },

            {
                {
                    text = _("🩺 Diagnosi"),
                    callback = function()
                        UIManager:close(dialog)
                        showPage(_("Diagnosi"), buildDiagnosis(info), info)
                    end,
                },
            },

            {
                {
                    text = _("⚙️ Parametri tecnici"),
                    callback = function()
                        UIManager:close(dialog)
                        showPage(_("Parametri tecnici"), buildTechnical(info), info)
                    end,
                },
            },

            {
                {
                    text = _("ℹ️ Informazioni"),
                    callback = function()
                        UIManager:close(dialog)
                        showPage(_("Informazioni"), buildInfo(), info)
                    end,
                },
            },

            {
                {
                    text = _("❌ Chiudi"),
                    callback = function()
                        UIManager:close(dialog)
                    end,
                },
            },

        },
    }

    UIManager:show(dialog)

end

----------------------------------------------------------
-- INIZIALIZZAZIONE PLUGIN
----------------------------------------------------------

function DoctorBattery:init()
    self.ui.menu:registerToMainMenu(self)
end

----------------------------------------------------------
-- MENU KOREADER
----------------------------------------------------------

function DoctorBattery:addToMainMenu(menu_items)

    menu_items.doctorbattery = {

        text = _("DoctorBattery"),
        sorting_hint = "tools",

        callback = function()

    local info = Battery:getInfo()
    info = Diagnosis:analyze(info)

    showMainMenu(info)

end,

    }

end

----------------------------------------------------------
-- FINE FILE
----------------------------------------------------------

return DoctorBattery