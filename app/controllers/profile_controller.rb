class ProfileController < ApplicationController
  def content
    @orcid_profile = OrcidProfile.new params[:orcid_id]
    render partial: "content"
  end
end
