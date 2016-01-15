FactoryGirl.define do
  factory :image_asset do
    title { FFaker::Name.name }
    anchor_x { 3 }
    anchor_y { 4 }
    user
  end

end
