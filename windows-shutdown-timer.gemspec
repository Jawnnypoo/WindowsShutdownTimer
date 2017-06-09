# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = 'windows-shutdown-timer'
  spec.version       = '1.0.1'
  spec.authors       = ['John Carlson']
  spec.email         = ['jawnnypoo@gmail.com']

  spec.summary       = 'Starts a timer, keeping the Windows machine awake and shutting it down when the timer expires'
  spec.homepage      = 'https://github.com/Jawnnypoo/windows-shutdown-timer'
  spec.license       = 'MIT'

  spec.files         = ['lib/windows-shutdown-timer.rb']
  spec.bindir        = 'bin'
  spec.require_paths << 'lib'
  spec.executables   << 'windows-shutdown-timer'

  spec.required_ruby_version = '>= 2.0.0'

  spec.add_dependency 'rubyzip', '~> 1.0.0', '>= 1.0.0'
end
