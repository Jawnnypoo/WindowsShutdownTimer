require_relative '../lib/windows-shutdown-timer.rb'

input = ARGV
puts 'Input size: ' + input.size.to_s
puts 'Input: ' + input.to_s
installer = WindowsShutdownTimer::ShutdownStarter.new(input)
installer.start_timer
