#!/bin/sh

./rebar clean compile

erl -sname word-ladder -pa ebin
