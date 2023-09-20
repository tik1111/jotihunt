# jotihunt

Jotihunt App voor iPhone, Android en Web

## One-time setup
- Install Dart: https://dart.dev/get-dart
- Install Flutter: https://docs.flutter.dev/get-started/install
  - For mac, use `brew install --cask flutter`
  - For the mac, Flutter will install Dart for you, so you don't need to do that separately
- Run `flutter pub get` in the root of the project

## Dev setup

Create an `.env` file in your root:
```
# This should be a reference to a (running) Jotihunt API Server
# Production for example is https://2023.jotihunters.nl/
API_ROOT=
```

## Running the app

### Web app (development)
- Run `flutter run -d chrome` in the root of the project

### Web app (production)
- Run `flutter build web` in the root of the project
- The output will be in `build/web`

## Setup for CloudFlare Pages
Using `peanut` to setup the project for static usage
- Setup: `flutter pub global activate peanut`
- Create/update branch: `flutter pub global run peanut -b static-site`
  - Ensure that the `.env` file is in the root of the project (or a proper env variable is set during build)!
