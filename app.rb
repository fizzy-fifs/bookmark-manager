require 'sinatra/base'
require 'sinatra/reloader'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base
	configure :development do 
		register Sinatra::Reloader
	end
  
  enable :sessions

  set :port, 4569

	get '/' do 
		erb :'root/index'
	end

  post '/new' do
    session[:add_bookmarks] = params[:add_bookmarks]
    bookmark = Bookmark.new
    bookmark.create(session[:add_bookmarks])
    redirect '/bookmarks'
  end

	get '/bookmarks' do
		@bookmarks = Bookmark.all
		erb :'bookmarks/index'
	end


	run! if app_file == $0
end