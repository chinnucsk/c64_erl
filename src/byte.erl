-module(byte).

-export([hex/1, get/2, set/3]).

hex(Byte)
  when is_integer(Byte) ->
    integer_to_list(Byte, 16).

get(Nth, Binary)
  when is_integer(Nth), Nth >= 0,
       is_binary(Binary) ->
    <<Byte>> = binary:part(Binary, Nth, 1),
    Byte.

set(Nth, Byte, Binary)
  when is_integer(Nth), Nth >= 0,
       is_integer(Byte), Byte < 256, Byte >= 0,
       is_binary(Binary) ->
    Left = binary:part(Binary, 0, Nth),
    Pos = Nth + 1,
    Right = binary:part(Binary, Pos, byte_size(Binary) - Pos),
    <<Left/binary, Byte, Right/binary>>.
