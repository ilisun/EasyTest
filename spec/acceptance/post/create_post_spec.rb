require_relative '../acceptance_helper'

feature 'Create post', %q{
  As an authenticated user
  I want to be able to write post
} do

  given(:user) { create(:user) }

  scenario 'Authenticated user create the post' do
    sign_in(user)

    create_post

    expect(page).to have_content 'Your post successfully created.'
  end

  scenario 'Authenticated user create invalid post' do
    sign_in(user)

    visit posts_path
    click_on 'New post'
    fill_in 'Title', with: ' '
    click_on 'Create'

    expect(page).to have_content "Title can't be blankBody can't be blank"
  end

  scenario 'Non-authenticated user try to create post' do
    visit posts_path
    click_on 'New post'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end