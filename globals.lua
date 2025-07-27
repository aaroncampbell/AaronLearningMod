G.C.ADC = {
    PLUM = HEX("5E527A"),
    RED = HEX("FF0000"),
    BLACK = HEX("000000"),
    BLUE = HEX("0000FF"),
    GREEN = HEX("00FF00"),
    WHITE = HEX("FFFFFF"),
    TRANSPARENT = HEX("00000000"),
}

local loc_colour_ref = loc_colour
function loc_colour(_c, _default)
    if not G.ARGS.LOC_COLOURS then
        loc_colour_ref()
    end
    G.ARGS.LOC_COLOURS.adc_plum = G.C.ADC.PLUM
    G.ARGS.LOC_COLOURS.adc_red = G.C.ADC.RED
    G.ARGS.LOC_COLOURS.adc_black = G.C.ADC.BLACK
    G.ARGS.LOC_COLOURS.adc_blue = G.C.ADC.BLUE
    G.ARGS.LOC_COLOURS.adc_green = G.C.ADC.GREEN
    G.ARGS.LOC_COLOURS.adc_white = G.C.ADC.WHITE
    G.ARGS.LOC_COLOURS.adc_transparent = G.C.ADC.TRANSPARENT
    return loc_colour_ref(_c, _default)
end

function adc_get_logger()
    --DebugPlus
    local success, dpAPI = pcall(require, "debugplus-api")

    local logger = { -- Placeholder logger, for when DebugPlus isn't available
        log = print,
        debug = print,
        info = print,
        warn = print,
        error = print
    }

    if success and dpAPI.isVersionCompatible(1) then -- Make sure DebugPlus is available and compatible
        local debugplus = dpAPI.registerID("Example")
        logger = debugplus.logger -- Provides the logger object
    end
    return logger
end