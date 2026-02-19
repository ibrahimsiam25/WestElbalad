import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:west_elbalad/core/manager/fetch_user_image/fetch_user_image_cubit.dart';
import 'package:west_elbalad/features/user_profile/domian/repos/user_profile_repo.dart';
import '../../features/user_profile/data/data_sources/user_profile_remote_data_source.dart';
import '../../features/user_profile/data/repos/user_profile_repo_impl.dart';
import '../utils/backend_endpoints.dart';
import '../../features/auth/domain/repos/auth_repo.dart';
import '../../features/admin/domain/repos/admin_repo.dart';
import '../../features/auth/data/repos/auth_repo_impl.dart';
import 'package:west_elbalad/core/service/data_service.dart';
import 'package:west_elbalad/core/service/supabase_database_service.dart';
import 'package:west_elbalad/core/service/image_picker_serivce.dart';
import 'package:west_elbalad/core/service/supabase_auth_service.dart';
import 'package:west_elbalad/features/home/domian/repos/home_repo.dart';
import '../../features/shopping_cart/domian/repos/shopping_cart.repo.dart';
import 'package:west_elbalad/features/admin/data/repos/admin_repo_impl.dart';
import '../../features/shopping_cart/data/repos/shopping_cart_repo_impl.dart';
import '../../features/used_phones/data/data_source/used_phone_data_source.dart';
import '../../features/used_phones/data/repos/used_phone_repo_Implimentation.dart';
import 'package:west_elbalad/features/home/data/repos/home_repo_Implimentation.dart';
import 'package:west_elbalad/features/used_phones/domian/repos/used_phone_repo.dart';
import '../../features/admin/presentation/manager/add_in_store/edit_in_store_cubit.dart';
import 'package:west_elbalad/features/home/data/data_source/home_remote_data_source.dart';
import 'package:west_elbalad/core/manager/image_picker/image_picker_cubit.dart';
import 'package:west_elbalad/features/admin/data/data_sources/user_informations_remote_data_source.dart';
import 'package:west_elbalad/features/shopping_cart/data/data_source/shopping_cart_remote_data_source.dart';

final getIt = GetIt.instance;
void setupGetIt() {
  getIt.registerSingleton<SupabaseAuthService>(SupabaseAuthService());
  getIt.registerSingleton<DatabaseService>(SupabaseDatabaseService());
  getIt.registerSingleton<ImagePickerService>(ImagePickerService());

  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(
      supabaseAuthService: getIt.get<SupabaseAuthService>(),
      databaseService: getIt.get<DatabaseService>(),
    ),
  );

  getIt.registerSingleton<UserProfileRepo>(UserProfileRepoImpl(
      userProfileRemoteDataSource: UserProfileRemoteDataSourceImpl(
    databaseService: getIt.get<DatabaseService>(),
  )));
  getIt.registerSingleton<FetchUserImageCubit>(FetchUserImageCubit(
    getIt.get<UserProfileRepo>(),
  ));
  getIt.registerSingleton<ShoppingCartRepo>(
    ShoppingCardRepoImpl(
        shoppingCartRemoteDataSource: ShoppingCartRemoteDataSourceImpl(
      databaseService: getIt.get<DatabaseService>(),
    )),
  );
  getIt.registerSingleton<UsedPhonesRepo>(UsedPhoneRepoImplimentation(
      imagePickerService: getIt.get<ImagePickerService>(),
      usedPhoneRemoteDataSource: UsedPhoneRemoteDataSourceImpl(
        databaseService: getIt.get<DatabaseService>(),
      )));
  getIt.registerSingleton<AdminRepo>(
    AdminRepoImpl(
      userInformationsRemoteDataSource: UserInformationsRemoteDataSourceImpl(
          databaseService: getIt.get<DatabaseService>()),
      imagePickerService: getIt.get<ImagePickerService>(),
    ),
  );
  getIt.registerFactory<ImagePickerCubit>(
      () => ImagePickerCubit(getIt.get<AdminRepo>()));
  getIt.registerFactory<AddInStoreCubit>(() => AddInStoreCubit(
      adminRepo: getIt.get<AdminRepo>(),
      imagePickerCubit: getIt.get<ImagePickerCubit>()));

  getIt.registerSingleton<HomeRepo>(
    HomeRepoImplimentation(
      homeRemoteDataSource: HomeRemoteDataSourceImpl(
          databaseService: getIt.get<DatabaseService>()),
    ),
  );

  final Stream<List<Map<String, dynamic>>> phonesStream =
      Supabase.instance.client.from('phones').stream(primaryKey: ['id']);

  final Stream<List<Map<String, dynamic>>> usedPhonesStream =
      Supabase.instance.client.from('used_phones').stream(primaryKey: ['id']);

  getIt.registerSingleton<Stream<List<Map<String, dynamic>>>>(
    phonesStream,
    instanceName: BackendEndpoint.newPhone,
  );
  getIt.registerSingleton<Stream<List<Map<String, dynamic>>>>(
    usedPhonesStream,
    instanceName: BackendEndpoint.usedPhones,
  );
}
