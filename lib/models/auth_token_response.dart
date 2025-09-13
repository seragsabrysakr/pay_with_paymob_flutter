/// Model for authentication token response
class AuthTokenResponse {
  /// User profile information
  final UserProfile profile;
  
  /// Authentication token
  final String token;
  
  /// Profile token
  final String profileToken;

  const AuthTokenResponse({
    required this.profile,
    required this.token,
    required this.profileToken,
  });

  /// Create AuthTokenResponse from JSON
  factory AuthTokenResponse.fromJson(Map<String, dynamic> json) {
    return AuthTokenResponse(
      profile: UserProfile.fromJson(json['profile'] as Map<String, dynamic>),
      token: json['token'] as String,
      profileToken: json['profile_token'] as String,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'profile': profile.toJson(),
      'token': token,
      'profile_token': profileToken,
    };
  }

  @override
  String toString() {
    return 'AuthTokenResponse(token: ${token.substring(0, 20)}..., profileToken: ${profileToken.substring(0, 20)}...)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthTokenResponse &&
        other.profile == profile &&
        other.token == token &&
        other.profileToken == profileToken;
  }

  @override
  int get hashCode {
    return Object.hash(profile, token, profileToken);
  }
}

/// User profile model
class UserProfile {
  /// Profile ID
  final int id;
  
  /// User information
  final User user;
  
  /// Creation timestamp
  final DateTime createdAt;
  
  /// Whether profile is active
  final bool active;
  
  /// Profile type
  final String profileType;
  
  /// Phone numbers
  final List<String> phones;
  
  /// Company emails
  final List<String> companyEmails;
  
  /// Company name
  final String companyName;
  
  /// State
  final String state;
  
  /// Country
  final String country;
  
  /// City
  final String city;
  
  /// Postal code
  final String postalCode;
  
  /// Street address
  final String street;
  
  /// Email notification enabled
  final bool emailNotification;
  
  /// Logo URL
  final String? logoUrl;
  
  /// Sector
  final String sector;
  
  /// Primary phone number
  final String primaryPhoneNumber;
  
  /// Whether primary phone is verified
  final bool primaryPhoneVerified;

  const UserProfile({
    required this.id,
    required this.user,
    required this.createdAt,
    required this.active,
    required this.profileType,
    required this.phones,
    required this.companyEmails,
    required this.companyName,
    required this.state,
    required this.country,
    required this.city,
    required this.postalCode,
    required this.street,
    required this.emailNotification,
    this.logoUrl,
    required this.sector,
    required this.primaryPhoneNumber,
    required this.primaryPhoneVerified,
  });

  /// Create UserProfile from JSON
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as int,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['created_at'] as String),
      active: json['active'] as bool,
      profileType: json['profile_type'] as String,
      phones: List<String>.from(json['phones'] as List),
      companyEmails: List<String>.from(json['company_emails'] as List),
      companyName: json['company_name'] as String,
      state: json['state'] as String,
      country: json['country'] as String,
      city: json['city'] as String,
      postalCode: json['postal_code'] as String,
      street: json['street'] as String,
      emailNotification: json['email_notification'] as bool,
      logoUrl: json['logo_url'] as String?,
      sector: json['sector'] as String,
      primaryPhoneNumber: json['primary_phone_number'] as String,
      primaryPhoneVerified: json['primary_phone_verified'] as bool,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user.toJson(),
      'created_at': createdAt.toIso8601String(),
      'active': active,
      'profile_type': profileType,
      'phones': phones,
      'company_emails': companyEmails,
      'company_name': companyName,
      'state': state,
      'country': country,
      'city': city,
      'postal_code': postalCode,
      'street': street,
      'email_notification': emailNotification,
      'logo_url': logoUrl,
      'sector': sector,
      'primary_phone_number': primaryPhoneNumber,
      'primary_phone_verified': primaryPhoneVerified,
    };
  }

  @override
  String toString() {
    return 'UserProfile(id: $id, profileType: $profileType, companyName: $companyName, country: $country)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserProfile &&
        other.id == id &&
        other.user == user &&
        other.createdAt == createdAt &&
        other.active == active &&
        other.profileType == profileType &&
        other.phones.toString() == phones.toString() &&
        other.companyEmails.toString() == companyEmails.toString() &&
        other.companyName == companyName &&
        other.state == state &&
        other.country == country &&
        other.city == city &&
        other.postalCode == postalCode &&
        other.street == street &&
        other.emailNotification == emailNotification &&
        other.logoUrl == logoUrl &&
        other.sector == sector &&
        other.primaryPhoneNumber == primaryPhoneNumber &&
        other.primaryPhoneVerified == primaryPhoneVerified;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      user,
      createdAt,
      active,
      profileType,
      phones,
      companyEmails,
      companyName,
      state,
      country,
      city,
      postalCode,
      street,
      emailNotification,
      logoUrl,
      sector,
      primaryPhoneNumber,
      primaryPhoneVerified,
    );
  }
}

/// User model
class User {
  /// User ID
  final int id;
  
  /// Username
  final String username;
  
  /// First name
  final String firstName;
  
  /// Last name
  final String lastName;
  
  /// Date joined
  final DateTime dateJoined;
  
  /// Email
  final String email;
  
  /// Whether user is active
  final bool isActive;
  
  /// Whether user is staff
  final bool isStaff;
  
  /// Whether user is superuser
  final bool isSuperuser;
  
  /// Last login
  final DateTime? lastLogin;

  const User({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.dateJoined,
    required this.email,
    required this.isActive,
    required this.isStaff,
    required this.isSuperuser,
    this.lastLogin,
  });

  /// Create User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['username'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      dateJoined: DateTime.parse(json['date_joined'] as String),
      email: json['email'] as String,
      isActive: json['is_active'] as bool,
      isStaff: json['is_staff'] as bool,
      isSuperuser: json['is_superuser'] as bool,
      lastLogin: json['last_login'] != null ? DateTime.parse(json['last_login'] as String) : null,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'date_joined': dateJoined.toIso8601String(),
      'email': email,
      'is_active': isActive,
      'is_staff': isStaff,
      'is_superuser': isSuperuser,
      'last_login': lastLogin?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'User(id: $id, username: $username, email: $email, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User &&
        other.id == id &&
        other.username == username &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.dateJoined == dateJoined &&
        other.email == email &&
        other.isActive == isActive &&
        other.isStaff == isStaff &&
        other.isSuperuser == isSuperuser &&
        other.lastLogin == lastLogin;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      username,
      firstName,
      lastName,
      dateJoined,
      email,
      isActive,
      isStaff,
      isSuperuser,
      lastLogin,
    );
  }
}
