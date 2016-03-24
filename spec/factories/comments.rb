FactoryGirl.define do
  factory :comment do
    body "MyTextMyText"
    user
    post
  end

  factory :comment_old, class: "Comment" do
    body "MyTextMyText"
    created_at Time.now - 16.minutes
    user
    post
  end
end
