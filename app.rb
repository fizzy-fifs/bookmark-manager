require 'sinatra/base'
require 'sinatra/reloader'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base
	configure :development do 
		register Sinatra::Reloader
	end

  set :port, 4563

  enable :sessions, :method_override

	get '/' do 
		erb :'root/index'
	end

  post '/new' do
    Bookmark.create(url: params[:enter_url], title: params[:enter_title])
    redirect '/bookmarks'
  end

	get '/bookmarks' do
		@bookmarks = Bookmark.all
		erb :'bookmarks/index'
	end

  delete '/bookmarks/:id' do
    Bookmark.delete(params[:id])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id' do
    @update = params[:id]
    erb :update
  end

  patch '/bookmarks/:id' do
    Bookmark.update(id: params["id"], url: params["update_url"], title: params["update_title"])
    redirect '/bookmarks'
  end

	run! if app_file == $0
end