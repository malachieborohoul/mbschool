part of 'app_user_cubit.dart';

sealed class AppUserState extends Equatable {
  const AppUserState();

  @override
  List<Object> get props => [];
}

final class AppUserInitial extends AppUserState {}
final class AppUserLoading extends AppUserState {}


final class AppUserLoggedIn extends AppUserState {
  final User user;

  const AppUserLoggedIn(this.user);
  
}
