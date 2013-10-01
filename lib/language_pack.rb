require 'yaml'

module LanguagePack

  LOGSTASH_VERSION = "1.2.1"
  LOGSTASH_URL = "https://download.elasticsearch.org/logstash/logstash/logstash-#{LOGSTASH_VERSION}-flatjar.jar"

  def self.detect
    log "Logstash"
  end

  def self.compile
    log "Downloading Logstash #{LOGSTASH_VERSION}..."
    `curl #{LOGSTASH_URL} -L --silent -o logstash.jar`
  end

  def self.release
    {
      "default_process_types" => {
        "worker" => "/usr/bin/java -server -Xms384M -Xmx384M -Djava.net.preferIPv4Stack=true -XX:+UseParallelOldGC -jar logstash.jar agent -f logstash.conf"
      }
    }.to_yaml
  end

  def self.log(message)
    puts "-----> #{message}"
  end
end
