require 'nokogiri'
require 'zip'

module Curator
  class Parser
    class << self
      def parse(file)
        return Book.new
      end
    end
  end
end
