import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../home/data/model/phones_model.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import '../../../../../core/functions/calculate_total_price.dart';
import 'package:west_elbalad/core/service/shared_preferences_singleton.dart';
import 'package:west_elbalad/features/home/domian/entites/phone_entites.dart';
import 'package:west_elbalad/core/functions/save_and_get_map_to_list_with_shared_pref.dart';


part 'show_orders_state.dart';

class ShowOrdersCubit extends Cubit<ShowOrdersState> {
  ShowOrdersCubit() : super(ShowOrdersInitial());

  void fetchOrders()async {
    emit(ShowOrdersLoading());
    List<Map<String, dynamic>> data= await getListOfMapsFromSharedPref(kOrder);
        final List<PhoneEntites> orders = data.map((data) {
      return PhoneModel.fromMap(data);
    }).toList();
    SharedPref.setInt(kTotalPrice,calculateTotalPrice(orders));
    emit(ShowOrdersSuccess( orders));
  }
}

