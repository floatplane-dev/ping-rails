Rails.application.routes.draw do
  # Make the API future proof by versioning v1
  namespace :v1 do
    # 
  end

  # Return app meta info for health check.
  get 'sanity-check', to: 'sanity#check'

  # Return a 404 for all other routes.
  match '*catch', to: 'application#render_404', via: :all
end
