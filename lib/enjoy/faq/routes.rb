module ActionDispatch::Routing
  class Mapper

    def enjoy_cms_faq_routes(config = {})
      routes_config = {
        use_questions_path: true,
        use_question_categories_path: true,
        use_faq_path: true
      }
      routes_config.merge!(config)

      scope module: 'enjoy' do
        scope module: 'faq' do
          if routes_config[:use_questions_path]
            resources :questions, only: [:show, :new, :create], as: :enjoy_faq_questions do
              get '(/page/:page)', action: :index, on: :collection, as: ""
            end
          end

          if routes_config[:use_question_categories_path]
            resources :question_categories, only: [:index, :show], as: :enjoy_faq_question_categories do
              get 'questions(/page/:page)', action: :questions, on: :member, as: :questions
            end
          end
          if routes_config[:use_faq_path]
            get 'faq' => 'question_categories#index', as: :enjoy_faq
          end
        end
      end

    end

  end
end
