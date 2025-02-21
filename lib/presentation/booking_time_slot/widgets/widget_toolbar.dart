import 'package:cinema_booking/common/widgets/image/svg_image.dart';
import 'package:cinema_booking/common/widgets/space/widget_spacer.dart';
import 'package:cinema_booking/core/configs/assets/app_vectors.dart';
import 'package:cinema_booking/core/configs/theme/app_color.dart';
import 'package:cinema_booking/core/configs/theme/app_font.dart';
import 'package:flutter/material.dart';

class WidgetToolbar extends StatelessWidget {
  final String title;
  final Widget actions;

  const WidgetToolbar({super.key, required this.title, required this.actions});

  WidgetToolbar.defaultActions({super.key, required this.title})
    : actions = _buildActions();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF9C27B0), Color(0xFFE91E63)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: .1),
            blurRadius: 10,
            spreadRadius: -2,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 10),
              child: MySvgImage(
                width: 19,
                height: 16,
                path: AppVectors.iconBack,
              ),
            ),
          ),
          Expanded(child: Text(title, style: AppFont.medium_white_16)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
            child: actions,
          ),
        ],
      ),
    );
  }

  static _buildActions() {
    return Row(
      children: <Widget>[
        MySvgImage(path: AppVectors.iconSearch, width: 20, height: 20),
        WidgetSpacer(width: 12),
        MySvgImage(path: AppVectors.iconMore, width: 20, height: 20),
        WidgetSpacer(width: 12),
      ],
    );
  }
}
