module Enjoy::Faq
  class QuestionCategoriesController < ApplicationController
    include Enjoy::Faq::Controllers::QuestionCategories

    include Enjoy::Faq::Decorators::QuestionCategories
  end
end
