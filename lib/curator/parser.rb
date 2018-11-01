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
          metadata = xml.css('metadata').children
          metadata.each do |xml_entry|
            case xml_entry.name
            when 'creator'
              book.authors << xml_entry.content
            when 'date' && xml_entry.attributes['event'].value == 'publication'
              book.publication = xml_entry.content 
            when 'language'
              book.language = xml_entry.content
            when 'rights'
              book.rights << xml_entry.content
            when 'subject'
              book.subjects << xml_entry.content
            when 'title'
              book.title = xml_entry.content 
            end
          end
        end
  
        book
      end

      private

      def read_file(entry_name)
        entry = zipfile.find_entry(entry_name)
        raise StandardError.new("Could not parse #{file}") unless entry
  
        content = entry.get_input_stream(&:read)
        Nokogiri::XML(content)
      end
    end
  end
end
