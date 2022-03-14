require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    session[:score] = 0 unless session[:score].present?
    @alphabet = ('A'..'Z').to_a
    @letters = []
    10.times do
      @letters << @alphabet.sample
    end
  end

  def score
    @answer = params['answer'].downcase
    @contain = @answer.downcase.chars
    @grid = params['letters'].downcase.chars
    if word?(@answer) && checker(@contain, @grid)
      @score = @results['length']
      @message = "Congratulations! <b>#{@answer.upcase}</b> is a valid English world! Your score is #{@score} pts. for this round.".html_safe
      session[:score] += @score
    elsif word?(@answer) && !checker(@contain, @grid)
      @message = "Sorry but <b>#{@answer.upcase}</b> can't be built out of #{params['letters'].upcase.gsub(' ', ', ')}".html_safe
    else
      @message = "Sorry but <b>#{@answer.upcase}</b> does not seem to be a valid English word...".html_safe
    end
  end

  def checker(answer_array, grid_array)
    if answer_array - grid_array == []
      hash = grid_array.tally
      answer_array.each { |letter| hash[letter] -= 1 }
      hash.select { |_k, v| v.negative? }.empty?
    else
      false
    end
  end

  def word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    words = URI.open(url).read
    @results = JSON.parse(words)
    @results['found']
  end
end
