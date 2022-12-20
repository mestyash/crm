part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.isLoading = false,
    this.isFailure = false,
    this.successfullyLoggedIn = false,
    // ----
    this.login = '',
    this.pass = '',
    this.saveUserCredentials = true,
    // ----
    this.redirectRoute = '',
  });

  final bool isLoading;
  final bool isFailure;
  final bool successfullyLoggedIn;
  // ----
  final String login;
  final String pass;
  final bool saveUserCredentials;
  // ----
  final String redirectRoute;

  bool get canSend => ![
        login.isNotEmpty,
        pass.isNotEmpty,
        !isLoading,
      ].contains(false);

  LoginState copyWith({
    bool? isLoading,
    bool? isFailure,
    bool? successfullyLoggedIn,
    // ----
    String? login,
    String? pass,
    bool? saveUserCredentials,
    // ----
    String? redirectRoute,
  }) =>
      LoginState(
        isLoading: isLoading ?? this.isLoading,
        isFailure: isFailure ?? this.isFailure,
        successfullyLoggedIn: successfullyLoggedIn ?? this.successfullyLoggedIn,
        // ----
        login: login ?? this.login,
        pass: pass ?? this.pass,
        saveUserCredentials: saveUserCredentials ?? this.saveUserCredentials,
        // ----
        redirectRoute: redirectRoute ?? this.redirectRoute,
      );

  @override
  List<Object> get props => [
        isLoading,
        isFailure,
        successfullyLoggedIn,
        // ----
        login,
        pass,
        saveUserCredentials,
        // ----
        redirectRoute,
      ];
}
