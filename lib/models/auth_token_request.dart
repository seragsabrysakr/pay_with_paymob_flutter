/// Model for authentication token request
class AuthTokenRequest {
  /// Username for authentication
  final String username;
  
  /// Password for authentication
  final String password;

  const AuthTokenRequest({
    required this.username,
    required this.password,
  });

  /// Convert to JSON for API request
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }

  @override
  String toString() {
    return 'AuthTokenRequest(username: $username)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthTokenRequest &&
        other.username == username &&
        other.password == password;
  }

  @override
  int get hashCode {
    return Object.hash(username, password);
  }
}
