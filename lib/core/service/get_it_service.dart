import 'package:get_it/get_it.dart';
import '../utils/backend_endpoints.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../features/auth/domain/repos/auth_repo.dart';
import '../../features/admin/domain/repos/admin_repo.dart';
import '../../features/auth/data/repos/auth_repo_impl.dart';
import 'package:west_elbalad/core/service/data_service.dart';
import 'package:west_elbalad/core/service/firestore_service.dart';
import 'package:west_elbalad/core/service/image_picker_serivce.dart';
import 'package:west_elbalad/core/service/firebase_auth_service.dart';
import 'package:west_elbalad/features/home/domian/repos/home_repo.dart';
import 'package:west_elbalad/features/admin/data/repos/admin_repo_impl.dart';
import '../../features/used_phones/data/data_source/used_phone_data_source.dart';
import '../../features/used_phones/data/repos/used_phone_repo_Implimentation.dart';
import 'package:west_elbalad/features/used_phones/domian/repos/used_phone_repo.dart';
import 'package:west_elbalad/features/home/data/repos/home_repo_Implimentation.dart';
import '../../features/admin/data/data_sources/user_informations_local_data_source.dart';
import '../../features/admin/presentation/manager/add_in_store/edit_in_store_cubit.dart';
import 'package:west_elbalad/features/home/data/data_source/home_remote_data_source.dart';
import 'package:west_elbalad/features/used_phones/presentation/views/used_phones_view.dart';
import 'package:west_elbalad/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:west_elbalad/features/admin/presentation/manager/image_picker/image_picker_cubit.dart';
import 'package:west_elbalad/features/admin/data/data_sources/user_informations_remote_data_source.dart';


final getIt = GetIt.instance;
void setupGetIt() {
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  getIt.registerSingleton<DatabaseService>(FireStoreService());
  getIt.registerSingleton<ImagePickerService>(ImagePickerService());
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(
      firebaseAuthService: getIt.get<FirebaseAuthService>(),
      databaseService: getIt.get<DatabaseService>(),
    ),
  );
  getIt.registerSingleton<UsedPhonesRepo>(
UsedPhoneRepoImplimentation(
  imagePickerService: getIt.get<ImagePickerService>(),
  usedPhoneRemoteDataSource: UsedPhoneRemoteDataSourceImpl(
    databaseService: getIt.get<DatabaseService>(),
  )
) 
  );
  getIt.registerSingleton<AdminRepo>(
    AdminRepoImpl(
    
      userInformationsLocalDataSource: UserInformationsLocalDataSourceImpl(),
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
  getIt.registerFactory<ProfileCubit>(() => ProfileCubit(
      adminRepo: getIt.get<AdminRepo>(),
      imagePickerCubit: getIt.get<ImagePickerCubit>()));

  getIt.registerSingleton<HomeRepo>(
    HomeRepoImplimentation(
      homeRemoteDataSource: HomeRemoteDataSourceImpl(
          databaseService: getIt.get<DatabaseService>()),
    ),
  );

 final Stream<QuerySnapshot> phonesStream =
      FirebaseFirestore.instance.collection(BackendEndpoint.getPhone).snapshots();
  
  // تسجيل الـ Stream للهواتف المستعملة
  final Stream<QuerySnapshot> usedPhonesStream =
      FirebaseFirestore.instance.collection(BackendEndpoint.usedPhones).snapshots();

  // التسجيل في GetIt
  getIt.registerSingleton<Stream<QuerySnapshot>>(phonesStream, instanceName: BackendEndpoint.getPhone);
  getIt.registerSingleton<Stream<QuerySnapshot>>(usedPhonesStream, instanceName: BackendEndpoint.usedPhones);
}
