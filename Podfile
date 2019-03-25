platform :ios, '10.0'

use_frameworks!

workspace 'DisneyWikiFeatures'

project 'data/data.xcodeproj'
project 'app/app.xcodeproj'
project 'base/base.xcodeproj'
project 'Features/characterList.xcodeproj'
project 'Features/characterDetails.xcodeproj'
project 'Features/moviesList.xcodeproj'


def rx_pods
  pod 'RxSwift'
  pod 'RxCocoa'
end

def network_pods
  pod 'Moya/RxSwift'
  pod 'Moya-ObjectMapper/RxSwift'
end

def ui_pods
  pod 'Cartography'
  pod 'Kingfisher'
end

def feature_targets targets
  targets.each do |target_name|
    target target_name do
      project "#{target_name}/#{target_name}.xcodeproj"
      ui_pods
      rx_pods
    end
  end
end

target 'data' do
  project 'data/data.xcodeproj'
  network_pods
end

target 'app' do
  project 'app/app.xcodeproj'
  ui_pods
  network_pods
  rx_pods
end

target 'base' do
  project 'base/base.xcodeproj'
  rx_pods
end

target 'UI' do
  project 'UI/UI.xcodeproj'
  pod 'Kingfisher'
end

feature_targets ['characterList', 'characterDetails', 'moviesList', 'movieDetails']

# target 'characterList' do
#   project 'characterList/characterList.xcodeproj'
#   ui_pods
#   rx_pods
# end

# target 'characterDetails' do
#     project 'characterDetails/characterDetails.xcodeproj'
#     ui_pods
#     rx_pods
# end

# target 'moviesList' do
#   project 'moviesList/moviesList.xcodeproj'
#   ui_pods
#   rx_pods
# end

# target 'movieDetails' do
#   project 'movieDetails/movieDetails.xcodeproj'
#   ui_pods
#   rx_pods
# end
