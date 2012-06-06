-module(word_builder).
-compile([export_all]).

build(Word, History, Goal) ->
  case lists:foldl(fun(X, Sum) -> 
                     case (X == Word) of
                       true -> 
                         Sum + 1; 
                       false -> 
                         Sum 
                     end 
                   end, 0, History) of
    1 ->
      %io:format("New link  ~p ~p ~p ~p~n", [Word, History, Goal, self()]),
      characters([], Word, History, Goal);
    _ ->
      noop
  end,
  ok.

characters(_Prefix, [], _History, _Goal) ->
  ok;
characters(Prefix, [H | T], History, Goal) ->
  candidate(Prefix, H, T, History, Goal),
  characters(Prefix ++ [H], T, History, Goal).

candidate(Prefix, Letter, Suffix, History, Goal) ->
  candidate($a, Prefix, Letter, Suffix, History, Goal).

candidate(123, _Prefix, _Letter, _Suffix, _History, _Goal) ->
  ok;
candidate(Letter, Prefix, Letter, Suffix, History, Goal) ->
  candidate(Letter + 1, Prefix, Letter, Suffix, History, Goal);
candidate(Alt, Prefix, Letter, Suffix, History, Goal) ->
  Candidate = Prefix ++ [Alt | Suffix],
  word_ladder_sup:lookup_word(Candidate, History, Goal),
  %io:format("candidate: ~p | ~p | ~p~n", [Candidate, History, Goal]),
  candidate(Alt + 1, Prefix, Letter, Suffix, History, Goal).

