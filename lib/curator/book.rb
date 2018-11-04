module Curator
  class Book
    attr_accessor :title, :authors, :subjects, :rights

    def initialize(attrs={})
      @title = attrs[:title] || 'Unknown'
      @authors = Array.wrap(attrs[:authors])
      @publication = attrs[:publication] || 'Unknown'
      @subjects = Array.wrap(attrs[:subjects])
      @language = attrs[:language] || 'Unknown'
      @rights = attrs[:rights] || 'Unknown'
    end

    def set_metadata(name, value)
      case name
      when 'creator'
        authors << value
      when 'date' && node.attributes['event'].value == 'publication'
        publication = value
      when 'language'
        language = value
      when 'rights'
        rights = value
      when 'subject'
        subjects << value
      when 'title'
        title = value
      end
    end

    def info
      """
      Title: #{title}
      Authors: #{authors.join(', ')}
      Publication: #{publication}
      Subjects: #{subjects.join(', ')}
      Language: #{language}
      Rights: #{rights}
      """
    end
  end
end
