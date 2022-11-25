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
      EditUserInfoItem(title: '性别', content: '', placeholder: '选择性别'),
      EditUserInfoItem(title: '生日', content: '', placeholder: '选择生日'),
      EditUserInfoItem(title: '地区', content: '', placeholder: '选择你所在的地区'),
    ];
  }
}
