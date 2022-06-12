import 'package:test_programing/bloc/form_submission.dart';

class AuthState {
  final context;
  final String username;
  bool get isValidUsername => username.length > 3;
  final String password;
  bool get isValidPassword => password.length > 6;
  final FormSubmissionStatus formStatus;

  AuthState(
      {this.context,
      this.username = '',
      this.password = '',
      this.formStatus = const InitialFormStatus()});

  AuthState copyWith(
      {String? username, String? password, FormSubmissionStatus? formStatus}) {
    return AuthState(
        context: context ?? this.context,
        username: username ?? this.username,
        password: password ?? this.password,
        formStatus: formStatus ?? this.formStatus);
  }
}
