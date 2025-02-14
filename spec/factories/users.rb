
FactoryBot.define do 
    factory :user do
        sequence(:email) { |n| "john#{n}@example.com"}
        password { "password"}

        after(:build) do |user|
            user.profile_picture.attach(
                io:File.open(Rails.root.join(
                    'spec', 'fixtures', 'files', 'test_profile.jpg'
                )),
                filename: 'test_profile.jpg',
                content_type: 'image/jpeg'
            )
        end
    end
end