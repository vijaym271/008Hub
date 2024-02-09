class Environment {
  const Environment();
  static const env = String.fromEnvironment('env');
  static const baseUrl = String.fromEnvironment('baseUrl');
}
