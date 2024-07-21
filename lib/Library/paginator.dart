class PaginatorLoadResult<T> {
  final List<T> data;
  final int currentPage;
  final int totalPage;

  PaginatorLoadResult({
    required this.data,
    required this.currentPage,
    required this.totalPage,
  });
}

class Paginator<T> {
  final _data = <T>[];
  late int _currentPage;
  late int _totalPage;
  bool _isLoadingInProgress = false;
  final Future<PaginatorLoadResult<T>> Function(int) load;

  List<T> get data => _data;

  Paginator(this.load);

  Future<void> reset() async {
    _data.clear();
    _currentPage = 0;
    _totalPage = 1;
    await loadNextPage();
  }

  Future<void> loadNextPage() async {
    if (_isLoadingInProgress || _currentPage >= _totalPage) return;
    _isLoadingInProgress = true;
    final nextPage = _currentPage + 1;
    try {
      final result = await load(nextPage);
      _data.addAll(result.data);
      _currentPage = result.currentPage;
      _totalPage = result.totalPage;
      _isLoadingInProgress = false;
    } catch (e) {
      _isLoadingInProgress = false;
    }
  }
}
