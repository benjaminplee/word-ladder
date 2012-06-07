-module(word_ladder_app).
-compile([export_all]).

start() ->
  application:start(gproc),
  ok.

initialize() ->
  initialize("four_letter_words.txt").

initialize(FileName) ->
  {ok, Device} = file:open(FileName, [read]),
  establish_words(Device),
  ok.

find() ->
  find("cold", "warm").

find(Start, End) ->
  io:format("Finding ladder from [~p] to [~p]...~n", [Start, End]),
  gproc:send({n, l, End}, {End, [End], Start}),
  ok.

establish_words(Device) ->
  case io:get_line(Device, "") of
    eof  -> file:close(Device);
    Line -> erlang:spawn_link(word, establish, [strip_line_ending(Line)]), establish_words(Device)
  end.

strip_line_ending(Line) ->
  lists:filter(fun(X) -> X =/= 10 end, Line).
