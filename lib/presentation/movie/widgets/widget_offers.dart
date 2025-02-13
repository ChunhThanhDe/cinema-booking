import 'package:cinema_booking/common/widgets/image/svg_image.dart';
import 'package:cinema_booking/common/widgets/space/widget_spacer.dart';
import 'package:cinema_booking/core/configs/assets/app_vectors.dart';
import 'package:cinema_booking/core/configs/theme/app_color.dart';
import 'package:cinema_booking/core/configs/theme/app_font.dart';
import 'package:cinema_booking/core/enum/offer_type.dart';
import 'package:cinema_booking/domain/entities/offer/movie_offer.dart';
import 'package:cinema_booking/domain/entities/response/home.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class WidgetOffers extends StatelessWidget {
  final MovieDetailEntity movie;

  const WidgetOffers({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      color: AppColors.white,
      height: 156,
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: <Widget>[
          Text('Your offers', style: AppFont.medium_black2_16),
          WidgetSpacer(height: 14),
          SizedBox(
            height: 81,
            child: ListView.separated(
              itemBuilder: (context, index) {
                MovieOfferEntity offer = movie.movieOffer[index];

                String iconPath = '';
                Color textColor;
                Color iconBgColor;
                switch (offer.type) {
                  case TypeOffer.green:
                    iconPath = AppVectors.iconGift;
                    textColor = AppColors.red2;
                    iconBgColor = AppColors.gift1;
                    break;
                  case TypeOffer.red:
                    iconPath = AppVectors.iconGiftGreen;
                    textColor = AppColors.green2;
                    iconBgColor = AppColors.gift2;
                    break;
                }

                return WidgetGrabReward(
                  iconPath: iconPath,
                  textColor: textColor,
                  iconBgColor: iconBgColor,
                  title: offer.title,
                  content: offer.content,
                );
              },
              separatorBuilder: (context, index) {
                return WidgetSpacer(width: 20);
              },
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: movie.movieOffer.length,
            ),
          )
        ],
      ),
    );
  }
}

class WidgetGrabReward extends StatelessWidget {
  final String iconPath;
  final Color iconBgColor;
  final Color textColor;
  final String title;
  final String content;

  const WidgetGrabReward({
    super.key,
    required this.iconPath,
    required this.iconBgColor,
    required this.textColor,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: AppColors.gray7,
      strokeWidth: 2,
      strokeCap: StrokeCap.butt,
      borderType: BorderType.RRect,
      dashPattern: [8, 4],
      radius: Radius.circular(6),
      child: Container(
        width: 234,
        height: 81,
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: <Widget>[
            Flexible(
              child: Container(
                width: 30,
                height: 53,
                decoration:
                    BoxDecoration(color: iconBgColor, borderRadius: BorderRadius.circular(4)),
                child: Center(
                  child: MySvgImage(
                    path: iconPath,
                    width: 16,
                    height: 16,
                    applyColorFilter: false,
                  ),
                ),
              ),
            ),
            WidgetSpacer(width: 10),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title,
                      maxLines: 1, style: AppFont.oswald_regular_red2.copyWith(color: textColor)),
                  Text(
                    content,
                    style: AppFont.regular_gray4_10,
                    maxLines: 2,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
