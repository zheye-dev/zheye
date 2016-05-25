class SearchController < ApplicationController
  def index
    @query = params[:query]
    @search = Answer.search do
      fulltext params[:query]
    end
  end

  private
  def search_params
    params.permit(:query)
  end
end
