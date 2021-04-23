feature 'Viewing bookmarks' do
  scenario 'visiting the index page' do
    visit('/')
    expect(page).to have_content "Welcome to your Bookmark manager"
    expect(page).to have_selector(:link_or_button, 'Bookmarks')
    expect(page).to have_field("enter_url")
    expect(page).to have_field("enter_title")
  end

  scenario 'A user can see bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    Bookmark.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')
    Bookmark.create(url: 'http://www.destroyallsoftware.com', title: 'Destroy All Software')
    Bookmark.create(url: 'http://www.google.com', title:'Google')
    
    visit('/bookmarks')
      
    expect(page).to have_link('Makers Academy', href: 'http://www.makersacademy.com')
    expect(page).to have_link('Destroy All Software',  href: 'http://www.destroyallsoftware.com')
    expect(page).to have_link('Google', href: 'http://www.google.com')
  end

  scenario 'creates a new bookmark' do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    add_bookmarks_to_db
    Bookmark.create(url: "www.twitter.com", title: 'Twitter')
    visit('/bookmarks')
    expect(page).to have_content "Twitter"
  end

  scenario 'A user can delete a bookmark' do
    Bookmark.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')
    visit('/bookmarks')
    expect(page).to have_link('Makers Academy', href: 'http://www.makersacademy.com')

    click_button 'Delete'

    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link('Makers Academy', href: 'http://www.makersacademy.com')
  end

  scenario 'A user can update bookmarks' do
    Bookmark.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')
    visit('/bookmarks')
    expect(page).to have_link('Makers Academy', href: 'http://www.makersacademy.com')

    click_button 'Update Me!'
    fill_in('update_url', with: 'http://www.google.co.uk')
    fill_in('update_title', with: 'Google')
    click_button 'Submit'
    expect(page).not_to have_link('Makers Academy', href: 'http://www.makersacademy.com')
    expect(page).to have_link('Google', href: 'http://www.google.co.uk')
  end
end