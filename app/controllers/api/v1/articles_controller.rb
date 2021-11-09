#sdf
class API::V1::ArticlesController < ApplicationController
    def index
      @articles = ::Article.order('created_at DESC')
      render json: { status: 200, message: 'Done', data: @articles }, status: :ok
    end

    def show
      @article = Article.find(params[:id])
      render json: @article
    end

    def create
      @article = Article.new(articles_params)

      if @article.save
        render json: { status: 200, data: @article }
      else
        render json: { status: 500, data: @article.errors }, status: :unprocessable_entity
      end
    end

    def destroy
      @article = Article.find(params[:id])
      @article.destroy
      render json: {status: 200, message: "Article Deleted"}
    end

    def update
      @article = Article.find(params[:id])
      if @article.update(articles_params)
        render json: { status: 200, data: @article }
      else
        render json: { status: 500, data: @article.errors }, status: :unprocessable_entity
      end
    end

    def articles_params
      params.permit(:title, :body)
    end
end