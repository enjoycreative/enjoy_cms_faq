module Enjoy::Faq
  module Controllers
    module QuestionCategories
      extend ActiveSupport::Concern

      def index
        @question_categories = question_category_class.enabled.sorted.to_a
        @root_categories = question_category_class.enabled.roots.sorted.all.to_a
        # index_crumbs
      end

      def show
        @question_category = question_category_class.enabled.find(params[:id])
        if !@question_category.text_slug.blank? and @question_category.text_slug != params[:id]
          redirect_to @question_category, status_code: 301
          return
        end
        @seo_parent_page = find_seo_page(question_categories_path)

        @children = @question_category.children.enabled.sorted.all.to_a
        @questions = @question_category.questions.enabled.sorted.all.to_a

        # index_crumbs
        # category_crumbs
      end

      def page_title
        if @question_category
          @question_category.page_title
        else
          super
        end
      end

      private
      def question_category_class
        Enjoy::Faq::QuestionCategory
      end
      def question_class
        Enjoy::Faq::Question
      end

      # def index_crumbs
      #   if @seo_parent_page
      #     catalog_title   = Settings.ns('breadcrumbs').catalog_title(default: "Каталог", label: "'Каталог' в breadcrumbs")
      #     _crumb = catalog_title
      #     _crumb = @seo_parent_page.name if _crumb.blank?
      #     _crumb = @seo_parent_page.title if _crumb.blank?
      #     _crumb = @seo_parent_page.h1 if _crumb.blank?
      #     add_crumb _crumb, @seo_parent_page.fullpath
      #   else
      #     catalog_title   = Settings.ns('breadcrumbs').catalog_title(default: "Каталог", label: "'Каталог' в breadcrumbs")
      #     _crumb = catalog_title
      #     add_crumb _crumb, item_categories_path
      #   end
      # end
      #
      # def category_crumbs
      #   if @item_category
      #     _parent = @item_category.parent
      #     if _parent
      #       _crumb = _parent.name if _crumb.blank?
      #       _crumb = _parent.title if _crumb.blank?
      #       _crumb = _parent.h1 if _crumb.blank?
      #       add_crumb _crumb, item_category_path(_parent)
      #       _crumb = nil
      #     end
      #     _crumb = @item_category.name if _crumb.blank?
      #     _crumb = @item_category.title if _crumb.blank?
      #     _crumb = @item_category.h1 if _crumb.blank?
      #     add_crumb _crumb, item_category_path(@item_category)
      #   end
      # end
    end
  end
end
