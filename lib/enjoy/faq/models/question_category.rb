module Enjoy::Faq
  module Models
    module QuestionCategory
      extend ActiveSupport::Concern
      include Enjoy::Model

      include Enjoy::Enableable
      include Enjoy::Seoable
      include Enjoy::SitemapDataField
      include ManualSlug

      include Enjoy::Faq.orm_specific('QuestionCategory')

      included do
        manual_slug :name
      end

      def clean_excerpt
        self.excerpt ||= ""
        Rails::Html::FullSanitizer.new.sanitize(self.excerpt.strip)
      end

      def clean_content
        self.content ||= ""
        Rails::Html::FullSanitizer.new.sanitize(self.content.strip)
      end

      def question_class
        Enjoy::Faq::Question
      end
    end
  end
end
