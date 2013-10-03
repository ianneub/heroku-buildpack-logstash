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
    log "Downloading Logstash #{config[:version]} from #{config[:url]}..."
    `curl #{config[:url]} -L --silent -o #{OUTPUT_PATH}/logstash.jar`
  end

  def self.release
    debug = config[:debug] ? "-vvv" : ""
    {
      "default_process_types" => {
        "worker" => "/usr/bin/java -server -Xms384M -Xmx384M -Djava.net.preferIPv4Stack=true -XX:+UseParallelOldGC -jar /app/logstash.jar agent -f /app/logstash.conf #{debug}"
      }
    }.to_yaml
  end

  def self.log(message)
    puts "-----> #{message}"
  end

  def self.config
    output = {}
    # get variables from config.json if it exists
    if File.exists? "#{OUTPUT_PATH}/config.json"
      config = JSON.parse File.read "#{OUTPUT_PATH}/config.json"
      output[:version] = config['logstash']['version'] if config['logstash']['version']
      output[:url] = config['logstash']['url'] if config['logstash']['url']
      output[:debug] = config['logstash']['debug'] if config['logstash']['debug']
    end

    output[:version] ||= "1.2.1"
    output[:url] ||= "https://download.elasticsearch.org/logstash/logstash/logstash-#{output[:version]}-flatjar.jar"
    output[:debug] ||= false

    output
  end
end
