require 'optparse'
require 'open-uri'
require 'net/http'
require 'fileutils'
require 'zip'

module WindowsShutdownTimer
  # Shutdown!
  class ShutdownStarter
    INSOMNIA = 'Insomnia.exe'.freeze
    PATH_TO_TEMP = (Dir.tmpdir + '/windows-shutdown-timer').freeze
    PATH_TO_INSOMNIA = (PATH_TO_TEMP + '/' + INSOMNIA).freeze
    PATH = 'insomnia/64-bit'.freeze
    COMMAND_SHUTDOWN = 'shutdown /s /t '.freeze
    COMMAND_CANCEL_SHUTDOWN = 'shutdown /a'.freeze
    COMMAND_INSOMNIA = "start #{PATH_TO_INSOMNIA}".freeze

    def initialize(arguments)
      # Get the first arg as the time
      @time = %w(-h --help -c).include?(arguments.first) ? nil : arguments.shift

      create_options_parser(arguments)
    end

    def create_options_parser(args)
      args.options do |opts|
        opts.banner = 'Usage: windows-shutdown-timer MINUTES_UNTIL_SHUTDOWN [OPTIONS]'
        opts.separator ''
        opts.separator 'Options'
        opts.on('-c', '--cancel', 'Cancel a pending shutdown') do
          @time = 0
        end
        opts.on('-i', '--insomnia', 'Just runs Insomnia') do
          @time = -1
        end
        opts.on('-h', '--help', 'Displays help') do
          puts opts.help
          exit
        end
        opts.parse!
      end
    end

    def start_timer
      unless File.file?(PATH_TO_INSOMNIA)
        puts 'Downloading Insomnia.exe'
        download('http://dlaa.me/Samples/Insomnia/Insomnia.zip', 'Insomnia.zip')
        unzip('Insomnia.zip', 'insomnia')
        FileUtils.mkdir(PATH_TO_TEMP)
        FileUtils.mv('insomnia/64-bit/Insomnia.exe', PATH_TO_INSOMNIA)
        # Cleanup
        FileUtils.rm_rf('insomnia')
        FileUtils.rm('Insomnia.zip')
      end
      if @time.nil?
        puts 'Please enter the number of minutes until shutdown (0 to cancel):'
        @time = gets.to_i
      end
      if @time.zero?
        `#{COMMAND_CANCEL_SHUTDOWN}`
      elsif @time == -1
        `#{COMMAND_INSOMNIA}`
      else
        time_in_seconds = @time * 60
        `#{COMMAND_SHUTDOWN} #{time_in_seconds}`
        `#{COMMAND_INSOMNIA}`
      end
    end

    def download(url, file_name)
      File.open(file_name, 'wb') do |saved_file|
        open(url, 'rb') do |read_file|
          saved_file.write(read_file.read)
        end
      end
    end

    def unzip(file, destination)
      Zip::File.open(file) do |zip_file|
        zip_file.each do |f|
          f_path = File.join(destination, f.name)
          FileUtils.mkdir_p(File.dirname(f_path))
          zip_file.extract(f, f_path) unless File.exist?(f_path)
        end
      end
    end
  end
end
