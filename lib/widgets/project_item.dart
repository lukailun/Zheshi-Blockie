import 'package:blockie_app/common/issuer_info.dart';
import 'package:flutter/material.dart';
import 'package:blockie_app/common/project_info.dart';
import 'package:blockie_app/common/project_group.dart';

const double imageItemPadding = 16;
const double imageItemSizeRatio = 0.8;

class ProjectItem extends StatelessWidget{
  ProjectInfo? projectInfo;
  ProjectGroup? projectGroup;
  final double width;
  final double height;
  ProjectItem({Key? key, this.projectInfo, this.projectGroup, required this.width, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (projectInfo == null && projectGroup == null) {
      return SizedBox(height: height);
    }

    bool isGroup = projectGroup != null;
    IssuerInfo issuer = isGroup ? projectGroup!.projects[0].issuer : projectInfo!.issuer;
    String name = isGroup ? projectGroup!.name : projectInfo!.name;
    String summary = isGroup ? projectGroup!.summary : projectInfo!.summary;

    Widget cover = isGroup ?
    Container(
      padding: const EdgeInsets.only(top: imageItemPadding, bottom: 22),
      width: width,
      height: width * imageItemSizeRatio,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: projectGroup!.projects.length + 1,
          itemBuilder: (context, index){
            if (index == 0) {
              return const SizedBox(width: imageItemPadding,);
            }
            return Container(
              padding: const EdgeInsets.only(right: imageItemPadding),
              width: width * imageItemSizeRatio,
              height: width * imageItemSizeRatio,
              child: ConstrainedBox(
                constraints: const BoxConstraints.expand(),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: Image.network(
                        projectGroup!.projects[index - 1].cover,
                        width: width * imageItemSizeRatio,
                        height: width * imageItemSizeRatio,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Positioned(
                        left: 21,
                        bottom: 13,
                        child: Text(
                          "image",
                          style: TextStyle(
                              color: Color(0xffffffff),
                              fontSize: 20
                          ),
                        )
                    )
                  ],
                ),
              ),
            );
          }),
    ) :
    ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      ),
      child: Image.network(
        projectInfo!.cover,
        fit: BoxFit.contain,
      ),
    );

    return Container(
      // margin: const EdgeInsets.only(left: 32, right: 32, bottom: 32),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/HomeCardOutline.png"),
          fit: BoxFit.cover,
        ),
        // color: const Color(0xff3C63F8),
        // border: Border.all(
        //   width: 1.0,
        //   color: const Color(0xff3c63f8),
        // ),
        // borderRadius: const BorderRadius.all(
        //   Radius.circular(8.0) //                 <--- border radius here
        // ),
        // boxShadow: const [
        //   BoxShadow(
        //     color: Color(0x1affffff),
        //     spreadRadius: 1,
        //     blurRadius: 2,
        //     offset: Offset(-1, -1), // changes position of shadow
        //   ),
        //   BoxShadow(
        //     color: Color(0x80000000),
        //     spreadRadius: 1,
        //     blurRadius: 2,
        //     offset: Offset(1, 1), // changes position of shadow
        //   )
        // ],
      ),
      width: width,
      height: height,
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Column(children: [
          cover,
          Expanded(
              child: Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          name,
                          style: const TextStyle(
                              fontSize: 20,
                              color: Color(0xffffffff),
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(2, 2),
                                  blurRadius: 2,
                                  color: Color.fromARGB(125, 0, 0, 0),
                                ),
                                Shadow(
                                  offset: Offset(-2, -2),
                                  blurRadius: 2,
                                  color: Color.fromARGB(25, 255, 255, 255),
                                ),
                              ]
                          ),
                        ),
                      ),
                      Expanded(
                          child: Text(
                            summary,
                            style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xb3ffffff)
                            ),
                          )
                      ),
                      Container(
                          padding: const EdgeInsets.only(top: 5, bottom: 3),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(right: 10),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(issuer.logo),
                                ),
                              ),
                              Expanded(
                                  child: Text(
                                      issuer.title,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xb3ffffff)
                                      )
                                  )
                              ),
                              Text(
                                  isGroup ? '' : '共发行 ${projectInfo!.totalAmount}',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xb3ffffff)
                                  )
                              )
                            ],
                          )
                      )
                    ],
                  )
              )
          )
        ],),
      ),
    );
  }

}