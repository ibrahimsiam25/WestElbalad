import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../domain/repos/admin_repo.dart';
import 'package:west_elbalad/features/shopping_cart/domian/entites/user_info_for_order_entities.dart';


part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this.adminRepo) : super(OrdersInitial());
  final AdminRepo adminRepo;

  Future<void> fetchOrdersData() async {
    emit(OrdersLoading());
    final result = await adminRepo.fetchOrdersData();

    result.fold(
      (failure) => emit(OrdersFailure(message: failure.message)),
      (orders) => emit(OrdersSuccess(ordersList: orders)),
    );
  }

  Future<void> deleteOrderData(String id) async {
    final result = await adminRepo.deleteOrderData(id);
    result.fold(
      (failure) => emit(OrdersFailure(message: failure.message)),
      (Null) {
        fetchOrdersData();
        emit(OrdersRemoveSuccess());
      },
    );
  }
}
