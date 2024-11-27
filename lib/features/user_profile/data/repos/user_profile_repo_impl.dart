
import 'package:west_elbalad/features/user_profile/data/data_sources/user_profile_remote_data_source.dart';


import '../../../../core/functions/get_user.dart';
import '../../domian/repos/user_profile_repo.dart';

class UserProfileRepoImpl extends UserProfileRepo{
  final UserProfileRemoteDataSource userProfileRemoteDataSource;

  UserProfileRepoImpl({required this.userProfileRemoteDataSource});
  @override
  Future<void> uploadUserImage(image) async {
   String imageUrl = await userProfileRemoteDataSource.uploadImage(image, getUser().uId);
await userProfileRemoteDataSource.addUserimagetoFirestore(getUser().uId, imageUrl);
  }
  
  @override
  Future<Map<String, dynamic>> getUserImage(String documentId) async{
    return await userProfileRemoteDataSource.getUserImage(documentId);
  }
}