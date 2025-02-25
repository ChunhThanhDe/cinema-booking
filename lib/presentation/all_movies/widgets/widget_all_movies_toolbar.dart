/*
 * @ Author: Chung Nguyen Thanh <chunhthanhde.dev@gmail.com>
 * @ Created: 2024-12-25 08:45:56
 * @ Message: 🎯 Happy coding and Have a nice day! 🌤️
 */

import 'dart:async';

import 'package:cinema_booking/common/widgets/image/svg_image.dart';
import 'package:cinema_booking/common/widgets/space/widget_spacer.dart';
import 'package:cinema_booking/core/configs/assets/app_vectors.dart';
import 'package:cinema_booking/core/configs/theme/app_color.dart';
import 'package:cinema_booking/core/configs/theme/app_font.dart';
import 'package:cinema_booking/presentation/all_movies/bloc/all_movies_bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class WidgetAllMoviesToolbar extends StatefulWidget {
  const WidgetAllMoviesToolbar({super.key});

  @override
  State<WidgetAllMoviesToolbar> createState() => _WidgetAllMoviesToolbarState();
}

class _WidgetAllMoviesToolbarState extends State<WidgetAllMoviesToolbar> {
  late BuildContext _blocContext;
  final TextEditingController _searchController = TextEditingController();
  Timer? _searchTimer;
  bool isSearching = false;
  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      final keyword = _searchController.text;

      _searchTimer?.cancel();

      if (keyword.isNotEmpty) {
        _searchTimer = Timer(const Duration(seconds: 1), () {
          BlocProvider.of<AllMoviesBloc>(_blocContext).add(SearchQueryChanged(keyword: keyword));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllMoviesBloc, AllMoviesState>(
      listener: (context, state) {},
      buildWhen: (prev, current) {
        return current is UpdateToolbarState;
      },
      builder: (context, state) {
        _blocContext = context;

        if (state is UpdateToolbarState) {
          return Container(
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: AppColors.linearColor,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.1),
                  blurRadius: 10,
                  spreadRadius: -2,
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: <Widget>[
                InkWell(
                  onTap: () => Navigator.pop(context),
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: MySvgImage(width: 19, height: 16, path: AppVectors.iconBack),
                  ),
                ),
                Expanded(child: _buildTitle(state)),
                _buildActions(state),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  _buildActions(UpdateToolbarState state) {
    return Row(
      children: <Widget>[
        InkWell(
          onTap: () {
            setState(() {
              isSearching = !isSearching;
              if (!isSearching) _searchController.clear();
            });
            BlocProvider.of<AllMoviesBloc>(
              _blocContext,
            ).add(state.movieSearchField ? ClickCloseSearch() : ClickIconSearch());
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: MySvgImage(
              path: state.movieSearchField ? AppVectors.iconClose : AppVectors.iconSearch,
              width: 20,
              height: 20,
            ),
          ),
        ),
        WidgetSpacer(width: 8),
        InkWell(
          onTap: () {
            BlocProvider.of<AllMoviesBloc>(_blocContext).add(ClickIconSort());
          },
          child: MySvgImage(path: AppVectors.iconMore, width: 20, height: 20),
        ),
        WidgetSpacer(width: 12),
      ],
    );
  }

  Widget _buildTitle(UpdateToolbarState state) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: isSearching ? Colors.white.withValues(alpha: .1) : Colors.transparent,
        boxShadow:
            isSearching
                ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.9), // Darker shadow
                    blurRadius: 15,
                    spreadRadius: -5,
                    offset: Offset(0, 6),
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.7), // Lighter shadow layer
                    blurRadius: 10,
                    spreadRadius: -3,
                  ),
                ]
                : [],
      ),
      padding: EdgeInsets.symmetric(horizontal: 12),
      child:
          isSearching && state.movieSearchField
              ? TextField(
                controller: _searchController,
                keyboardType: TextInputType.text,
                autofocus: true,
                textInputAction: TextInputAction.search,
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  hintText: 'Search movies...',
                  hintStyle: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12), // Fix: Proper padding
                ),
              )
              : Text('Movies in coimbatore', style: AppFont.semibold_white_18),
    );
  }

  @override
  void dispose() {
    _searchTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }
}
