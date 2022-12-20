// Project imports:
import 'package:blockie_app/app/modules/profile/models/profile.dart';
import 'package:blockie_app/app/modules/profile/models/profile_label.dart';
import 'package:blockie_app/data/apis/blockie_api/blockie_api.dart';
import 'package:blockie_app/data/models/user_info.dart';

class ProfileRepository {
  final BlockieApi remoteApi;

  ProfileRepository({required this.remoteApi});

  Future<Profile?> getProfile() => remoteApi.getProfile();

  Future<List<ProfileLabel>?> getAllLabels() => remoteApi.getAllLabels();

  Future<List<ProfileLabel>?> updateLabels(List<String> ids) =>
      remoteApi.updateLabels(ids);
}
