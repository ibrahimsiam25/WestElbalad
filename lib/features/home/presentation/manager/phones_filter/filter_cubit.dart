import 'package:flutter_bloc/flutter_bloc.dart';

class FilterListCubit extends Cubit<int> {
  FilterListCubit() : super(0);

  void selectIndex(int index) {
    emit(index);
  }
}
