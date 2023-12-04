class Dashboard {
  final String title;
  final String description;
  final List<DashboardItem> items;

  Dashboard({
    required this.title,
    required this.description,
    required this.items,
  });
}

class DashboardItem {
  final String label;
  final int value;

  DashboardItem({
    required this.label,
    required this.value,
  });
}
