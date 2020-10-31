FactoryBot.define do
  factory :feature do
    title {"Rails"}
    details {"Railsに関する特集です"}
    for_engineer {true}
    for_designer {true}

    before(:create) do |feature|
      feature.image.attach Rack::Test::UploadedFile.new('app/assets/images/white-logo.png', 'image/png')
    end
  end
end
