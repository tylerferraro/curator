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

          metadata = xml.find_node('metadata')
          metadata.children.each { |node| read_metadata(node, book) }

          manifest = read_manifest(xml)
          spine = xml.find_node('spine')
          spine_id = spine.attributes('toc')
        end
  
        book
      end

      private

      def read_root_file(zipfile)
        xml = read_file(zipfire, CONTAINER_FILE)
        rootfile = xml.find_node('rootfile').attributes('full-path')
  
        read_file(zipfile, rootfile)
      end

      def read_file(zipfile, entry_name)
        entry = zipfile.find_entry(entry_name)
        raise StandardError.new("Could not parse #{file}") unless entry
  
        content = entry.get_input_stream(&:read)
        XML.new(content)
      end

      def read_metadata(node, book)
        case node.name
        when 'creator'
          book.authors << node.content
        when 'date' && node.attributes('event') == 'publication'
          book.publication = node.content 
        when 'language'
          book.language = node.content
        when 'rights'
          book.rights << node.content
        when 'subject'
          book.subjects << node.content
        when 'title'
          book.title = node.content 
        end
      end

      def read_manifest(xml, book)
        manifest = Manifest.new
        identifier = xml.find_node('package').attributes('unique-identifier')

        xml.find_node('manifest').find_children('item').each do |node|
          id = node.attributes(identifier)
          link = node.attributes('href')
          type = node.attributes('media-type')

          manifest.add_entry(id: id, link: link, type: type)
        end

        manifest
      end
    end
  end
end
