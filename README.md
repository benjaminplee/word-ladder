word-ladder
===========

http://en.wikipedia.org/wiki/Word_ladder

implementation creates process for each word in dictionary, sends lookup
to start word and each process sends out messages to others as
candidates in the chain/ladder, not knowing if it is a word or not

hacked together a a discussion piece and not as an example of fine code.
only supports 4 letter words

currently, to run
----------------

from shell, will get dependencies (gproc), clean, compile and run erl with your binaries
./start.sh

in erl
word_ladder_app:start().
word_ladder_app:initialize().
word_ladder_app:find("cold", "warm").

currently when a process finds a solution, it kills the spawning process
(erl shell I believe) which kills all other word processes.  this means
that the system doesn't run forever (using a fair bit of memory as it
constructs some LONG chains) but also means that initialize needs to be
called before each "find".

produce dictionary file of 4 letter words:
cat /usr/share/dict/words | grep -e '^....$' > four_letter_words.txt
