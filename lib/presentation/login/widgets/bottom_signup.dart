/*
 * @ Author: Chung Nguyen Thanh <chunhthanhde.dev@gmail.com>
 * @ Created: 2024-10-16 21:55:21
 * @ Message: 🎯 Happy coding and Have a nice day! 🌤️
 */

import 'package:cinema_booking/core/configs/theme/app_font.dart';
import 'package:cinema_booking/presentation/router.dart';
import 'package:flutter/material.dart';

class WidgetBottomSignUp extends StatelessWidget {
  const WidgetBottomSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Don\'t have an account ?', style: AppFont.kNormalTextStyleWhite),
          Flexible(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRouter.REGISTER);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  'Sign up',
                  style: AppFont.kNormalBoldTextStyleWhite.copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
          Flexible(child: Text('Here', style: AppFont.kNormalBoldTextStyleWhite)),
        ],
      ),
    );
  }
}
