#!/usr/bin/ruby

class Justify
  attr_accessor :words, :width

  def initialize(words, width)
    @words = words
    @width = width
  end

  def format_text
    i = 0
    last_word = ''
    temp = ''

    while i < words.length do
      if [temp, words[i]].join(' ').strip.length <= width 
        temp = [temp, words[i]].join(' ').strip
        i += 1
      else
        temp = remove_extra_words(temp)
        temp = add_extra_spaces(temp)
        puts temp
        temp = last_word 
        last_word = ''
      end
    end 
    temp = remove_extra_words(temp)
    temp = add_extra_spaces(temp)
    puts temp
  end

  def remove_extra_words(temp)
    while temp.length > width do
      temp = temp[/(.*)\s/, 1]
      last_word = temp.split(' ').last + last_word
    end
    temp
  end

  def add_extra_spaces(temp)
    j = 0
    words_in_sentence = temp.split(' ')
    while words_in_sentence.join(' ').length < width do 
      words_in_sentence[j] = words_in_sentence[j].to_s + '  '
      j += 1
      temp = words_in_sentence.join(' ')
    end
    temp
  end
end

input = ''
width = ARGV[1].to_i
File.foreach(ARGV[0]) do |line|
  input = line
end
words = input.gsub(/[\\\"]/,"").gsub("\n", '').split(' ')

Justify.new(words, width).format_text
