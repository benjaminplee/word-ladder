word-ladder
===========

basic idea:

Gen-Event-Manager (for words that exist)
Gen-Events for each valid word in dictionary as state
  if incoming event matches state
  spawn new process to handle word

initialize: add all words from file as event handlers

Find-Ladder call to look
  trigger event for start word with it as history as nothing

Link module
  if word = goal word, print
  otherwise
  needs to spawn event for switching every letter in the word
  with all other characters possible (ascii #)

SCREW TESTING AND SUPERVISION TREES (for now)

cat /usr/share/dict/words | grep -e '^....$' > four_letter_words.txt
