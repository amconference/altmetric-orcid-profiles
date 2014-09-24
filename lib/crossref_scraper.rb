class CrossrefScraper
  BASE_URI = "http://search.crossref.org/links"
  def self.doi_for_title title
    response = Unirest.post BASE_URI,
      headers: { :"Content-Type" => "application/json" },
      parameters: [title].to_json
    if response.code == 200
      has_match = response.body['results'][0]['match']
      return nil unless has_match
      return self.doi_ify(response.body['results'][0]['doi'])
    else
      return nil
    end
  end

  def self.doi_ify doi_uri
    doi_uri.gsub 'http://dx.doi.org/', ''
  end
end
