
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    use Rack::MethodOverride
  end

  get '/' do
  end

  get('/articles/new') do
    erb(:new)
  end

  post('/articles') do
    article = Article.create(title: params["title"], content: params["content"])
    @all_articles = Article.all

    redirect to "/articles/#{article.id}"
  end

  get('/articles') do
    @all_articles = Article.all

    erb(:index)
  end

  get('/articles/:id') do
    @article = Article.find(params[:id])

    erb(:show)
  end

  get('/articles/:id/edit') do
    @article = Article.find(params[:id])

    erb(:edit)
  end

  patch('/articles/:id') do
    Article.update(params["id"], title: params["title"], content: params["content"])

    redirect to "/articles/#{params["id"]}"
  end

  delete('/articles/:id') do
    Article.destroy(params[:id])

    redirect to "/articles"
  end

end
