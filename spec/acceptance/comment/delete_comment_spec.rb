require_relative '../acceptance_helper'

feature 'Delete comment', %q{
   As authenticated user
   I want to be able to delete my comment
} do

  given(:user) {create(:user)}
  given!(:post) {create(:post, user: user)}
  given!(:comment) {create(:comment, post: post, user: user)}
  given(:another_user) {create(:user)}

  scenario 'Authenticated user deletes your comment', js: true do
    sign_in(user)
    visit post_path(post)

    expect(page).to have_link('delete', href: "/posts/#{post.id}/comments/#{comment.id}")

    within '.comments' do
      click_link ('delete'), href: "/posts/#{post.id}/comments/#{comment.id}"
      page.driver.browser.accept_js_confirms

      expect(page).not_to have_content comment.body
    end
    expect(current_path).to eq post_path(post)
  end

  scenario 'Another authenticated user tries to delete comment' do
    sign_in(another_user)
    visit post_path(post)

    expect(page).not_to have_link('delete', href: "/posts/#{post.id}/comments/#{comment.id}")
  end

  scenario 'Non-authenticated user tries to delete comment' do
    visit post_path(post)
    expect(page).not_to have_link('delete', href: "/posts/#{post.id}/comments/#{comment.id}")
  end

end