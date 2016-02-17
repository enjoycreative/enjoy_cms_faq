module Enjoy::Faq
  class QuestionsController < ApplicationController
    include Enjoy::Faq::Controllers::Questions

    include Enjoy::Faq::Decorators::Questions
  end
end
