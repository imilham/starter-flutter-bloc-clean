import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:starter/utils/network/model.dart';

/// A reusable base controller for paginated API endpoints, built on top of
/// `infinite_scroll_pagination` v5.
///
/// Subclass this and implement [fetchApi] to wire any paginated endpoint into
/// a `PagedListView` / `PagedSliverList`. The controller is environment-agnostic
/// (works with BLoC, Cubit, Provider, or plain ChangeNotifier consumers).
abstract class BasePaginationController<TItem> extends ChangeNotifier {
  BasePaginationController();

  late final PagingController<int, TItem> pagingController =
      PagingController<int, TItem>(
    getNextPageKey: (state) {
      final loadedPages = state.pages?.length ?? 0;
      if (loadedPages >= _lastPage) return null;
      return loadedPages + 1;
    },
    fetchPage: (pageKey) async {
      if (pageKey == 1) _lastPage = 1;
      final response = await fetchApi(pageKey);
      _lastPage = response.paginator.lastPage;
      return response.items;
    },
  );

  int _lastPage = 1;
  Timer? _debounce;

  /// Subclasses must implement this to perform the actual API call and return
  /// the parsed items along with the [Paginator] info.
  Future<({List<TItem> items, Paginator paginator})> fetchApi(int pageKey);

  /// Performs a state mutation and refreshes the controller with a small
  /// debounce window — useful for filter/search inputs.
  void debounceRefresh(VoidCallback updateState, {int milliseconds = 300}) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(Duration(milliseconds: milliseconds), () {
      updateState();
      pagingController.refresh();
      notifyListeners();
    });
  }

  /// Forces an immediate refresh, cancelling any pending debounce.
  void triggerRefresh() {
    _debounce?.cancel();
    pagingController.refresh();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    pagingController.dispose();
    super.dispose();
  }
}
