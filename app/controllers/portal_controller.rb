class PortalController < ApplicationController
  def index
    @questions = Question.all
  end
end
