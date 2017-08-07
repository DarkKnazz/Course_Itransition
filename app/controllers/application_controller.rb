class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :set_category
  rescue_from ActionView::MissingTemplate, :with => :template_not_found
  rescue_from ActiveRecord::RecordNotFound, :with => :template_not_found

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    Rails.application.routes.default_url_options[:locale]= I18n.locale
  end

  def set_category
    @category = Category.new
  end

  private
    def template_not_found
      redirect_to root_path
    end
 end
