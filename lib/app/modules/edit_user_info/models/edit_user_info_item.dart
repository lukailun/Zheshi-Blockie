// Project imports:
import 'package:blockie_app/data/models/gender.dart';
import 'package:blockie_app/data/models/user_info.dart';

class EditUserInfoItem {
  final String title;
  final String? content;
  final String? placeholder;
  final Function()? onTap;

  EditUserInfoItem({
    required this.title,
    this.content,
    this.placeholder,
    this.onTap,
  });

  static List<EditUserInfoItem> initial({
    required UserInfo userInfo,
    required Function() usernameOnTap,
    required Function() bioOnTap,
    required Function() genderOnTap,
    required Function() birthdayOnTap,
    required Function() regionOnTap,
  }) {
    return [
      EditUserInfoItem(
        title: '名字',
        content: userInfo.username,
        onTap: usernameOnTap,
      ),
      EditUserInfoItem(title: 'Blockie ID', content: userInfo.id),
      EditUserInfoItem(
        title: '简介',
        content: userInfo.bio,
        placeholder: '用一句话介绍下自己吧~',
        onTap: bioOnTap,
      ),
      EditUserInfoItem(
        title: '性别',
        content: userInfo.gender.displayName,
        placeholder: '选择性别',
        onTap: genderOnTap,
      ),
      EditUserInfoItem(
        title: '生日',
        content: userInfo.birthday?.dateString,
        placeholder: '选择生日',
        onTap: birthdayOnTap,
      ),
      EditUserInfoItem(
        title: '地区',
        content: userInfo.region?.region,
        placeholder: '选择你所在的地区',
        onTap: regionOnTap,
      ),
    ];
  }
}
