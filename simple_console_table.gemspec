# -*- encoding: utf-8 -*-

require 'rake'

Gem::Specification.new do |s|
  s.name = "simple_console_table"
  s.version = "0.1.0"

  s.author = 'Sergey Sazonov'

  s.files = FileList["lib/*.rb"].to_a
  s.has_rdoc = true
  s.description = "A library capable of printing nicely formatted tables to the standard output"
  s.summary = "A library capable of printing nicely formatted tables to the standard output"
  s.test_files = FileList["spec/*spec.rb"].to_a
end
