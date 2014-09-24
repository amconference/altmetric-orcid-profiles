class ProfileController < ApplicationController
  def content
    @orcid_profile = OrcidProfile.new params[:orcid_id]
    render partial: "content"
  end
  def posts_for_date
    render text: "Date: #{params[:date]}, type: #{params[:post_type]}"
  end
end
