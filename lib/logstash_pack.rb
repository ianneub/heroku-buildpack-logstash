require 'yaml'
require 'json'

module LogstashPack

  OUTPUT_PATH = ARGV[0]

  def self.detect
    if File.exists? "#{OUTPUT_PATH}/logstash.conf"
      "Logstash"
    else
      raise Exception
    end
  end

  def self.compile
    if File.exists? "#{OUTPUT_PATH}/src/logstash-1.4.0.tar.gz"
      log "unzipping embedded logstash: #{OUTPUT_PATH}"
      `tar -xzf #{OUTPUT_PATH}/src/logstash-1.4.0.tar.gz -C #{OUTPUT_PATH}`
      
      log "patching in sincedb in s3 support"
      `cp #{OUTPUT_PATH}/src/patch/s3.rb #{OUTPUT_PATH}/logstash-1.4.0/lib/logstash/inputs/s3.rb`
      if File.exists? "#{OUTPUT_PATH}/logstash-1.4.0"
        log "unzip complete"
      else
        raise Exception
      end  
    else
      raise Exception
    end
  end

  def self.release
    procfile = {
      "default_process_types" => {
        "worker" => "./logstash-1.4.0/bin/logstash --verbose -f logstash.conf"
      }
    }.to_yaml
    log "generated procfile: #{procfile}"
    procfile
  end

  def self.log(message)
    puts "-----> #{message}"
  end

  def self.config
    output = {}
    output
  end
end
