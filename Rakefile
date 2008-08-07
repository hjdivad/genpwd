#!/usr/bin/ruby

require 'rubygems'
require 'fileutils'
require 'spec'
require 'spec/rake/spectask'


GENPWD_VERSION='0.1'


########################################################################
# Installation and packaging tasks
desc <<-EOS
	Install The plugin to ~/.vim/plugin; docs to ~/.vim/doc.  Builds helptags
	for documentation.
EOS
task :install => [:install_plugin, :install_doc, :retag_docs]


########################################################################
# Testing (incl. spec) tasks


namespace :spec do
	desc <<-EOS
		Runs specs and produces an html report in report/report.html
	EOS
	Spec::Rake::SpecTask.new(:html) do |t|
		FileUtils.mkdir_p 'report'

		t.ruby_opts = ['-Isrc']
		t.spec_opts = ['--color --format html:report/report.html --format specdoc']
	end

	desc <<-EOS
		Runs specs with backtraces shown
	EOS
	Spec::Rake::SpecTask.new(:trace) do |t|
		t.ruby_opts = ['-Isrc']
		t.spec_opts = ['--color --backtrace --format specdoc']
	end

	desc <<-EOS
		Runs specs with backtraces shown through rdebug
	EOS
	task :debug do |t|
		system "rdebug rake -- spec:trace"
	end
end
########################################################################
