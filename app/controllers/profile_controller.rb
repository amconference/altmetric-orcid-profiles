class ProfileController < ApplicationController
  def show
    @orcid_profile = OrcidProfile.new params[:orcid_id]
    render "show"
  end
end
