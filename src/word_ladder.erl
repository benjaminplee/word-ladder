-module(word_ladder).
-compile([export_all]).

start() ->
  application:start(sasl),
  application:start(word_ladder),
  initialize("four_letter_words.txt"),
  find("cold", "warm"),
  ok.

initialize(FileName) ->
  [word_ladder_sup:add_word(X) || X <- readlines(FileName)],
  ok.

find(StartWord, EndWord) ->
  word_ladder_sup:lookup_word(StartWord, [], EndWord).

readlines(FileName) ->
  {ok, Device} = file:open(FileName, [read]),
  get_all_lines(Device, []).

get_all_lines(Device, Accum) ->
  case io:get_line(Device, "") of
    eof  -> file:close(Device), [lists:filter(fun(10) -> false; (_) -> true end, Line) || Line <- Accum];
    Line -> get_all_lines(Device, [Line | Accum])
  end.
