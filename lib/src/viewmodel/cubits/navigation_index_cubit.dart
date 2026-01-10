import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationIndexCubit extends Cubit<int>{

  NavigationIndexCubit() : super(0);

  void indexChanged(int i){
    emit(i);
  }

}