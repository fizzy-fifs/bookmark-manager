feature 'Viewing bookmarks' do
    scenario 'visiting the index page' do
      visit('/')
      expect(page).to have_content "Welcome to your Bookmark manager"
      expect(page).to have_selector(:link_or_button, 'Bookmarks')
      expect(page).to have_field("add_bookmarks")
    end

    scenario 'A user can see bookmarks' do
      connection = PG.connect(dbname: 'bookmark_manager_test')

      connection.exec("INSERT INTO bookmarks VALUES(1, 'http://www.makersacademy.com');")
      connection.exec("INSERT INTO bookmarks VALUES(2, 'http://www.destroyallsoftware.com');")
      connection.exec("INSERT INTO bookmarks VALUES(3, 'http://www.google.com');")
      
      visit('/bookmarks')
        
      expect(page).to have_content "http://www.makersacademy.com"
      expect(page).to have_content "http://www.destroyallsoftware.com"
      expect(page).to have_content "http://www.google.com"
    end

    scenario 'creates a new bookmark' do
      connection = PG.connect(dbname: 'bookmark_manager_test')
      add_bookmarks_to_db
      Bookmark.create("www.twitter.com")
      visit('/bookmarks')
      expect(page).to have_content "www.twitter.com"
    end
  end