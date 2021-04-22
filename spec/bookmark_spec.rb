require 'bookmark'

describe Bookmark do
	describe '.all' do
		it 'returns all bookmarks' do 
      connection = PG.connect(dbname: 'bookmark_manager_test')
      Bookmark.create(url: 'http://www.makersacademy.com', title: 'Makers')
      Bookmark.create(url: 'http://www.destroyallsoftware.com', title: 'Destroyall Software')
      Bookmark.create(url: 'http://www.google.com', title: 'Google')
      
      bookmarks = Bookmark.all
      expect(bookmarks.first.title).to eq("Makers")
    end
  end

  describe '.create(bookmark)' do
    it 'creates a new bookmark' do
      connection = PG.connect(dbname: 'bookmark_manager_test')
      #Bookmark.create('www.twitter.com', 'Twitter')
      bookmarks = Bookmark.create(url: 'www.twitter.com', title: 'Twitter')
      expect(bookmarks.url).to eq('www.twitter.com')
      expect(bookmarks.title).to eq('Twitter')
    end
  end
end

        
    