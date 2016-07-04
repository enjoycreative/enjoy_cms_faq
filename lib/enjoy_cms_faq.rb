require "enjoy/faq/version"

require 'enjoy/faq/routes'

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
        "Enjoy::Faq::Models::#{Enjoy::Faq.orm.to_s.camelize}"
      end
      def orm_specific(name)
        "#{model_namespace}::#{name}".constantize
      end
    end

    autoload :Admin,  'enjoy/faq/admin'
    module Admin
      autoload :Question,               'enjoy/faq/admin/question'
      autoload :Category,               'enjoy/faq/admin/category'
    end

    module Models
      autoload :Question,               'enjoy/faq/models/question'
      autoload :Category,               'enjoy/faq/models/category'

      module Mongoid
        autoload :Question,               'enjoy/faq/models/mongoid/question'
        autoload :Category,               'enjoy/faq/models/mongoid/category'
      end
    end

    module Controllers
      autoload :Questions,                'enjoy/faq/controllers/questions'
      autoload :Categories,               'enjoy/faq/controllers/categories'
    end
  end
end
