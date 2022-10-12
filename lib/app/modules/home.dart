import 'package:flutter/material.dart';
import 'package:blockie_app/app/modules/project_groups.dart';
import 'package:blockie_app/app/modules/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; //记录当前选中哪个页面

  final List<Widget> _pages = [const ProjectGroups(), const UserPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.blue, //底部导航栏按钮选中时的颜色
        type: BottomNavigationBarType.fixed, //底部导航栏的适配，当item多的时候都展示出来
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "我的")
        ],
      ),
    );
  }
}
