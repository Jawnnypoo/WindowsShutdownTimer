require 'optparse'
require 'net/http'
require 'zip'
require 'fileutils'

module WindowsShutdownTimer
  # Shutdown!
  class ShutdownStarter

    EXE = 'Insomnia.exe'
    PATH = 'insomnia/64-bit'
    COMMAND_SHUTDOWN = 'shutdown /s /t '
    COMMAND_CANCEL_SHUTDOWN = 'shutdown /a'

    def initialize(arguments)
      @time = nil
      create_options_parser(arguments)
    end

    def create_options_parser(args)
      args.options do |opts|
        opts.banner = 'Usage: windows-shutdown-timer [OPTIONS]'
        opts.separator ''
        opts.separator 'Options'
        opts.on('-t', '--time', 'The amount of time in minutes before shutdown. 0 will cancel the shutdown') do |time|
          @time = time
        end
        opts.on('-h', '--help', 'Displays help') do
          puts opts.help
          exit
        end
        opts.parse!
      end
    end

    def start_timer
      unless File.file?(EXE)
        download('dlaa.me', '/Samples/Insomnia/Insomnia.zip', 'Insomnia.zip')
        unzip('Insomnia.zip', 'insomnia')
        FileUtils.mv('insomnia/64-bit/Insomnia.exe', Dir.pwd + '/Insomnia.exe')
        FileUtils.rm_rf('insomnia')
        FileUtils.rm('Insomnia.zip')
      end
      if @time == nil
        puts 'Please enter the number of minutes until shutdown (0 to cancel):'
        @time = gets
      end
      if @time.to_i == 0
        `#{COMMAND_CANCEL_SHUTDOWN}`
      else
        time_in_seconds = @time.to_i * 60
        `#{COMMAND_SHUTDOWN} #{time_in_seconds}`
        `#{EXE}`
      end
    end

    def download(base_url, path, file_name)
      Net::HTTP.start(base_url) do |http|
        resp = http.get(path)
        open(file_name, 'wb') do |file|
          file.write(resp.body)
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
