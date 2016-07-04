module Enjoy
  module Faq
    def self.configuration
      @configuration ||= Configuration.new
    end
    def self.config
      @configuration ||= Configuration.new
    end

    def self.configure
      yield configuration
    end

    class Configuration
      attr_accessor :author_name_required

      attr_accessor :default_answer_author_name

      attr_accessor :save_with_captcha
      attr_accessor :captcha_error_message

      attr_accessor :recaptcha_support
      attr_accessor :simple_captcha_support

      attr_accessor :seo_support

      attr_accessor :localize

      def initialize
        @author_name_required = true

        @default_answer_author_name  = "Администрация сайта"

        @save_with_captcha = true
        @captcha_error_message = "Код с картинки введен неверно"

        @recaptcha_support = defined?(Recaptcha)
        @simple_captcha_support = defined?(SimpleCaptcha)

        @seo_support = defined?(Enjoy::Seo)

        @breadcrumbs_on_rails_support = defined?(BreadcrumbsOnRails)

        @localize = Enjoy.config.localize
      end
    end
  end
end
