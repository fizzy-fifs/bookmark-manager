def add_bookmarks_to_db
  visit('/')
  # within(add_bookmarks) do
  fill_in 'enter_url', with: 'www.twitter.com'
  fill_in 'enter_title', with: 'Twitter'
  click_button 'Submit'
  # end
end