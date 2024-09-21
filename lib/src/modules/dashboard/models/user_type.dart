enum UserType {
  loggedInUser("loggedInUser"),
  guest("guest");

  final String rawString;
  const UserType(this.rawString);

  static UserType? getUserType({required String typeAsString}) {
    switch (typeAsString) {
      case "loggedInUser":
        return UserType.loggedInUser;
      case "guest":
        return UserType.guest;
    }
    return null;
  }
}
