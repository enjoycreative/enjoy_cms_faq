module ActionDispatch::Routing
  class Mapper
    def enjoy_cms_faq_routes(config = {})
      routes_config = {
        use_questions_path: true,
        use_categories_path: true,
        use_faq_path: true,
        faq_path: 'faq',
        classes: {
          questions: :questions,
          categories: :categories,
          faq_controller: :categories
        },
        paths: {
          questions: :questions,
          categories: :categories
        },
        pagination: {
          questions: true,
          categories: true,
          category_questions: true
        },
        actions: {
          questions: [:show, :create],
          categories: [:show],
        }
      }
      routes_config.deep_merge!(config)

      generate_enjoy_faq_user_routes(routes_config)
      generate_enjoy_faq_cms_routes(routes_config)
    end


    private
    def generate_enjoy_faq_user_routes(routes_config)
      if !routes_config[:use_questions_path] and !routes_config[:classes][:questions].nil?
        resources routes_config[:classes][:questions].to_sym, only: routes_config[:actions][:questions], path: routes_config[:paths][:questions] do
          get '(/page/:page)', action: :index, on: :collection, as: "" if routes_config[:pagination][:questions]
        end
      end

      if !routes_config[:use_categories_path] and !routes_config[:classes][:categories].nil?
        resources routes_config[:classes][:categories].to_sym, only: routes_config[:actions][:categories], path: routes_config[:paths][:categories] do
          get '(/page/:page)', action: :index, on: :collection, as: "" if routes_config[:pagination][:categories]
          get 'questions(/page/:page)', action: :questions, on: :member, as: :questions if routes_config[:pagination][:category_questions]
        end
      end

      if !routes_config[:use_faq_path] and !routes_config[:classes][:faq_controller].nil?
        get "#{routes_config[:faq_path]}" => "#{routes_config[:classes][:faq_controller]}#index"
      end
    end

    def generate_enjoy_faq_cms_routes(routes_config)
      scope module: 'enjoy' do
        scope module: 'faq' do
          if routes_config[:use_questions_path] and !routes_config[:classes][:questions].nil?
            resources routes_config[:classes][:questions].to_sym, only: routes_config[:actions][:questions], path: routes_config[:paths][:questions], as: :enjoy_faq_questions do
              get '(/page/:page)', action: :index, on: :collection, as: "" if routes_config[:pagination][:questions]
            end
          end

          if routes_config[:use_categories_path] and !routes_config[:classes][:categories].nil?
            resources routes_config[:classes][:categories].to_sym, only: routes_config[:actions][:categories], path: routes_config[:paths][:categories], as: :enjoy_catalog_categories do
              get '(/page/:page)', action: :index, on: :collection, as: "" if routes_config[:pagination][:categories]
              get 'questions(/page/:page)', action: :items, on: :member, as: :questions if routes_config[:pagination][:category_questions]
            end
          end
          if routes_config[:use_faq_path] and !routes_config[:classes][:faq_controller].nil?
            get "#{routes_config[:faq_path]}" => "#{routes_config[:classes][:faq_controller]}#index", as: :enjoy_faq
          end
        end
      end
    end

  end
end
