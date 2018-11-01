require 'nokogiri'
require 'zip'

module Curator
  class Parser
    class << self
      CONTAINER_FILE = 'META-INF/container.xml'

      def parse(file)
        book = Book.new

        Zip::File.open(file) do |zipfile|
          xml = read_file(CONTAINER_FILE)
          rootfile = xml.at_css('rootfile')
                        .attributes['full-path']
                        .value
  
          xml = read_file(rootfile)
        end
  
        return book
      end

      private

      def read_file(entry_name)
        entry = zipfile.find_entry(entry_name)
        raise StandardError.new("Could not parse #{file}") unless entry
  
        content = entry.get_input_stream { |is| is.read }
        Nokogiri::XML(content)
      end
    end
  end
end
