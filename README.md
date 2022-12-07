# Posterr

Posterr is very similar to Twitter, but it has far fewer
features.
Posterr only has two screens, the home (default), and the user profile screen, which
are described below. Other data and actions are also detailed below.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


A Posterr project created in flutter using FLutter Modular, Hive DB and Value Notifier. Posterr supports both web and mobile, clone the appropriate branches mentioned below:
```
[Branch Master]
```

## How to Use 

**Step 1:**

To run this project you should have installed in your machine the flutter SDk:
```
version >= 3.3.4
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies: 

```
flutter pub get 
```

**Step 3:**

This project uses `inject` library that works with code generation, execute the following command to generate files:

```
flutter packages pub run build_runner build --delete-conflicting-outputs
```

or watch command in order to keep the source code synced automatically:

```
flutter packages pub run build_runner watch
```

**Step 4:**
```
flutter run android
flutter run ios
```

## Posterr Features:
* Splash
* Login (Choose User)
* Home
* User Profile

## Libraries & Tools Used

* [Hive Database](https://github.com/hivedb/hive) (For local database)
* [Flutter Modular](https://pub.dev/packages/flutter_modular) (To design archtecture with using modularization)
* [ValueNotifier and ChangeNotifier](https://pub.dev/packages/flutter_modular) (to connect the reactive data of your application with the UI)
* [Modular](https://pub.dev/packages/flutter_modular) (State Management and dependecy injection)
* [mocktail](https://pub.dev/packages/mocktail) (to mock for tests)
* [hive_generator](https://pub.dev/packages/hive_generator) (to generate DTO Files)


## About the Project Architecture

The project was built using Clean Architecture principles and thinking about modularization, for that I used flutter_modular that helps in this separation of modules. In this way, this type of architecture will be effective in a scalable project that will be developed using multi repositories and micro services. Thinking about separation of features.
I used the Hive library as a local database due to the characteristics of the challenge, as it is actually an emulation of a Rest api, I did not see the need to use a more powerful database such as SQLite.

Each module has its own routes and its own dependencies, I tried as much as possible to make the modules independent.

## Self Critique & scaling

As a first improvement, thinking about more features, scalability, more relationship complexity and data flow to be persisted, I would change the database to a more robust one such as [Drift database] (https://drift.simonbinder.eu/) (based SQLite database).

Assuming that the project will consume data from a Rest-type API structure, it would be important to also cache the data to avoid unnecessary reloads, thus alleviating API consumption. Another good point is a WebSocket approach to have a real-time reading of the data transmitted on the Home page or if not a defined timer to carry out communication via the HTTP Protocol itself, thus avoiding a drop in performance due to the amount of data transmitted.

Another way to improve performance and avoid traffic overload in the case of many users using it would be to develop a pagination system to load the home content and the user's feed.

As the project was initially thought about scalability, the architecture was initially built in a modularized way, so with the significant increase in users using the app, there would consequently be an increase in maintenance, more developers and new features in the project. Thus, microapplication and multirepository architecture are a good approach for these characteristics.

In the case of an app made for a company and with a business purpose, it is different from this one. It would have a more efficient approach in the communication between the modules, using a Stream Channel that would work as a transmitter of messages between the modules. In this way, making the modules more independent, enabling a decentralized construction between the devs.

After this initial version, it would be essential to implement some form of Crash tracking such as (Firebase Crashlytics or Sentry), tagging such as Analytics (Google Anlytics etc) to track the user's journey. Another integration would be with some type of remote config (Remote Config) to disable features in production, helping with project maintenance.

It would also be important to carry out CI/CD integration, for an automated deploy and release process, using frameworks such as Codemagic, AppCenter, Firebase, etc. Thus facilitating and making the development and release process safer. I could make triggers with the PR in the repository, generating automatic builds.
Preparing steps to run unit and integration tests.



