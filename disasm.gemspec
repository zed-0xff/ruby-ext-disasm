# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'disasm/version'

Gem::Specification.new do |s|
  s.name          = "disasm"
  s.version       = Disasm::VERSION
  s.authors       = ["Andrey \"Zed\" Zaikin"]
  s.email         = ["zed.0xff@gmail.com"]
  s.homepage      = "https://github.com/zed-0xff/disasm"
  s.summary       = "x86 disassembler"
  s.description   = s.summary

  s.files         = `git ls-files app lib ext`.split("\n")
  s.platform      = Gem::Platform::RUBY
  s.require_paths = ['lib']
  s.rubyforge_project = '[none]'
  s.extensions    = ['ext/disasm/extconf.rb']
end
