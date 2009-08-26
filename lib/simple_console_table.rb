# = SimpleConsoleTable - a library capable of printing nicely formatted tables to stdout
# Copyright (C) 2009  Sergey Sazonov
# 
# == Example
# === Basic example
# 
#   require 'rubygems'
#   require 'simple_console_table'
#   
#   table = SimpleConsoleTable.new
# 
#   table << ['one', 'two', 'three']
#   table << ['four', 'five', 'six', 'seven']
#   
#   table.as_string
#   
#   # +--------+--------+---------+---------+
#   # |   one  |   two  |  three  |         |
#   # +--------+--------+---------+---------+
#   # |  four  |  five  |    six  |  seven  |
#   # +--------+--------+---------+---------+
# 
# Use print to write the table directly to the console. Use as_string to obtain the result as a string.
# 
# === Using objects other than strings
# 
# SimpleConsoleTable invokes to_s method on every object thus converting everything to strings.
# 
#   class Dummy
#     def initialize(dummy_id); @dummy_id = dummy_id; end
#     def to_s; "Dummy #{@dummy_id}"; end
#   end
# 
#   require 'rubygems'
#   require 'simple_console_table'
#   
#   table = SimpleConsoleTable.new
# 
#   table << ['one', 2, 'three']
#   table << [true, 'five', -6.89, Dummy.new(345)]
# 
#   table.as_string
#   
#   # +--------+--------+---------+-------------+
#   # |   one  |     2  |  three  |             |
#   # +--------+--------+---------+-------------+
#   # |  true  |  five  |  -6.89  |  Dummy 345  |
#   # +--------+--------+---------+-------------+
# 
# === Passing nested arrays
# 
# SimpleConsoleTable invokes flatten method on every array passed to <<
# 
#   require 'rubygems'
#   require 'simple_console_table'
#   
#   table = SimpleConsoleTable.new
# 
#   table << [1, 2, [3, 4], [5]]
#   table << [[[[[[6, 7, 8]]], [[[[9, 10]]]]]]]
# 
#   table.as_string
#   
#   # +-----+-----+-----+-----+------+
#   # |  1  |  2  |  3  |  4  |   5  |
#   # +-----+-----+-----+-----+------+
#   # |  6  |  7  |  8  |  9  |  10  |
#   # +-----+-----+-----+-----+------+

class SimpleConsoleTable

  DEFAULT_FORMATTER = lambda do |text_to_format, column_width|
    sprintf("  %#{column_width}.#{column_width}s  ", text_to_format)
  end

  def initialize
    @rows = []
    @formatter = DEFAULT_FORMATTER
  end

  # Adds row.flatten.collect { |cell_content| cell_content.to_s } to the table
  def <<(row)
    @rows << row.flatten.collect { |cell_content| cell_content.to_s }
  end

  # Returns an empty string if the table is empty (that is, no rows have been added).
  # Otherwise, returns the formatted table as a string.
  def as_string
    return '' if @rows.empty?

    column_widths = calculate_column_widths
    formatted_rows = format_table(column_widths)
    formatted_column_widths = formatted_rows.first.collect { |cell_content| cell_content.length }
    row_separator = construct_row_separator(formatted_column_widths)

    output = formatted_rows.collect do |row|
      ['', row, ''].flatten.join('|')
    end

    separated_output = ([row_separator] * (output.length + 1)).zip(output).flatten

    separated_output.join("\n")
  end
  
  # A shortcut for puts(as_string)
  def print
    puts(as_string)
  end

  private

  def calculate_column_widths
    column_widths = []

    @rows.each do |row|
      row.each_with_index do |cell_content, index|
        column_widths[index] ||= 0
        column_widths[index] = [column_widths[index], cell_content.length].max
      end
    end

    column_widths
  end

  def format_table(column_widths)
    @rows.collect do |row|
      (0...column_widths.length).collect do |column_index|
        @formatter.call(row[column_index] || '', column_widths[column_index])
      end
    end
  end

  def construct_row_separator(column_widths)
    separator = column_widths.collect do |column_width|
      '-' * column_width
    end.join('+')

    "+#{separator}+"
  end
end
