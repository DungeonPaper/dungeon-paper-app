class MigrationDetails {
  final String email;
  final String username;
  final String language;

  MigrationDetails({
    required this.email,
    required this.username,
    required this.language,
  });

  Map<String, dynamic> toJson() => {
        'user': email,
        'username': username,
        'language': language,
      };

  @override
  String toString() => Uri(queryParameters: toJson()).query;
}
