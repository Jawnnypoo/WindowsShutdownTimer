require 'optparse'
require 'net/http'
require 'zip'

module WindowsShutdownTimer
  # Shutdown!
  class ShutdownStarter

    EXE = 'Insomnia.exe'
    PATH = 'insomnia/64-bit'

    def initialize(arguments)
      @time = nil
      create_options_parser(arguments)
    end

    def create_options_parser(args)
      args.options do |opts|
        opts.banner = 'Usage: windows-shutdown-timer [OPTIONS]'
        opts.separator ''
        opts.separator 'Options'
        opts.on('-t', '--time', 'The amount of time in minutes before shutdown') do |time|
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
      # TODO download only if not already present
      download('dlaa.me', '/Samples/Insomnia/Insomnia.zip', 'Insomnia.zip')
      unzip('Insomnia.zip', 'insomnia')
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
