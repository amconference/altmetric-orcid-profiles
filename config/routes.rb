Rails.application.routes.draw do
  root 'profile#index'
  get ':orcid_id' => 'profile#show'
end
