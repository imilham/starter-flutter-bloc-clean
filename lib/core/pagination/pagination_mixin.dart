import 'dart:async';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

/// A mixin to add pagination capabilities to a BLoC or Cubit.
/// This allows the BLoC to manage a [PagingController] directly.
mixin PaginationMixin<TItem> {
  late final PagingController<int, TItem> pagingController = PagingController<int, TItem>(
    getNextPageKey: (state) {
      final loadedPages = state.pages?.length ?? 0;
      if (loadedPages >= _lastPage) return null;
      return loadedPages + 1;
    },
    fetchPage: (pageKey) async {
      try {
        if (pageKey == 1) _lastPage = 1;
        final response = await fetchApi(pageKey);
        _lastPage = response.lastPage;
        return response.items;
      } catch (e) {
        // In v5, adding an error to the controller state
        pagingController.value = PagingState<int, TItem>(
          pages: pagingController.value.pages,
          error: e,
        );
        rethrow;
      }
    },
  );

  int _lastPage = 1;
  Timer? _debounce;

  /// Subclasses must implement this to perform the actual API call and return
  /// the parsed items along with the last page info.
  Future<({List<TItem> items, int lastPage})> fetchApi(int pageKey);

  /// Performs a refresh with a small debounce window — useful for filter/search inputs.
  void debounceRefresh({int milliseconds = 300}) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(Duration(milliseconds: milliseconds), () {
      pagingController.refresh();
    });
  }

  /// Forces an immediate refresh, cancelling any pending debounce.
  void triggerRefresh() {
    _debounce?.cancel();
    pagingController.refresh();
  }

  /// Disposes the controller and timers. Should be called in the BLoC's [close] method.
  void disposePagination() {
    _debounce?.cancel();
    pagingController.dispose();
  }
}
