class FormTestController < ApplicationController
  def create
  end

  def result
  	@result = params[:q]
  end
end
