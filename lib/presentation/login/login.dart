/*
 * @ Author: Chung Nguyen Thanh <chunhthanhde.dev@gmail.com>
 * @ Created: 2025-1-06 20:46:08
 * @ Message: 🎯 Happy coding and Have a nice day! 🌤️
 */

import 'package:cinema_booking/common/widgets/space/widget_spacer.dart';
import 'package:cinema_booking/common/widgets/texts/gradient_text.dart';
import 'package:cinema_booking/core/configs/assets/app_images.dart';
import 'package:cinema_booking/core/configs/assets/app_vectors.dart';

import 'package:cinema_booking/core/configs/theme/app_font.dart';
import 'package:cinema_booking/presentation/login/bloc/login_bloc.dart';
import 'package:cinema_booking/presentation/login/widgets/bottom_signup.dart';
import 'package:cinema_booking/presentation/login/widgets/signin_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black.withValues(alpha: .5),
        body: BlocProvider(
          create: (context) => LoginBloc(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Stack(
              children: [
                Align(alignment: Alignment.topRight, child: SvgPicture.asset(AppVectors.unionTop)),
                Align(
                  alignment: Alignment.bottomRight,
                  child: SvgPicture.asset(AppVectors.unionBottom),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Image.asset(
                      AppImages.ticket,
                      width: MediaQuery.of(context).size.width * 0.5,
                    ),
                  ),
                ),
                Align(alignment: Alignment.center, child: Image.asset(AppImages.logo)),
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      WidgetSpacer(height: 100),
                      Padding(
                        padding: const EdgeInsets.only(right: 40),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: GradientText(
                            text: "SIGN IN",
                            textStyle: AppFont.kTitleTextStyle.copyWith(
                              fontSize: 45,
                              fontFamily: 'Oswald',
                            ),
                          ),
                        ),
                      ),
                      const WidgetSignInForm(),
                      const WidgetSpacer(height: 10),
                      const WidgetSpacer(height: 10),
                      const WidgetBottomSignUp(),
                      const WidgetSpacer(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
