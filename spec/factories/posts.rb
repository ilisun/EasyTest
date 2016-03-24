FactoryGirl.define do
  factory :post do
    title "MyStringMyString"
    body "MyTextMyText"
    publish true
    user
  end

  factory :post_not_published do
    title "MyStringMyString"
    body "MyTextMyText"
    publish false
    user
  end
end
