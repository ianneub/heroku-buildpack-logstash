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
    # get variables from config.json if it exists
    if File.exists? "#{OUTPUT_PATH}/config.json"
      config = JSON.parse File.read "#{OUTPUT_PATH}/config.json"
      logstash_version = config['logstash']['version'] if config['logstash']['version']
      logstash_url = config['logstash']['url'] if config['logstash']['url']
    end
    
    logstash_version ||= "1.2.1"
    logstash_url ||= "https://download.elasticsearch.org/logstash/logstash/logstash-#{logstash_version}-flatjar.jar"

    log "Downloading Logstash #{logstash_version} from #{logstash_url}..."
    `curl #{logstash_url} -L --silent -o #{OUTPUT_PATH}/logstash.jar`
  end

  def self.release
    {
      "default_process_types" => {
        "worker" => "/usr/bin/java -server -Xms384M -Xmx384M -Djava.net.preferIPv4Stack=true -XX:+UseParallelOldGC -jar /app/logstash.jar agent -f /app/logstash.conf"
      }
    }.to_yaml
  end

  def self.log(message)
    puts "-----> #{message}"
  end
end
