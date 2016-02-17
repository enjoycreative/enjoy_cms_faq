module Enjoy::Faq
  module Models
    module Question
      extend ActiveSupport::Concern
      include Enjoy::Model
      include Enjoy::Enableable

      include Enjoy::Seoable
      include Enjoy::SitemapDataField
      include ManualSlug

      include Enjoy::Faq.orm_specific('Question')

      included do
        manual_slug :full_name

        apply_simple_captcha message: Enjoy::Faq.configuration.captcha_error_message

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

      def question_category_class
        Enjoy::Faq::QuestionCategory
      end

    end
  end
end
