#!/usr/bin/env ruby

require 'rubygems'
require 'rake'
require 'rake/clean'
require 'spec/rake/spectask'

Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_opts << '--options' << 'spec/spec.opts'
  t.spec_files = 'spec/*_spec.rb'
end

desc 'Default: run spec examples'
task :default => 'spec'
