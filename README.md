# Hangman

A web version of the classic Hangman guessing game. A secret word is generated upon initialization. You have ten guesses to complete the word or you're hanged. 

# Installation

To play online go here [link](https://glacial-retreat-36955.herokuapp.com/?guess=p)

To run the game locally, first clone the repository in your command line, then enter the following: 

```
$ cd hangman
$ ruby hangman.rb
```

Go to localhost:4567 in your browser.

# Running

The game is written in Ruby and uses file I/O to load a secret word from a dictionary file. It will only accept letters in the guess input, and won't allow the user to re-enter letters he/she has already guessed. If a letter is entered that is in the word, that letter will take it's appropriate place in the secret word as well as be added to the correct guesses list. The user will not lose a turn. Incorrect guesses will be added to the incorrect guesses list and the turns will decrement by one.

If the word is completely filled out or the turns get down to 0, a game over message will appear prompting the user to start a new game.

### Acknowledgments

[link](https://www.theodinproject.com/courses/ruby-on-rails/lessons/sinatra-project)