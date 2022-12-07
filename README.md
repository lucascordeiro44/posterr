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

### Posterr Features:
* Splash
* Login (Choose User)
* Home
* User Profile

#### Libraries & Tools Used

* [Hive Database](https://github.com/hivedb/hive) (For local database)
* [Flutter Modular](https://pub.dev/packages/flutter_modular) (To design archtecture with using modularization)
* [ValueNotifier and ChangeNotifier](https://pub.dev/packages/flutter_modular) (to connect the reactive data of your application with the UI)
* [Modular](https://pub.dev/packages/flutter_modular) (State Management and dependecy injection)
* [mocktail](https://pub.dev/packages/mocktail) (to mock for tests)
* [hive_generator](https://pub.dev/packages/hive_generator) (to generate DTO Files)


#### About the Project Architecture

The project was built using Clean Arch principles and thinking about modularization, for that I used flutter_modular that helps in this separation of modules. In this way, this type of architecture will be effective in a scalable project that will be developed using multi repositories and micro services. Thinking about separation of features.
I used the Hive library as a local database due to the characteristics of the challenge, as it is actually an emulation of a Rest api, I did not see the need to use a more powerful database such as SQLite.

##### Self Critique & scaling

Como primeira melhoria, pensando em mais features, escalabilidade, mais complexidade de relacionamento e fluxo dos dados a serém persistidos, trocaria o banco de dados para um mais robusto tal como [Drift database] (https://drift.simonbinder.eu/) (based SQLite database).

Assumindo que o projeto vai se consumir dados de uma estrutura de API do tipo Rest seria importante fazer um cacheamento dos dados também para evitar recarregamentos desnecessários assim aliviando consumo na API. Outro bom ponto séria uma abordagem de WebSocket para ter uma leitura em tempo real dos dados trafegados na pagina de Home ou se não um timer definido para realizar uma comunicação via Protocolo HTTP mesmo, evitando assim queda de perfomance devido a quantidade de dados trafegados.

Como o projeto já foi pensado inicialmente em escalabilidade, a arquitetura foi inicialmente construída de forma modularizada, assim com o aumento expressivo de usuários utilizando o app, teria consequentemente um aumento de manutenção, mais desenvolvedores e novas features no projeto. Dessa forma, arquitetura de microaplicacoes e multirepositorios são uma boa abordagem para essas caracteristicas.

Após essa versão inicial seria inprescindivel implementar alguma forma de rastreio de Crashs tal como (Firebase Crashlytics or Sentry), tagueamento tal com Analytics (Google Anlytics  etc) para rastrear a jornada do usuário. Outra integração seria com alguma config remota tipo (Remote Config) para desabilitar as features em produção, ajudando na manutenção do projeto. 

Seria importante também realizar integração CI/CD, para um deploy e esteria de release automatizado, utilizando frameworks tais como Codemagic, AppCenter, Firebase  etc. Assim facilitando e tornando mais seguro o processo de desenvolvimento e release. Poderia fazer triggers com o PR no repositorio, gerando builds automticos. 
Preparando passos para rodar os testes unitarios e de integração.

