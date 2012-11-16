-module(c64).

-compile([export_all]).

-define(BYTE, integer-unit:8).

start() ->
    lager:start(),
    lager:set_loglevel(lager_console_backend, info),

    Ram = initize_ram(),
    Ram1 = rom:load(16#a000, "basic.rom", Ram),
    Ram2 = rom:load(16#e000, "kernal.rom", Ram1),
    binpp:pprint(Ram2).

initize_ram() ->
    Ram = <<0:16#10000/?BYTE>>,
    lager:info("init RAM: ok"),
    Ram.
