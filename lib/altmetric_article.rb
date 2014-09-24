require 'open-uri'

class AltmetricArticle

  def initialize work
    @work = work
    @data = fetch "doi/#{@work.doi}" if @work.doi
  end

  def badge_uri
    @data['images']['large']
  end

  def details_uri
    @data['details_url']
  end

  def has_data?
    !!@data
  end

  ALTMETRIC_API_BASE_URL = "http://api.altmetric.com/v1"

  private

  def fetch path = ""
    Rails.logger.info "Opening URI: #{make_uri(path)}"
    JSON.parse open(make_uri(path)).read
  end

 def make_uri path
    "#{ALTMETRIC_API_BASE_URL}/#{path}"
  end

end
