import 'package:bloc/bloc.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState(isLoading: false)) {
    on<OnLogin>((event, emit) {
     emit(state.copyWith(isLoading: true));
     if(event.password=='123456'){
      final i=event.user.indexOf('@');
      final user=event.user.substring(0,i);
      final userCapitalize= user[0].toUpperCase() + user.substring(1);
     
      emit(state.copyWith(user:userCapitalize,isLoading: false,isAuth: true));
     }else{
     
      emit(state.copyWith(isLoading: false,isAuth: false));
     }
    });
   
   on <OnChangeTheme>((event, emit) {
state.isThemeLight? emit(state.copyWith(isThemeLight: false)) : emit(state.copyWith(isThemeLight: true));
   });

  on<OnLogOut> ((event, emit) {
   emit(state.copyWith(isAuth: false,user: null,isThemeLight: true));
  });
  }
}
