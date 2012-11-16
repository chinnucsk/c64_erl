-module(rom).

-export([load/3]).

load(Address, RomFileName, Binary) ->
    RomBinary = load_file(RomFileName),
    NrOfBytes = byte_size(RomBinary),
    RamSize = byte_size(Binary),

    Left = binary:part(Binary, 0, Address),
    Pos = Address + NrOfBytes,
    Right = binary:part(Binary, Pos, RamSize - Pos),

    Result = <<Left/binary, RomBinary/binary, Right/binary>>,
    lager:info("load ROM: '~s' at ~s", [RomFileName, byte:hex(Address)]),
    Result.



load_file(RomFileName) ->
    RomPath = path(RomFileName),
    {ok, Binary} = file:read_file(RomPath),
    Binary.

path(FileName) ->
    filename:join(["priv", "rom", FileName]).
