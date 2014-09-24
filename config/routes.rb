Rails.application.routes.draw do
  root 'profile#index'
  get ':orcid_id' => 'profile#show'
  get ':orcid_id/content' => 'profile#content'
end
