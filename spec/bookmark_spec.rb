require 'bookmark'

describe Bookmark do
	describe '.all' do
		it 'returns all bookmarks' do 
      connection = PG.connect(dbname: 'bookmark_manager_test')
      Bookmark.create('http://www.makersacademy.com')
      Bookmark.create('http://www.destroyallsoftware.com')
      Bookmark.create('http://www.google.com')
      
      bookmarks = Bookmark.all
			
      expect(bookmarks).to eq(["http://www.makersacademy.com", "http://www.destroyallsoftware.com", "http://www.google.com"])
      # expect(bookmarks).to include("http://www.destroyallsoftware.com")
      # expect(bookmarks).to include("http://www.google.com")
    end
  end

  describe '.create(bookmark)' do
    it 'creates a new bookmark' do
      connection = PG.connect(dbname: 'bookmark_manager_test')
      Bookmark.create('www.twitter.com')
      bookmarks = Bookmark.all
      expect(bookmarks).to eq(['www.twitter.com'])
    end
  end
end

        
    