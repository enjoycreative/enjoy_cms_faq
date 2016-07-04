module Enjoy::Faq
  module Controllers
    module Questions
      extend ActiveSupport::Concern

      def index
        @questions = question_class.enabled.sorted.to_a
        # index_crumbs
      end

      def show
        @question = question_class.enabled.find(params[:id])
        if !@question.text_slug.blank? and @question.text_slug != params[:id]
          redirect_to @question, status_code: 301
          return
        end
        @parent_seo_page = find_seo_page(question_categories_path) if @seo_page.blank?
        # item_crumbs
      end

      def page_title
        if @question
          @question.page_title
        else
          super
        end
      end

      def create
        @question = question_class.new(question_params)

        if Enjoy::Faq.config.captcha
          if Enjoy::Faq.config.recaptcha_support
            if verify_recaptcha
              meth = :save
            else
              meth = :valid?
              @recaptcha_error = I18n.t('enjoy.errors.faq.recaptcha')
            end

          elsif Enjoy::Faq.config.simple_captcha_support
            meth = :save_with_captcha

          else
            meth = :save
          end
        else
          meth = :save
        end

        if @question.send(_method)
          @message = "Успешно создано все"
        else
          @message = "Косяки есть"
        end

        if request.xhr?
          render layout: false
        end
      end

      private
      def question_params
        params[:enjoy_faq_question].permit(:question_text, :author_name, :author_email, :captcha, :captcha_key)
      end

      def category_class
        Enjoy::Faq::Category
      end
      def question_class
        Enjoy::Faq::Question
      end

      # def item_crumbs
      #   if @item
      #     if @item.item_categories.enabled.count == 1
      #       if @parent_seo_page
      #         _crumb = @parent_seo_page.name
      #         _crumb = @parent_seo_page.title if _crumb.blank?
      #         _crumb = @parent_seo_page.h1 if _crumb.blank?
      #         add_crumb _crumb, @parent_seo_page.fullpath
      #       end
      #
      #       @item_category = @item.item_categories.enabled.first
      #       _crumb = @item_category.name
      #       _crumb = @item_category.title if _crumb.blank?
      #       _crumb = @item_category.h1 if _crumb.blank?
      #       add_crumb _crumb, item_category_path(@item_category)
      #     end
      #     _crumb = @item.name
      #     _crumb = @item.title if _crumb.blank?
      #     _crumb = @item.h1 if _crumb.blank?
      #     add_crumb _crumb, item_path(@item)
      #   end
      # end
    end
  end
end
