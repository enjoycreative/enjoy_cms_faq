module Enjoy::Faq
  module Models
    module Category
      extend ActiveSupport::Concern
      include Enjoy::Model
      include Enjoy::Enableable

      if Enjoy::Faq.config.seo_support
        include Enjoy::Seo::Seoable
        include Enjoy::Seo::SitemapDataField
      end
      include ManualSlug

      include Enjoy::Faq.orm_specific('Category')

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
