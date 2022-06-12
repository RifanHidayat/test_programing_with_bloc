abstract class AuthEvent {}

class AuthUsernameChange extends AuthEvent {
  final String username;

  AuthUsernameChange(this.username);
}

class AuthPasswordChange extends AuthEvent {
  final String password;

  AuthPasswordChange(this.password);
}

class AuthContext extends AuthEvent {
  final context;

  AuthContext(this.context);
}

class AuthSubmitted extends AuthEvent {}
