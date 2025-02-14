
FactoryBot.define do
    factory :book do
        title { "The Great Gatsby"}
        author {"F. Scott Fitzgerald"}
        isbn {"12344566423"}

        after(:build) do |book|
            book.image.attach(
                io: File.open(Rails.root.join(
                    'spec', 'fixtures', 'files', 'test_image.jpg')),
                    filename: 'test_image.jpg',
                    content_type: "image/jpeg"       
            )
        end
    end
end