module Enjoy::Faq
  module Admin
    module Question
      def self.config(fields = {})
        Proc.new {
          navigation_label "FAQ"

          list do
            scopes [:by_date, :by_answered_date, :answered, :not_answered, :enabled, nil]

            field :enabled, :toggle
            field :categories
            field :full_name
          end

          edit do
            field :categories
            field :enabled, :toggle

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

            group 'Данные вопроса' do
              active false
              field :question_text, :text
              field :question_text_after_editing, :enjoy_html
              field :author_name, :string
              field :author_name_text_after_editing, :string
              field :author_email, :string
            end

            group 'Данные ответа' do
              active false
              field :answered, :toggle
              field :answer_text, :enjoy_html
              field :answered_time
              field :answer_author_name, :string
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

          end

          if block_given?
            yield self
          end
        }
      end
    end
  end
end
