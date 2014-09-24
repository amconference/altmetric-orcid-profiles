Rails.application.routes.draw do
  root 'profile#index'
  get ':orcid_id' => 'profile#show'
  get ':orcid_id/content' => 'profile#content'
  get ':orcid_id/posts/:date/:post_type' => 'profile#posts_for_date'
end
