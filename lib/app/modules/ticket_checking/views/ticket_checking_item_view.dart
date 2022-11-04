// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/ticket_checking/models/nft.dart';
import 'package:blockie_app/app/modules/ticket_checking/models/souvenir.dart';
import 'package:blockie_app/extensions/extensions.dart';

class TicketCheckingItemView extends StatefulWidget {
  final Nft nft;
  final Function(int, Souvenir)? souvenirOnTap;

  const TicketCheckingItemView({
    super.key,
    required this.nft,
    this.souvenirOnTap,
  });

  @override
  State<TicketCheckingItemView> createState() => _TicketCheckingItemViewState();
}

class _TicketCheckingItemViewState extends State<TicketCheckingItemView> {
  @override
  Widget build(BuildContext context) {
    final header = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: CachedNetworkImage(
            imageUrl: widget.nft.activity.coverUrl,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        Text(widget.nft.activity.name)
            .textColor(Colors.white)
            .fontSize(16)
            .paddingAll(13),
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        header,
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          itemBuilder: (context, index) => TicketCheckingItemPrizeView(
            souvenir: widget.nft.souvenirs[index],
            souvenirOnTap: (souvenir) =>
                widget.souvenirOnTap?.call(index, souvenir),
          ),
          separatorBuilder: (context, index) =>
              const Divider(color: Color(0x1AFFFFFF), thickness: 1),
          itemCount: widget.nft.souvenirs.length,
        ),
      ],
    ).outlined();
  }
}

class TicketCheckingItemPrizeView extends StatelessWidget {
  final Souvenir souvenir;
  final Function(Souvenir)? souvenirOnTap;

  const TicketCheckingItemPrizeView({
    super.key,
    required this.souvenir,
    this.souvenirOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: souvenir.isPunched ? null : () => souvenirOnTap?.call(souvenir),
      behavior: HitTestBehavior.translucent,
      child: SizedBox(
        height: 34,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(souvenir.name).textColor(Colors.white).fontSize(14),
            ),
            Expanded(
              child: Text(
                '剩余 ${souvenir.totalAmount - souvenir.punchedAmount}/${souvenir.totalAmount}',
                textAlign: TextAlign.center,
              ).textColor(Colors.white).fontSize(14),
            ),
            Expanded(
              child: Row(
                children: [
                  const Spacer(flex: 1),
                  Text(souvenir.isPunched ? '已核销' : '未核销')
                      .fontSize(14)
                      .textColor(
                        souvenir.isPunched
                            ? const Color(0xFFAAAAAA)
                            : const Color(0xFFFF8F1F),
                      ),
                  Opacity(
                    opacity: souvenir.isPunched ? 0 : 1,
                    child: Image.asset(
                      souvenir.isSelected
                          ? 'assets/images/projects_management/selected.png'
                          : 'assets/images/projects_management/unselected.png',
                      width: 20,
                      height: 20,
                      fit: BoxFit.contain,
                    ),
                  ).paddingOnly(left: 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
