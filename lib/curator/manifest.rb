module Curator
  class Manifest
    class << self
      def build
        yield new
      end
    end

    attr_accessor :items

    def initialize
      @items = []
    end

    def add_entry(id:, link:, type:)
      items << Item.new(id, link, type)
    end

    private:

    class Item
      attr_accessor :id, :link, :type

      def initialize(id, link, type)
        @id = id
        @link = link
        @type = type
      end
    end
  end
end
