require 'open-uri'

class OrcidProfile

  class Work
    attr_reader :title, :subtitle, :doi

    def initialize element
      @element = element
      @title    = get_work_detail 'title'
      @subtitle = get_work_detail 'subtitle'
      @doi      = get_work_detail 'work-external-identifier-id'
      scrape_crossref unless has_doi?
    end

    def altmetric_article
      @altmetric_article ||= AltmetricArticle.new(self) if has_doi?
    end

    def has_doi?
      @doi.present?
    end

    private

    def get_work_detail(field_name)
      if (@element.css(field_name).first)
        return @element.css(field_name).first.text
      end
    end

    def scrape_crossref
      @doi = CrossrefScraper.new.doi_for_title @title
    end
  end

  ORCID_API_BASE_URL = 'http://pub.orcid.org'

  attr_reader :id, :works

  def initialize orcid_id
    @id    = orcid_id
    @works = fetch('orcid-works').xpath('//xmlns:orcid-work').map { |n| Work.new(n) }
  end

  def altmetric_posts
    @works.map(&:altmetric_article).compact.flatten.map(&:posts).flatten.sort {|a,b| a.post_type <=> b.post_type }
  end

  def name
    @name ||= begin
      name = fetch.css('credit-name').text
      name = "#{fetch.css('given-names').text} #{fetch.css('family-name').text}" if name.blank?
      name
    end
  end

  def bio
    name = fetch.css('biography').text
  end

  private

  def fetch path = ""
    full_path = make_uri(path)
    key       = "orcid.api_cache.#{ full_path }"
    data      = $redis.get(key) || open(full_path).read
    $redis.setex key, 1.hour.to_i, data
    Nokogiri::XML data
  end

  def make_uri path
    "#{ORCID_API_BASE_URL}/#{@id}/#{path}"
  end

end
