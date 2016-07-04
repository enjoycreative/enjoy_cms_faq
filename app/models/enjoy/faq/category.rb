module Enjoy::Faq
  class Category
    include Enjoy::Faq::Models::Category

    include Enjoy::Faq::Decorators::Category

    rails_admin(&Enjoy::Faq::Admin::Category.config(rails_admin_add_fields) { |config|
      rails_admin_add_config(config)
    })
  end
end
