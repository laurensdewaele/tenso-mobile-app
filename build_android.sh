echo Building for android...
flutter build appbundle
echo Running fastlane
cd ./android/fastlane
fastlane release
cd ../