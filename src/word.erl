-module(word).
-behaviour(gen_event).
-define(SERVER, ?MODULE).

-export([init/1, handle_event/2, handle_call/2, handle_info/2, terminate/2, code_change/3]).

init(Word) ->
    {ok, Word}.

handle_event({lookup, Word, History, Word}, Word) ->
    io:format("FOUND ONE! ~w~n", [lists:reverse([Word | History])]),
    {ok, Word};
handle_event({lookup, Word, History, Goal}, Word) ->
    erlang:spawn(word_builder, build, [Word, [Word | History], Goal]),
    {ok, Word};
handle_event(_Event, State) ->
    {ok, State}.

handle_call(_Request, State) ->
    Reply = ok,
    {ok, Reply, State}.

handle_info(_Info, State) ->
    {ok, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.
