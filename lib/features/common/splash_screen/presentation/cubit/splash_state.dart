part of 'splash_cubit.dart';

class SplashState extends Equatable {
  const SplashState({
    this.isAuthenticated,
    this.isUnauthenticated,
    // ----
    this.redirectRoute = '',
  });

  final bool? isAuthenticated;
  final bool? isUnauthenticated;
  // ----
  final String redirectRoute;

  SplashState copyWith({
    bool? isAuthenticated,
    bool? isUnauthenticated,
    // ----
    String? redirectRoute,
  }) =>
      SplashState(
        isAuthenticated: isAuthenticated ?? this.isAuthenticated,
        isUnauthenticated: isUnauthenticated ?? this.isUnauthenticated,
        // ----
        redirectRoute: redirectRoute ?? this.redirectRoute,
      );

  @override
  List<Object?> get props => [
        isAuthenticated,
        isUnauthenticated,
        // ----
        redirectRoute,
      ];
}
