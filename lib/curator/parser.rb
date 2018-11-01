require 'nokogiri'
require 'zip'

module Curator
  class Parser
    class << self
      def parse(file)
        book = Book.new

        Zip::File.open(file) do |zipfile|
          entry = zipfile.find_entry(CONTAINER_FILE)
          raise StandardError.new("Could not parse #{file}") unless entry
  
          container = entry.get_input_stream { |is| is.read }
          xml = Nokogiri::XML(container)
          rootfile = xml.at_css('rootfile')
          root = rootfile.attributes['full-path'].value
  
          entry = zipfile.find_entry(root)
          content = entry.get_input_stream { |is| is.read }
          xml = Nokogiri::XML(content)
        end
  
        return book
      end
    end
  end
end
