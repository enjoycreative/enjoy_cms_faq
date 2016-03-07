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

      def initialize
        @author_name_required = true

        @default_answer_author_name  = "Администрация сайта"

        @save_with_captcha = true
        @captcha_error_message = "Код с картинки введен неверно"
      end
    end
  end
end
