#!/usr/bin/env ruby

require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rake/gempackagetask'
require 'spec/rake/spectask'

spec = Gem::Specification.new do |s| 
  s.author = 'Sergey Sazonov'
  s.files = FileList["lib/*.rb"].to_a
  s.has_rdoc = true
  s.name = "simple_console_table"
  s.summary = "A library capable of printing nicely formatted tables to the standard output"
  s.test_files = FileList["spec/*spec.rb"].to_a
  s.version = "0.1.0"
end

Rake::GemPackageTask.new(spec) do |package|
  package.gem_spec = spec
end

Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_opts << '--options' << 'spec/spec.opts'
  t.spec_files = 'spec/*_spec.rb'
end

desc 'Default: run spec examples'
task :default => 'spec'
