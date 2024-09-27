import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../domian/repos/shopping_cart.repo.dart';


part 'finish_order_state.dart';

class FinishOrderCubit extends Cubit<FinishOrderState> {
  FinishOrderCubit(this.shoppingCartRepo) : super(FinishOrderInitial());
 final  ShoppingCartRepo  shoppingCartRepo;
  void finishOrder(Map<String, dynamic> data)async {
    emit(FinishOrderLoading());
     try {
       await   shoppingCartRepo.addOrder(data: data);
       emit(FinishOrderSuccess());
     }catch (e) {
       emit(FinishOrderFailure( e.toString()));
     }
 
  }
}
