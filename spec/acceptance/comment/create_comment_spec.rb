require_relative '../acceptance_helper'

feature 'Create comment', %q{
  As an authenticated user
  I want to be able to create comment
} do

  given(:user) { create(:user) }
  given(:post) { create(:post) }

  scenario 'Authenticated user create post' do
    sign_in(user)

    create_comment(post)

    expect(current_path).to eq post_path(post)
    within '.comments' do
      expect(page).to have_content 'My comment My comment'
    end
  end

  scenario 'Authenticated user tries to create invalid comment' do
    sign_in(user)

    visit post_path(post)
    within '#post-link' do
      click_on 'add comment'
    end
    fill_in 'Body', with: nil
    click_on 'Create'

    expect(page).to have_content "Body can't be blank"
  end

  scenario 'Non-authenticated user tries to visit post page' do
    visit post_path(post)

    within '#post-link' do
      expect(page).not_to have_link('add comment', href: "/posts/#{post.id}/comments/new")
    end
  end

end