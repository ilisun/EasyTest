require_relative '../acceptance_helper'

feature 'Edit comment', %q{
  As an author of comment
  I want to be edit my comment
} do

  given(:user) {create(:user)}
  given!(:post) {create(:post, user: user)}
  given!(:comment) {create(:comment, post: post, user: user)}
  given(:another_user) {create(:user)}

  describe 'Authenticated user as author of comment' do
    before do
      sign_in(user)
      visit post_path(post)
    end

    scenario 'Author of comment sees edit link for comment' do
      within '.comments' do
        expect(page).to have_link('edit', href: "/posts/#{post.id}/comments/#{comment.id}/edit")
      end
    end

    scenario 'Author of answer want to be edit answer' do
      within '.comments' do
        click_link ('edit'), href: "/posts/#{post.id}/comments/#{comment.id}/edit"
      end

      fill_in 'Body', with: "New body for answer"
      click_on 'Create'

      expect(current_path).to eq post_path(post)
      expect(page).to have_content 'Your comment successfully fixed.'
      expect(page).to have_content 'New body for answer'
    end
  end

  scenario 'Not the author, dont want to be edit question' do
    sign_in(another_user)
    visit post_path(post)

    within '.comments' do
      expect(page).not_to have_link('edit', href: "/posts/#{post.id}/comments/#{comment.id}/edit")
    end
  end

end