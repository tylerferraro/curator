require 'nokogiri'
require 'zip'

module Curator
  class Parser
    class << self
      CONTAINER_FILE = 'META-INF/container.xml'

      def parse(file)
        book = Book.new

        Zip::File.open(file) do |zipfile|
          xml = read_rootfile(zipfile)

          metadata = xml.at_css('metadata')
          metadata.children.each do |node|
            book.set_metadata(node.name, node.content)
          end

          manifest = read_manifest(xml)
          spine = xml.at_css('spine')
          spine_id = spine.attributes['toc'].value
        end
  
        book
      end

      private

      def read_root_file(zipfile)
        xml = read_file(zipfire, CONTAINER_FILE)
        rootfile = xml.at_css('rootfile').attributes['full-path'].value
  
        read_file(zipfile, rootfile)
      end

      def read_file(zipfile, entry_name)
        entry = zipfile.find_entry(entry_name)
        raise StandardError.new("Could not parse #{entry_name}") unless entry
  
        content = entry.get_input_stream(&:read)
        Nokogiri::XML(content) { |config| config.noblanks }
      end

      def read_manifest(xml, book)
        manifest = Manifest.new
        identifier = xml.at_css('package').attributes['unique-identifier'].value

        xml.find_node('manifest').find_children('item').each do |node|
          id = node.attributes[identifier].value
          link = node.attributes['href'].value
          type = node.attributes['media-type'].value

          manifest.add_entry(id: id, link: link, type: type)
        end

        manifest
      end
    end
  end
end
