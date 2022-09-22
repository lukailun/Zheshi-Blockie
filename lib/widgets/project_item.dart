import 'package:blockie_app/common/issuer_info.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:blockie_app/common/project_info.dart';
import 'package:blockie_app/common/project_group.dart';

const double imageItemPadding = 16;
const double groupImageWidth = 280;

class ProjectItem extends StatelessWidget{
  ProjectInfo? projectInfo;
  ProjectGroup? projectGroup;
  bool showBrand;
  ProjectItem({Key? key, this.projectInfo, this.projectGroup, this.showBrand=true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (projectInfo == null && projectGroup == null) {
      return const SizedBox(height: 0);
    }

    bool isGroup = projectGroup != null;
    IssuerInfo issuer = isGroup ? projectGroup!.projects[0].issuer : projectInfo!.issuer;
    String name = isGroup ? projectGroup!.name : projectInfo!.name;
    String summary = isGroup ? projectGroup!.summary : projectInfo!.summary;

    double summaryHeight = isGroup ? 80 : 40;
    int summaryLines = isGroup ? 3 : 2;
    Widget cover = isGroup ?
    Container(
      padding: const EdgeInsets.only(top: imageItemPadding, bottom: imageItemPadding),
      height: groupImageWidth + imageItemPadding * 2,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: projectGroup!.projects.length + 1,
          itemBuilder: (context, index){
            if (index == 0) {
              return const SizedBox(width: imageItemPadding,);
            }
            return Container(
              padding: const EdgeInsets.only(right: imageItemPadding),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: Image.network(
                      projectGroup!.projects[index - 1].cover,
                      width: groupImageWidth,
                      height: groupImageWidth,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                      left: 21,
                      bottom: 13,
                      width: groupImageWidth -30,
                      child: Text(
                        projectGroup!.projects[index - 1].name,
                        style: const TextStyle(
                            color: Color(0xffffffff),
                            fontSize: 20
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )
                  )
                ],
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

    Widget textCol = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
              fontSize: 21,
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
              ]),
        ),
        const SizedBox(height: 5,),
        SizedBox(
          height: summaryHeight,
          child: Center(
            child: Text(
              summary,
              softWrap: true,
              style: const TextStyle(fontSize: 14, color: Color(0xb3ffffff)),
              maxLines: summaryLines,
            ),
          )),
        const SizedBox(height: 10,),
        showBrand ?
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(issuer.logo),
            ),
            const SizedBox(width: 7,),
            Text(issuer.title,
                style: const TextStyle(
                    fontSize: 14, color: Color(0xb3ffffff))),
            const Spacer(flex: 1,),
            Text(isGroup ? '' : '共发行 ${projectInfo!.totalAmount}',
                style: const TextStyle(fontSize: 14, color: Color(0xb3ffffff)))
          ],
        ) : const SizedBox(height: 0,)
      ],
    );

    return  Container(
        padding: const EdgeInsets.all(4),
        child: Column(children: [
            cover,
            Container(
                padding: const EdgeInsets.all(10),
                child: textCol,
            )
          ],
        ),
    ).outlined();
  }
}