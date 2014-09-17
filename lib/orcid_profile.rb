require 'open-uri'

class OrcidProfile

  class Work
    attr_reader :title, :doi
    def initialize element
      @title = element.css("title").text
      @doi = element.css("work-external-identifier-id").text
    end
  end

  ORCID_API_BASE_URL = "http://pub.orcid.org"

  attr_reader :name, :id, :works

  def initialize orcid_id
    @id = orcid_id
    @name = fetch.css('credit-name').text
    @works = []
    works = fetch 'orcid-works'
    for node in works.xpath '//xmlns:orcid-work'
      @works << node.xpath '//xmlns:work-external-identifier-id'
    end
    puts @works.inspect
  end


  private

  def fetch path = ""
    Nokogiri::XML open(make_uri(path)).read
  end

 def make_uri path
    "#{ORCID_API_BASE_URL}/#{@id}/#{path}"
  end

end
