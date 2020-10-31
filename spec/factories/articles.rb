FactoryBot.define do
  factory :article do
    title {"タイトル"}
    open {true}
    for_engineer {true}
    for_designer {true}

    before(:create) do |article|
      article.image.attach Rack::Test::UploadedFile.new('app/assets/images/white-logo.png', 'image/png')
    end

    trait :draft do
      open {false}
    end

    trait :for_engineer_only do
      for_designer {false}
    end

    trait :for_designer_only do
      for_engineer {false}
    end
  end
end
