# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    text "we are you going? today"
    to_user factory: :user
    from_user factory: :user
  end
end
