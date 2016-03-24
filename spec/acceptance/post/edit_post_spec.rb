require_relative '../acceptance_helper'

feature 'Edit post', %q{
  As an author of post
  I want to be edit my post
} do

  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given(:post) {create(:post, user: user)}

  describe 'Authenticated user as author of post' do

    before do
      sign_in(user)
      visit post_path(post)
    end

    scenario 'Author of post sees edit link for post' do
      within '#post-link' do
        expect(page).to have_link('edit')
      end
    end

    scenario 'Author of post want to be edit post' do
      within '#post-link' do
        click_on 'edit'
      end
      fill_in 'Title', with: "New title for question"
      fill_in 'Body', with: "New body for question"
      click_on 'Create'

      expect(current_path).to eq post_path(post)
      expect(page).to have_content 'Your post successfully fixed.'
      expect(page).to have_content 'New title for question'
      expect(page).to have_content 'New body for question'
    end

  end

  scenario 'Not the author, dont want to be edit post' do
    sign_in(another_user)
    visit post_path(post)
    within '#post-link' do
      expect(page).not_to have_link('edit')
    end
    visit edit_post_path(post)
    expect(page).to have_content 'You are not authorized to access this page.'
  end

end