import 'package:cinema_booking/common/widgets/image/svg_image.dart';
import 'package:cinema_booking/common/widgets/space/widget_spacer.dart';
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

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      final keyword = _searchController.text;
      if (keyword.isNotEmpty) {
        BlocProvider.of<AllMoviesBloc>(_blocContext).add(SearchQueryChanged(keyword: keyword));
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
            color: AppColors.blue,
            height: 50,
            child: Row(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12, right: 10),
                    child: MySvgImage(
                      width: 19,
                      height: 16,
                      path: 'assets/ic_back.svg',
                    ),
                  ),
                ),
                Expanded(
                  child: _buildTitle(state),
                ),
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
            BlocProvider.of<AllMoviesBloc>(_blocContext)
                .add(state.movieSearchField ? ClickCloseSearch() : ClickIconSearch());
          },
          child: MySvgImage(
            path: state.movieSearchField ? "assets/ic_close.svg" : "assets/ic_search.svg",
            width: 20,
            height: 20,
          ),
        ),
        WidgetSpacer(width: 12),
        InkWell(
          onTap: () {
            BlocProvider.of<AllMoviesBloc>(_blocContext).add(ClickIconSort());
          },
          child: MySvgImage(
            path: "assets/ic_more.svg",
            width: 20,
            height: 20,
          ),
        ),
        WidgetSpacer(width: 12)
      ],
    );
  }

  _buildTitle(UpdateToolbarState state) {
    if (state.movieSearchField) {
      _searchController.text = "";
      return TextField(
        controller: _searchController,
        keyboardType: TextInputType.text,
        maxLines: 1,
        autofocus: true,
        textInputAction: TextInputAction.search,
        style: AppFont.regular_white_14,
        decoration: InputDecoration(hintText: 'Search', hintStyle: AppFont.regular_gray4_14),
      );
    } else {
      return Text('Movies in coimbatore', style: AppFont.medium_white_16);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
