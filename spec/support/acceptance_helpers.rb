module AcceptanceHelper

  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end

  def create_post
    visit posts_path
    click_on 'New post'
    fill_in 'Title', with: 'Test post post'
    fill_in 'Body', with: 'text text text'
    click_on 'Create'
  end

  def create_comment(post)
    visit post_path(post)
    within '#post-link' do
      click_on 'add comment'
    end
    fill_in 'Body', with: 'My comment My comment'
    click_on 'Create'
  end

  def create_comment_to_question(question)
    click_link ('add comment'), href: "/questions/#{question.id}/comments/new"
    fill_in 'comment[body]', with: 'My comment to question'
    click_on 'Post comment'
  end

  def create_comment_to_answer(answer)
    click_link ('add comment'), href: "/answers/#{answer.id}/comments/new"
    fill_in 'comment[body]', with: 'My comment to answer'
    click_on 'Post comment'
  end

end