require "enjoy/faq/version"

require 'enjoy/faq/routes'

require 'enjoy_cms'

require 'rails_admin_sort_embedded'
require 'rails_admin_jcrop'

require 'enjoy/faq/configuration'
require 'enjoy/faq/engine'

module Enjoy
  module Faq
    class << self
      def orm
        :mongoid
      end
      def mongoid?
        Enjoy::Faq.orm == :mongoid
      end
      def active_record?
        Enjoy::Faq.orm == :active_record
      end
      def model_namespace
        "Enjoy::Faq::Models::#{Enjoy::Catalog.orm.to_s.camelize}"
      end
      def orm_specific(name)
        "#{model_namespace}::#{name}".constantize
      end
    end

    autoload :Admin,  'enjoy/faq/admin'
    module Admin
      autoload :Question,               'enjoy/faq/admin/question'
      autoload :QuestionCategory,       'enjoy/faq/admin/question_category'
    end

    module Models
      autoload :Question,               'enjoy/faq/models/question'
      autoload :QuestionCategory,       'enjoy/faq/models/question_category'

      module Mongoid
        autoload :Question,               'enjoy/faq/models/mongoid/question'
        autoload :QuestionCategory,       'enjoy/faq/models/mongoid/question_category'
      end
    end

    module Controllers
      autoload :Questions,                'enjoy/faq/controllers/questions'
      autoload :QuestionCategories,       'enjoy/faq/controllers/question_categories'
    end
  end
end
