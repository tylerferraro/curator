require 'nokogiri'

module Curator
  class XML
    extend Forwardable

    def_delegators :@xml, :name, :content
  
    attr_reader :xml

    def initialize(xml)
      @xml = Nokogiri::XML(xml)
      @children = nil
    end

    def find_node(name)
      XML.new(xml.at_css(name))
    end

    def attributes(name)
      xml.attributes[name].value
    end

    def find_children(name)
      children.select { |node| node.name == name }
    end

    def children
      return @children unless @children.nil?
  
      @children = xml.children
                     .reject { |node| whitespace_node?(node) }
                     .map { |node| XML.new(node) }
    end

    private

    def whitespace_node?(node)
      node.name == 'text' && node.content.strip.empty?
    end
  end
end
