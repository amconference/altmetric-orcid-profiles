class CrossrefScraper

  include ActiveSupport::Configurable
  include ActionController::Caching

  BASE_URI = "http://search.crossref.org/links"
  
  def doi_for_title title
    key = "crossref.api_cache.#{ title }"
    data = $redis.get(key) || send_crossref_request(title)
    $redis.setex key, 1.hour.to_i, data
    data
  end

  private

  def send_crossref_request title
    crossref_response = Unirest.post BASE_URI,
      headers: { :"Content-Type" => "application/json" },
      parameters: [title].to_json
    if crossref_response.code == 200
      has_match = crossref_response.body['results'][0]['match']
      return doi_ify(crossref_response.body['results'][0]['doi']) if has_match
    else
      return nil
    end
  end

  def doi_ify doi_uri
    doi_uri.gsub 'http://dx.doi.org/', ''
  end
end
