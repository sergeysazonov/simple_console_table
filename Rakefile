#!/usr/bin/env ruby

require 'rubygems'
require 'rake'
require 'rake/clean'
require 'spec/rake/spectask'
require 'jeweler'

Jeweler::Tasks.new do |s|
  s.name = "simple_console_table"
  s.version = "0.1.0"

  s.author = 'Sergey Sazonov'

  s.files = ["lib/simple_console_table.rb"]
  s.has_rdoc = true
  s.description = "A library capable of printing nicely formatted tables to the standard output"
  s.summary = "A library capable of printing nicely formatted tables to the standard output"
  s.test_files = FileList["spec/*spec.rb"].to_a
end

Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_opts << '--options' << 'spec/spec.opts'
  t.spec_files = 'spec/*_spec.rb'
end

desc 'Default: run spec examples'
task :default => 'spec'
