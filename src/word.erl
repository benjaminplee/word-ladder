-module(word).
-compile([export_all]).

establish(Word) ->
  gproc:reg({n, l, Word}),
  loop(),
  ok.

loop() ->
  receive
    {Link, Chain, Link} ->
      io:format("Solution! ~p~n", [Chain]),
      exit("Found a solution"),
      ok;
    {Link, Chain, Goal} when length(Chain) < 10 ->
      find_next_link(Link, Chain, Goal),
      loop()
  end.

find_next_link(Link, Chain, Goal) ->
  case contains_count(Link, Chain) of
      1 ->
        %io:format("Chain: ~p~n", [Chain]),
        characters([], Link, Chain, Goal);
      _ ->
        noop
  end.

contains_count(X, Xs) ->
  lists:foldl(fun(Y, Sum) -> 
        case (Y == X) of
          true -> 
            Sum + 1; 
          false -> 
            Sum 
        end 
    end, 0, Xs).

%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
  catch gproc:send({n, l, Candidate}, {Candidate, [Candidate | History], Goal}),
  candidate(Alt + 1, Prefix, Letter, Suffix, History, Goal).
