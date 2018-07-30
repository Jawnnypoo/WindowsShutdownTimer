# coding: utf-8

Gem::Specification.new do |s|
  s.name = 'windows-shutdown-timer'
  s.version = '1.0.3'
  s.author = 'John Carlson'
  s.email = "jawnnypoo at Google's popular web mail service"
  s.description = 'Shut down Windows machine after keeping it awake'
  s.summary = 'Starts a timer, keeping the Windows machine awake and shutting it down when the timer expires'
  s.homepage = 'https://github.com/Jawnnypoo/windows-shutdown-timer'
  s.license = 'MIT'
  s.files = ['lib/windows-shutdown-timer.rb']
  s.bindir = 'bin'
  s.require_paths << 'lib'
  s.executables << 'windows-shutdown-timer'

  s.required_ruby_version = '>= 2.0.0'

  s.add_runtime_dependency "rubyzip", ">= 1.2.1"
end
