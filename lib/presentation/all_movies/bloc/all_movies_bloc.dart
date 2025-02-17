import 'package:cinema_booking/common/helpers/log_helpers.dart';
import 'package:cinema_booking/core/enum/sort_movie.dart';
import 'package:cinema_booking/domain/entities/movies/movies.dart';
import 'package:cinema_booking/domain/entities/response/home.dart';
import 'package:cinema_booking/service_locator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'all_movies_event.dart';
part 'all_movies_state.dart';

class AllMoviesBloc extends Bloc<AllMoviesEvent, AllMoviesState> {
  MovieSoftBy movieSortBy = MovieSoftBy.ratting;

  AllMoviesBloc() : super(DisplayListMovies.loading()) {
    on<OpenScreen>(_onOpenScreen);
    on<ClickIconSearch>(_onClickIconSearch);
    on<ClickCloseSearch>(_onClickCloseSearch);
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<ClickIconSort>(_onClickIconSort);
    on<SortByChanged>(_onSortByChanged);
  }

  // Hàm xử lý sự kiện OpenScreen
  Future<void> _onOpenScreen(OpenScreen event, Emitter<AllMoviesState> emit) async {
    LogHelper.logDebug(tag: "AllMoviesBloc", message: "_onOpenScreen start");
    emit(UpdateToolbarState(movieSearchField: false));
    try {
      // emit(DisplayListMovies.loading());
      LogHelper.logDebug(tag: "AllMoviesBloc", message: "Fetching data for all movies...");
      var response = await sl<GetAllMoviesDataUseCase>().call();

      response.fold(
        (l) {
          emit(DisplayListMovies.error(l.toString()));
        },
        (data) async {
          if (data is AllMoviesModelResponse) {
            LogHelper.logDebug(
              tag: '' "AllMoviesBloc",
              message: "Data fetched successfully + ${response.toString()}",
            );
            var ok = DisplayListMovies.data(_metaFromResponse(data.toEntity()));
            emit(ok);
            LogHelper.logDebug(tag: "AllMoviesBloc", message: "emit(ok)");
          } else {
            emit(DisplayListMovies.error("Invalid response type"));
          }
        },
      );
    } catch (e) {
      LogHelper.logDebug(tag: "AllMoviesBloc", message: "Error fetching data: $e");
      emit(DisplayListMovies.error(e.toString()));
    }
  }

  // Hàm xử lý sự kiện ClickIconSearch
  Future<void> _onClickIconSearch(ClickIconSearch event, Emitter<AllMoviesState> emit) async {
    LogHelper.logDebug(tag: "AllMoviesBloc", message: "Search icon clicked, movieing search field");
    emit(UpdateToolbarState(movieSearchField: true));
  }

  // Hàm xử lý sự kiện ClickCloseSearch
  Future<void> _onClickCloseSearch(ClickCloseSearch event, Emitter<AllMoviesState> emit) async {
    LogHelper.logDebug(tag: "AllMoviesBloc", message: "Closing search field");
    emit(UpdateToolbarState(movieSearchField: false));
    emit(DisplayListMovies.loading());
    await _mapSearchQueryChangedToState('', emit);
  }

  // Hàm xử lý thay đổi truy vấn tìm kiếm
  Future<void> _onSearchQueryChanged(SearchQueryChanged event, Emitter<AllMoviesState> emit) async {
    LogHelper.logDebug(tag: "AllMoviesBloc", message: "Search query changed: ${event.keyword}");
    await _debouncedSearchQueryChanged(event.keyword, emit);
  }

  // Hàm debounce cho tìm kiếm
  Future<void> _debouncedSearchQueryChanged(String keyword, Emitter<AllMoviesState> emit) async {
    LogHelper.logDebug(tag: "AllMoviesBloc", message: "Debouncing search query...");
    await Future.delayed(Duration(milliseconds: 400)); // Debounce logic
    await _mapSearchQueryChangedToState(keyword, emit);
  }

  // Hàm xử lý thay đổi truy vấn tìm kiếm
  Future<void> _mapSearchQueryChangedToState(String keyword, Emitter<AllMoviesState> emit) async {
    LogHelper.logDebug(
        tag: "AllMoviesBloc", message: "Updating search results for query: $keyword");
    // emit(DisplayListMovies.loading());
    try {
      LogHelper.logDebug(tag: "AllMoviesBloc", message: "Fetching data for all movies...");
      var response = await sl<GetAllMoviesDataUseCase>().call();

      response.fold(
        (l) {
          emit(DisplayListMovies.error(l.toString()));
        },
        (data) async {
          if (data is AllMoviesModelResponse) {
            bool query(MovieEntity movie) =>
                keyword.isEmpty || movie.name.toLowerCase().contains(keyword.toLowerCase());

            data.nowMovieing = data.nowMovieing.where(query).toList();
            data.comingSoon = data.comingSoon.where(query).toList();
            data.exclusive = data.exclusive.where(query).toList();

            final meta = _metaFromResponse(data.toEntity());
            emit(DisplayListMovies.data(meta));
          } else {
            emit(DisplayListMovies.error("Invalid response type"));
          }
        },
      );
    } catch (e) {
      LogHelper.logDebug(tag: "AllMoviesBloc", message: "Error filtering search results: $e");
      emit(DisplayListMovies.error(e.toString()));
    }
  }

  // Hàm xử lý sự kiện ClickIconSort
  Future<void> _onClickIconSort(ClickIconSort event, Emitter<AllMoviesState> emit) async {
    LogHelper.logDebug(tag: "AllMoviesBloc", message: "Sort icon clicked");
    emit(OpenSortOption(isOpen: true, movieSortBy: movieSortBy));
  }

  // Hàm xử lý sự kiện SortByChanged
  Future<void> _onSortByChanged(SortByChanged event, Emitter<AllMoviesState> emit) async {
    LogHelper.logDebug(tag: "AllMoviesBloc", message: "Sorting by: ${event.movieSortBy}");
    movieSortBy = event.movieSortBy;
    emit(UpdateToolbarState(movieSearchField: false));
    await _mapSearchQueryChangedToState('', emit);
  }

  Meta _metaFromResponse(AllMoviesByTypeResponseEntity response) {
    var sortBy;
    // if (movieSortBy == MovieSoftBy.NAME) {
    //   sortBy = (MovieEntity a, MovieEntity b) => a.name.compareTo(b.name);
    // } else {
    //   sortBy = (MovieEntity a, MovieEntity b) => b.rate.compareTo(a.rate);
    // }

    // response.nowMovieing.sort(sortBy);
    // response.comingSoon.sort(sortBy);
    // response.exclusive.sort(sortBy);

    return Meta(
      nowMovieing: response.nowMovieing,
      comingSoon: response.comingSoon,
      exclusive: response.exclusive,
    );
  }
}

class Meta {
  final List<MovieDetailEntity> nowMovieing;
  final List<MovieDetailEntity> comingSoon;
  final List<MovieDetailEntity> exclusive;

  Meta({required this.nowMovieing, required this.comingSoon, required this.exclusive});

  @override
  String toString() {
    return 'Meta(nowMovieing: ${nowMovieing.map((movie) => movie.toString()).join(", ")}, '
        'comingSoon: ${comingSoon.map((movie) => movie.toString()).join(", ")}, '
        'exclusive: ${exclusive.map((movie) => movie.toString()).join(", ")})';
  }
}
