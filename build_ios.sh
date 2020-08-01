echo Building for ios...
flutter build ios --release --no-codesign
echo Running fastlane
cd ./ios/fastlane
fastlane release
cd ../