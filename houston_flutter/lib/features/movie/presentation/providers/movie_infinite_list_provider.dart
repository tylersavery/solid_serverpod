import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:houston_flutter/features/movie/domain/models/movie_model.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../config/constants.dart';
import '../../../../core/utils/debugger_utils.dart';
import '../../domain/providers/movie_repository_provider.dart';

class MovieInfiniteListProvider {
  final Ref ref;
  final PagingController<int, Movie> pagingController = PagingController(firstPageKey: 1);

  MovieInfiniteListProvider(this.ref) {
    pagingController.addPageRequestListener((page) {
      fetchPage(page: page);
    });
  }

  Future<void> fetchPage({required int page, int limit = Constants.defaultPaginationLimit}) async {
    final result = await ref.read(movieRepositoryProvider).list(page: page, limit: limit);

    result.fold((failure) {
      pagingController.error = failure.message;

      Debugger.error(
        "MoviePaginatedListProvider Fetch Error",
        failure.message,
      );
    }, (data) {
      if (data.canLoadMore) {
        pagingController.appendPage(data.results, page + 1);
      } else {
        pagingController.appendLastPage(data.results);
      }
    });
  }

  void refresh() {
    pagingController.refresh();
  }
}

final movieInfiniteListProvider = Provider<MovieInfiniteListProvider>((ref) {
  return MovieInfiniteListProvider(ref);
});
