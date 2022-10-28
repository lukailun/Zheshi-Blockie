export 'segmented_control_button.dart';
export 'segmented_control_button_item.dart';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:pointer_interceptor/pointer_interceptor.dart';

// Project imports:
import 'package:blockie_app/widgets/segmented_control/segmented_control_button.dart';
import 'package:blockie_app/widgets/segmented_control/segmented_control_button_item.dart';

class SegmentedControl extends StatefulWidget {
  final List<SegmentedControlButtonItem> items;
  final int selectedIndex;
  final void Function(int)? onSegmentSelected;

  const SegmentedControl({
    Key? key,
    required this.items,
    required this.selectedIndex,
    this.onSegmentSelected,
  }) : super(key: key);

  @override
  State<SegmentedControl> createState() => _SegmentedControlState();
}

class _SegmentedControlState extends State<SegmentedControl> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.items;
    final onSegmentSelected = widget.onSegmentSelected;
    return SizedBox(
      height: 30,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: items.map((item) {
          return Expanded(
            child: PointerInterceptor(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  final index = items.indexOf(item);
                  onSegmentSelected?.call(index);
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                child: Center(
                  child: SegmentedControlButton(
                    title: item.title,
                    isSelected: items[_selectedIndex].ID == item.ID,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
