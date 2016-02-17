module Enjoy::Faq
  class QuestionCategory
    include Enjoy::Faq::Models::QuestionCategory

    include Enjoy::Faq::Decorators::QuestionCategory

    rails_admin(&Enjoy::Faq::Admin::QuestionCategory.config(rails_admin_add_fields) { |config|
      rails_admin_add_config(config)
    })
  end
end
