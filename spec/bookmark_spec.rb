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
      bookmarks = Bookmark.create(url: 'www.twitter.com', title: 'Twitter')
      expect(bookmarks.url).to eq('www.twitter.com')
      expect(bookmarks.title).to eq('Twitter')
    end
  end

  describe '.delete(id)' do
    it 'deletes a bookmark' do
      bookmark = Bookmark.create(url: 'www.twitter.com', title: 'Twitter')
      Bookmark.delete(bookmark.id)
      expect(Bookmark.all).to be_empty
    end
  end

  describe '.update' do
    it 'updates a bookmark title and url' do
      website = Bookmark.create(url: 'www.twitter.com', title: 'Twitter')
      Bookmark.update(id: website.id, url: 'www.google.com', title: 'Google')
      bookmark = Bookmark.all[0]
      expect(bookmark.url).to eq('www.google.com')
      expect(bookmark.title).to eq('Google')
    end
  end

end

        
    