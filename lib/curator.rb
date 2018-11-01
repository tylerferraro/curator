require 'curator/book'
require 'curator/parser'
require 'curator/version'

module Curator
  class << self
    def curate(file)
      book = Parser.parse(file)
    end
  end
end
