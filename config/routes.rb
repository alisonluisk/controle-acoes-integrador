Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
   namespace :api, defaults: { format: :json }, path: '/api'  do
     namespace :v1, path: '/v1', constraints: ApiVersionConstraint.new(version: 1, default: true) do
       resources :dados_venda, only: [:index, :create] do
         collection do
           post 'cancelar'
         end
       end
     end
   end
end
