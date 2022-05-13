# gao_wang 高王观世音

git add .
git commit -m "base code"
git push -u origin master

flutter clean
flutter pub get

## Generate icon
flutter pub run flutter_launcher_icons:main

rm -rf android/
rm -rf ios/
flutter create .

## Build release app
flutter build appbundle --build-name 1.0.0 --build-number 10000

flutter pub run change_app_package_name:main org.cyf.gaowang