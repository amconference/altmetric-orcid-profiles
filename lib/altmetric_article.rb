require 'open-uri'

class AltmetricArticle

  BADGE_404 = 'http://fastly.altmetric.com/?size=100&score=?&types=????????'
  API_KEY = "decafbad"

  def initialize work
    @work = work
    @data = fetch if @work.doi
  end

  def badge_uri
    if has_data?
      @data['images']['medium']
    else
      BADGE_404
    end
  end

  def details_uri
    @data['details_url'].to_s + "&embedded=true" if has_data?
  end

  def has_data?
    @data.present?
  end

  ALTMETRIC_API_BASE_URL = "http://api.altmetric.com/v1"

  private

  def path
    doi_param = CGI::escape @work.doi
    "fetch/doi/#{doi_param}"
  end

  def full_path
    make_uri(path)
  end

  def cache_key
    "altmetric.api_cache.#{ full_path }"
  end

  def fetch
    begin
      data = get_data
      set_cache data
      return JSON.parse data
    rescue OpenURI::HTTPError => ex
      puts "altmetric.com 404 for #{full_path}"
      return nil
    end
  end

  def get_data
    $redis.get(cache_key) || open(full_path).read
  end

  def set_cache(data)
    $redis.setex cache_key, 1.hour.to_i, data
  end

  def make_uri path
    "#{ALTMETRIC_API_BASE_URL}/#{path}?key=#{API_KEY}"
  end

end
