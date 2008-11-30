#!/usr/bin/ruby

require 'rubygems'
require 'fileutils'
require 'spec'
require 'spec/rake/spectask'


GENPWD_VERSION='0.1'

directory 'test/genpwd'

########################################################################
# Installation and packaging tasks
desc <<-EOS
	Install The plugin to ~/.vim/plugin; docs to ~/.vim/doc.  Builds helptags
	for documentation.
EOS
task :install do
	FileUtils.cp "bin/genpwd", "#{ENV['HOME']}/bin/genpwd"
	FileUtils.cp "src/bash_completion.d/genpwd", "/etc/bash_completion.d/genpwd"
end


########################################################################
# Clean

task :clean do
	sh "rm -fr report/ test/"
end

########################################################################
# Testing (incl. spec) tasks


Spec::Rake::SpecTask.new do |t|
	t.ruby_opts = ['-Ibin -Ispec']
	t.spec_opts = ['--color --format specdoc']
end
namespace :spec do
	desc <<-EOS
		Runs specs and produces an html report in report/report.html
	EOS
	Spec::Rake::SpecTask.new(:html) do |t|
		FileUtils.mkdir_p 'report'

		t.ruby_opts = ['-Ibin -Ispec']
		t.spec_opts = ['--color --format html:report/report.html --format specdoc']
	end

	desc <<-EOS
		Runs specs with backtraces shown
	EOS
	Spec::Rake::SpecTask.new(:trace) do |t|
		t.ruby_opts = ['-Ibin -Ispec']
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
