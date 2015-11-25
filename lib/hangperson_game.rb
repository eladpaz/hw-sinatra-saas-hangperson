class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :wrong_guesses, :word, :guesses
  
  def initialize(word='')
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @num_of_guesses = 0
  end
  
 # def guessing(letter)
  #  guess(letter)
  #end
  
  def guess(letters)
    
    raise ArgumentError, "Argument error!" if letters == nil or letters == '' or !letters.match(/[[:alpha:]]/)
      
    letters.each_char do  |letter|
      @num_of_guesses += 1
      letter.downcase!
      if guesses[letter] or wrong_guesses[letter]
        puts "you already guessed that letter"
        return false
      elsif word[letter]
        guesses<< letter
      else
        wrong_guesses<< letter 
      end
    end
    
  end
  
 def word_with_guesses
   return word.gsub(/[a-zA-Z]/,'-') if @guesses.empty? 
   return word.gsub(/[^#{guesses}]/,'-')
 end

  def check_win_or_lose
    return :lose if @num_of_guesses >= 7
    return :win if word.gsub(/[#{guesses}]/,'')==''
  
    return :play
  end
  
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
