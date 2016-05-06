
require "scythe/version"
require 'log4r'
require 'choice'
require 'highline/import'
require 'fog/aws'
require 'active_support'

module Scythe
  class LogMachine
    include Log4r
    def initialize
      mylogger = Logger.new 'mylog'
      formatter = PatternFormatter.new(:pattern => "[%l] %d :: %.20m")
      mylogger.outputters = StdoutOutputter.new("console", :formatter => formatter)
      mylogger.level = Log4r::INFO
    end
  end
end
