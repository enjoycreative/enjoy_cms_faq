module Enjoy::Faq
  module Models
    module Question
      extend ActiveSupport::Concern
      include Enjoy::Model
      include Enjoy::Enableable

      if Enjoy::Faq.config.seo_support
        include Enjoy::Seo::Seoable
        include Enjoy::Seo::SitemapDataField
      end
      include ManualSlug

      include Enjoy::Faq.orm_specific('Question')

      included do
        manual_slug :full_name

        if Enjoy::Faq.config.simple_captcha_support
          include SimpleCaptcha::ModelHelpers
          apply_simple_captcha message: Enjoy::Faq.configuration.captcha_error_message
        end

        validates_email_format_of :author_email
        if Enjoy::Faq.config.author_name_required
          validates_presence_of :author_name
        end
        validates_presence_of :question_text, :author_email
      end

      def name
        "#{self.question_text_output} (#{self.author_name_output})"
      end

      def full_name
        "#{self.author_name_output}: \"#{self.question_text_output}\""
      end

      def category_class
        Enjoy::Faq::Category
      end

    end
  end
end
