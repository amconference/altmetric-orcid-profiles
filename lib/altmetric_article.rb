require 'open-uri'

class AltmetricArticle

  include ActiveSupport::Configurable
  include ActionController::Caching

  def initialize work
    @work = work
    @data = fetch("doi/#{@work.doi}") if @work.doi
  end

  def badge_uri
    if has_data?
      @data['images']['medium']
    else
      "http://fastly.altmetric.com/?size=100&score=?&types=????????"
    end
  end

  def details_uri
    @data['details_url'] if has_data?
  end

  def has_data?
    @data.present?
  end

  ALTMETRIC_API_BASE_URL = "http://api.altmetric.com/v1"

  private

  def fetch path = ""
    full_path = make_uri(path)
    key = "altmetric.api_cache.#{ full_path }"
    begin
      data = $redis.get(key) || open(full_path).read
      $redis.setex key, 1.hour.to_i, data
      return JSON.parse data
    rescue OpenURI::HTTPError => ex
      puts "altmetric.com 404 for #{full_path}"
      return nil
    end
  end

 def make_uri path
    "#{ALTMETRIC_API_BASE_URL}/#{path}"
  end

end
