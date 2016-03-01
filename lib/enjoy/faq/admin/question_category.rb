module Enjoy::Faq
  module Admin
    module QuestionCategory
      def self.config(fields = {})
        Proc.new {
          navigation_label "FAQ"

          list do
            scopes [:sorted, :enabled, nil]

            field :enabled, :toggle
            field :name
            # field :image

            field :questions do
              read_only true

              pretty_value do
                bindings[:object].questions.to_a.map { |q|
                  route = bindings[:view] || bindings[:controller]
                  model_name = q.rails_admin_model
                  route.link_to(q.full_name, route.rails_admin.show_path(model_name: model_name, id: q.id), title: q.name)
                }.join("<br>").html_safe
              end
            end
          end

          edit do
            field :enabled, :toggle
            field :name
            # field :sidebar_title, :string

            group :URL do
              active false
              field :slugs, :enum do
                enum_method do
                  :slugs
                end
                visible do
                  bindings[:view].current_user.admin?
                end
                multiple do
                  true
                end
              end
              field :text_slug
            end
            # field :image, :jcrop do
            #   jcrop_options do
            #     :image_jcrop_options
            #   end
            # end

            group :content do
              active false
              field :excerpt, :enjoy_html
              field :content, :enjoy_html
            end

            group :seo do
              active false
              field :seo do
                active true
              end
            end
            group :sitemap_data do
              active false
              field :sitemap_data do
                active true
              end
            end

            fields.each_pair do |name, type|
              if type.nil?
                field name
              else
                if type.is_a?(Array)
                  field name, type[0], &type[1]
                else
                  field name, type
                end
              end
            end


            group :questions do
              active false
              field :questions do
                read_only true
                help 'Список вопросов'

                pretty_value do
                  bindings[:object].questions.to_a.map { |q|
                  route = (bindings[:view] || bindings[:controller])
                  model_name = q.rails_admin_model
                  route.link_to(q.name, route.rails_admin.show_path(model_name: model_name, id: q.id), title: q.full_name)
                  }.join("<br>").html_safe
                end
              end
            end
          end

          show do
            field :name
            # field :sidebar_title
            field :slugs, :enum do
              enum_method do
                :slugs
              end
              visible do
                bindings[:view].current_user.admin?
              end
              multiple do
                true
              end
            end
            field :text_slug
            field :enabled
            # field :image
            field :excerpt
            field :content

            fields.each_pair do |name, type|
              if type.nil?
                field name
              else
                if type.is_a?(Array)
                  field name, type[0], &type[1]
                else
                  field name, type
                end
              end
            end

            field :questions do
              read_only true

              pretty_value do
                bindings[:object].questions.to_a.map { |q|
                  route = (bindings[:view] || bindings[:controller])
                  model_name = q.rails_admin_model
                  route.link_to(i.full_name, route.rails_admin.show_path(model_name: model_name, id: q.id), title: q.name)
                }.join("<br>").html_safe
              end
            end
          end

          nested_set({max_depth: 2, scopes: []})

          if block_given?
            yield self
          end

        }
      end
    end
  end
end
