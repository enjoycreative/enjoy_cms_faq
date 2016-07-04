module Enjoy::Faq
  class CategoriesController < ApplicationController
    include Enjoy::Faq::Controllers::Categories

    include Enjoy::Faq::Decorators::Categories
  end
end
