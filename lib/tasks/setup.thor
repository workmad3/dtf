# encoding: UTF-8

class DtfSetup < Thor

  desc "install", "Installs database migrations, the main schema, and configuration files"
  method_options :force => :boolean
  def install(name= "*")
    puts "Installing db migrations, main schema, and config files"

    # The gem is installed elsewhere so the copy path needs to be
    # relative to the gem, not the user.
    curr_dir = File.dirname(__FILE__)

    Dir["#{curr_dir}/../../db/migrate/#{name}"].each do |source|

      # Use File.basename to remove the gem's path info so we can
      # use just the filename to copy relative to the user.
      destination = "db/migrate/#{File.basename(source)}"

      FileUtils.rm(destination) if options[:force] && File.exist?(destination)
      if File.exist?(destination)
        puts "Skipping #{destination} because it already exists"
      else
        puts "Generating #{destination}"
        FileUtils.cp(source, destination)
      end
    end
  end

  desc "config [NAME]", "Copy db configuration file(s)"
  method_options :force => :boolean
  def config(name = "*")

    # The gem is installed elsewhere so the copy path needs to be
    # relative to the gem, not the user.
    curr_dir = File.dirname(__FILE__)

    Dir["#{curr_dir}/../../examples/db/#{name}"].each do |source|

      # Use File.basename to remove the gem's path info so we can
      # use just the filename to copy relative to the user.
      destination = "db/#{File.basename(source)}"

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
