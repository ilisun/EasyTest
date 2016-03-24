require_relative '../acceptance_helper'

feature 'Delete post', %q{
   As authenticated user
   I want to be able to delete my  post
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
        expect(page).to have_link('delete', href: "/posts/#{post.id}")
      end
    end

    scenario 'Author of post want to be delete post' do
      within '#post-link' do
        click_link ('delete'), href: "/posts/#{post.id}"
      end
      expect(current_path).to eq posts_path
      expect(page).not_to have_content post.title
      expect(page).to have_content 'Your post is successfully deleted.'
    end

  end

  scenario 'Not the author, dont want to be delete post' do
    sign_in(another_user)
    visit post_path(post)
    within '#post-link' do
      expect(page).not_to have_link('delete', href: "/posts/#{post.id}")
    end
  end

end