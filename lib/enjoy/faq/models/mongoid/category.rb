module Enjoy::Faq
  module Models
    module Mongoid
      module Category
        extend ActiveSupport::Concern

        include Enjoy::HtmlField

        included do

          field :name,          type: String, localize: Enjoy::Faq.configuration.localize

          acts_as_nested_set
          scope :sorted, -> { order_by([:lft, :asc]) }

          enjoy_cms_html_field :excerpt,   type: String, localize: Enjoy::Faq.configuration.localize, default: ""
          enjoy_cms_html_field :content,   type: String, localize: Enjoy::Faq.configuration.localize, default: ""
        end

        def questions
          question_class.in(question_category_ids: self.id)
        end

        def all_questions
          question_class.any_in(question_category_ids: self.self_and_descendants.map(&:id))
        end

      end
    end
  end
end
