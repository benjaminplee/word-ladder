-module(word_ladder_app).
-compile([export_all]).

start() ->
  application:start(sasl),
  application:start(gproc),
  initialize("four_letter_words.txt"),
  ok.

initialize(FileName) ->
  [spawn_process(X) || X <- readlines(FileName)],
  ok.

spawn_process(Word) ->
  ok.

%find(StartWord, EndWord) ->
  %word_ladder_sup:lookup_word(StartWord, [], EndWord).

readlines(FileName) ->
  {ok, Device} = file:open(FileName, [read]),
  get_all_lines(Device, []).

get_all_lines(Device, Accum) ->
  case io:get_line(Device, "") of
    eof  -> file:close(Device), [lists:filter(fun(10) -> false; (_) -> true end, Line) || Line <- Accum];
    Line -> get_all_lines(Device, [Line | Accum])
  end.
