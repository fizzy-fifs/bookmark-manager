def add_bookmarks_to_db
  visit('/')
  # within(add_bookmarks) do
  fill_in 'add_bookmarks', with: 'www.twitter.com'
  click_button 'Submit'
  # end
end