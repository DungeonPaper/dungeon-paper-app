enum ProviderName {
  password,
  apple,
  discord,
  facebook,
  github,
  google,
  linkedin,
  twitter,
}

ProviderName providerNameFromDomain(String domain) {
  switch (domain) {
    case 'password':
      return ProviderName.password;
    case 'apple.com':
      return ProviderName.apple;
    case 'discord.com':
      return ProviderName.discord;
    case 'facebook.com':
      return ProviderName.facebook;
    case 'github.com':
      return ProviderName.github;
    case 'google.com':
      return ProviderName.google;
    case 'linkedin.com':
      return ProviderName.linkedin;
    case 'twitter.com':
      return ProviderName.twitter;
    default:
      throw Exception('Unknown provider domain: $domain');
  }
}

String domainFromProviderName(ProviderName domain) {
  switch (domain) {
    case ProviderName.password:
      return 'password';
    case ProviderName.apple:
      return 'apple.com';
    case ProviderName.discord:
      return 'discord.com';
    case ProviderName.facebook:
      return 'facebook.com';
    case ProviderName.github:
      return 'github.com';
    case ProviderName.google:
      return 'google.com';
    case ProviderName.linkedin:
      return 'linkedin.com';
    case ProviderName.twitter:
      return 'twitter.com';
  }
}
