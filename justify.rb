#!/usr/bin/ruby

class Justify
  attr_accessor :words, :width, :input

  def initialize(input, width)
    @words = input.split(' ')
    @width = (width < 0 ? 0 : width)
    @input = input
  end

  def format_text
    if width >= input.length || width == 0 
      puts input
      return
    end

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
    word_count = words_in_sentence.count

    return temp if word_count == 1

    while temp.length < width do 
      j = 0 if j == word_count

      words_in_sentence[j] = words_in_sentence[j].to_s.ljust(words_in_sentence[j].to_s.length + 1) 
      temp = words_in_sentence.join(' ').strip
      j += 1
    end
    temp
  end
end

input = ''
width = ARGV[1].to_i
File.foreach(ARGV[0]) do |line|
  input = line
end
input.gsub!(/[\\\"]/,"").gsub!("\n", '')

Justify.new(input, width).format_text
