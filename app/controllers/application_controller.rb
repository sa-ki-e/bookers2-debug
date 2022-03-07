class ApplicationController < ActionController::Base
 
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  before_action :set_search

  def set_search
    @search = Book.ransack(params[:q])
    @search_books = @search.result
  end

  private

  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  def after_sign_out_path_for(resource)
    home_about_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
