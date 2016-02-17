Enjoy::Faq::Engine.routes.draw do
  routes_config = Enjoy::Faq.configuration.routes_config

  if !routes_config or routes_config[:use_questions_path]
    resources :questions, only: [:show, :new, :create] do
      get '(/page/:page)', action: :index, on: :collection, as: ""
    end
  end

  if !routes_config or routes_config[:use_question_categories_path]
    resources :question_categories, only: [:index, :show] do
      get 'items(/page/:page)', action: :questions, on: :member, as: :items
    end
  end
  if !routes_config or routes_config[:use_faq_path]
    get 'faq' => 'question_categories#index', as: :faq
  end
end
