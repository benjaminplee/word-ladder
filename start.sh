#!/bin/sh

./rebar get-deps clean compile

erl -sname word-ladder -pa ebin -pa deps/*/ebin
