enum AppEnvironment { development, production }

abstract final class Environment {
  static const String name =
      String.fromEnvironment('ENV', defaultValue: 'development');

  static AppEnvironment get current => name == 'production'
      ? AppEnvironment.production
      : AppEnvironment.development;
}
