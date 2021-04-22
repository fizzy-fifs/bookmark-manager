require 'sinatra/base'
require 'sinatra/reloader'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base
	configure :development do 
		register Sinatra::Reloader
	end
  
  enable :sessions

  set :port, 4567

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


	run! if app_file == $0
end