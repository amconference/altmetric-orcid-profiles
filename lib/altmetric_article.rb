require 'open-uri'

class AltmetricArticle

  include ActiveSupport::Configurable
  include ActionController::Caching

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
    key = "altmetric.api_cache.#{ path }"
    data = $redis.get(key) || open(make_uri(path)).read
    $redis.setex key, 1.hour.to_i, data
    JSON.parse data
  end

 def make_uri path
    "#{ALTMETRIC_API_BASE_URL}/#{path}"
  end

end
