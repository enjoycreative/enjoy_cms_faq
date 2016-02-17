module Enjoy::Faq
  class Question
    include Enjoy::Faq::Models::Question

    include Enjoy::Faq::Decorators::Question

    rails_admin(&Enjoy::Faq::Admin::Question.config(rails_admin_add_fields) { |config|
      rails_admin_add_config(config)
    })
  end
end
