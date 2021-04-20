require 'sinatra/base'
require 'sinatra/reloader'

class BookmarkManager < Sinatra::Base
    configure :development do 
        register Sinatra::reloader
    end

    get '/' do 
        'Bookmark Manager'
    end 

    run! if app_file == $0
end