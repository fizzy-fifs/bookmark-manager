require 'pg'
class Bookmark
  attr_reader :url, :title
  def initialize(id, url, title)
    @id = id
    @url = url
    @title = title
  end

	def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end

    result = connection.exec("SELECT * FROM bookmarks;")
    result.map do
       |row| bookmark = Bookmark.new( row['id'], row['url'], row['title'])
      end
	end

  def self.create(url:, title:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
    result = connection.exec("INSERT INTO bookmarks (url, title) VALUES('#{url}', '#{title}') RETURNING id, url, title;")
    Bookmark.new( result[0]['id'], result[0]['url'], result[0]['title'])
  end
end