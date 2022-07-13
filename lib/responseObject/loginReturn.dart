class LoginReturn {
  final int userId;
  final String firstName;
  final String lastName;
  final String nickName;
  final String firebaseId;
  final String passwordHash;
  final String email;
  final bool emailVerified;
  final bool notificationsEnabled;
  final String birthday;
  final bool ingestComplete;
  final String perferredPronoun;

  final String authToken;
  final String authTokenExpirationDate;

  LoginReturn({
    this.userId,
    this.firstName,
    this.lastName,
    this.nickName,
    this.firebaseId,
    this.passwordHash,
    this.email,
    this.emailVerified,
    this.notificationsEnabled,
    this.birthday,
    this.ingestComplete,
    this.perferredPronoun,
    this.authToken,
    this.authTokenExpirationDate,
  });

  factory LoginReturn.fromJson(Map<String, dynamic> json) {
    return LoginReturn(
      userId: json['userId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      nickName: json['nickName'],
      firebaseId: json['firebaseId'],
      passwordHash: json['passwordHash'],
      email: json['email'],
      emailVerified: json['emailVerified'],
      notificationsEnabled: json['notificationsEnabled'],
      birthday: json['birthday'],
      ingestComplete: json['ingestComplete'],
      perferredPronoun: json['perferredPronoun'],
      authToken: json['authToken'],
      authTokenExpirationDate: json['authTokenExpirationDate'],
    );
  }

  @override
  String toString() {
    return 'LoginReturn(userId: $userId, firstName: $firstName, lastName: $lastName, nickName: $nickName, firebaseId: $firebaseId, passwordHash: $passwordHash, email: $email, emailVerified: $emailVerified, notificationsEnabled: $notificationsEnabled, birthday: $birthday, ingestComplete: $ingestComplete, perferredPronoun: $perferredPronoun, authToken: $authToken, authTokenExpirationDate: $authTokenExpirationDate)';
  }
}
