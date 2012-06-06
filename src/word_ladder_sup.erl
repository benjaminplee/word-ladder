-module(word_ladder_sup).
-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1, lookup_word/3, add_word/1]).

-define(CHILD(I, Type, Arg), {I, {I, start_link, [Arg]}, permanent, 5000, Type, [I]}).
-define(DICTIONARY_EVENT_MGR, {global, dictionary_event_mgr}).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

lookup_word(Word, History, Goal) ->
  gen_event:notify(?DICTIONARY_EVENT_MGR, {lookup, Word, History, Goal}).

add_word(Word) ->
  gen_event:add_handler(?DICTIONARY_EVENT_MGR, word, Word).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
  {ok, { {one_for_one, 5, 10}, [?CHILD(gen_event, worker, ?DICTIONARY_EVENT_MGR)]} }.
