require 'sinatra'
require 'sinatra/reloader' if development?

class Game
    attr_accessor :guesses, :correct_guesses, :incorrect_guesses, :secret_word
    def initialize 
        @guesses = 10
        @guess = ''
        @correct_guesses = []
        @incorrect_guesses = []
        generate_word
    end
    
    # load dictionary and generate random word between 5 and 12 characters
    def generate_word
        good_words = []
        File.readlines('dictionary.txt').each do |word| 
            if word.length >= 5 && word.length <= 12
            good_words << word
            end
        end
        @secret_word = good_words.sample.strip.downcase
        @letters = @secret_word.split('') # separate letters
        @blanks = Array.new(@secret_word.length, '_') # create blanks to fill in
    end
    
    # show the updated blanks after each turn
    def display
       @blanks.each { |letter| print "#{letter} " } 
    end
    
    # prompt user for guesses and check for matches
    def check_guess(guess)
        if @correct_guesses.include?(guess) || @incorrect_guesses.include?(guess)
                @message = "You tried that already!"
        elsif !('a'..'z').cover?(guess)
                @message = "Guess a letter!"
        elsif @letters.include?guess
            @letters.each_with_index do |letter, index|
                @blanks[index] = letter if letter == guess
            end
            @correct_guesses << guess
            @message = "You got one!"
        else
            @incorrect_guesses << guess
            @guesses = @guesses -= 1
        end
        check_end
    end
    
    # if guesses run out or blanks get filled in, game_over is set to true, ending the game
    def check_end
        if @guesses == 0
            @message = "Game over, you lose! The secret word was #{@secret_word}! Another word was generated.. Press guess to see it."
        elsif @blanks.none? { |letter| letter == '_' } 
            @message = "You win! The secret word is #{@secret_word.upcase}! Another word was generated.. Press guess to see it."
        else
            @message = "Letters from a-z"
        end 
    end
end


hangman = Game.new


get '/' do
    guess = params['guess'].to_s
    @message = hangman.check_guess(guess)
     
    @guesses = hangman.guesses
    @correct_guesses = hangman.correct_guesses
    @incorrect_guesses = hangman.incorrect_guesses
    @display = hangman.display
    
    if @guesses == 0 || !@display.include?('_')
        hangman = Game.new
    end
            
    erb :index, :locals => { :message => @message, :announce => @announce, :display => @display, :guesses => @guesses, :correct_guesses => @correct_guesses, :incorrect_guesses => @incorrect_guesses }
end

