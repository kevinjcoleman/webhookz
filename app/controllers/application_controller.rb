class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from (ActiveRecord::RecordNotFound) { |exception| handle_exception(exception, 404) }

  protected 
    def handle_exception(ex, status)
        render_error(ex, status)
        logger.error ex   
    end

    def render_error(ex, status)
        @status_code = status
        respond_to do |format|
          format.html { render :template => "error", :status => status }
          format.all { render :nothing => true, :status => status }
      	end
    end



end
