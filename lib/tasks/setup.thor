class DtfSetup < Thor

  desc "install", "installs database schemas and control scripts"
  method_options :force => :boolean
  def install(name= "*")
    puts "installing db schemas and control scripts"
    Dir["db/migrations/#{name}"].each do |source|
      destination = "db/migrations/#{File.basename(source)}"
      FileUtils.rm(destination) if options[:force] && File.exist?(destination)
      if File.exist?(destination)
        puts "Skipping #{destination} because it already exists"
      else
        puts "Generating #{destination}"
        FileUtils.cp(source, destination)
      end
    end
  end

  desc "config [NAME]", "copy db configuration file(s)"
  method_options :force => :boolean
  def config(name = "*")
    Dir["examples/config/#{name}"].each do |source|
      destination = "config/#{File.basename(source)}"
      FileUtils.rm(destination) if options[:force] && File.exist?(destination)
      if File.exist?(destination)
        puts "Skipping #{destination} because it already exists"
      else
        puts "Generating #{destination}"
        FileUtils.cp(source, destination)
      end
    end
  end

end
