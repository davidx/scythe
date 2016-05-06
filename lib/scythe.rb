
require "scythe/version"
require 'log4r'
require 'choice'
require 'highline/import'
require 'fog/aws'
require 'active_support'

module Scythe
  include Fog
  class LogMachine
    include Log4r
    def initialize
      mylogger = Logger.new 'mylog'
      formatter = PatternFormatter.new(:pattern => "[%l] %d :: %.20m")
      mylogger.outputters = StdoutOutputter.new("console", :formatter => formatter)
      mylogger.level = Log4r::INFO
    end
  end
  def terminate_server_by_id(id, required_tag)
    server=Compute[:aws].servers.get(id)
    server.destroy if server.tags.key?(required_tag)
  end
  def get_servers_for_termination(max_age, required_tag)
    servers = Compute[:aws].servers
    start_time=DateTime.now.strftime("%s").to_i
    servers_to_be_reaped=[]

    servers.each do |server|
      next unless server.state == 'running'
      server_created_time = server.created_at.strftime("%s").to_i
      server_age = start_time - server_created_time

      if server_age > max_age && server.tags.include?(required_tag)
        servers_to_be_reaped.push(server)
      end
    end
    servers_to_be_reaped
  end
end
