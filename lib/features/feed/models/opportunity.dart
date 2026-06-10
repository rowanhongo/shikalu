class Opportunity {
  final String id;
  final String title;
  final String description;
  final String category;
  final String type;
  final String imageUrl;
  final String organizerName;
  final String organizerImage;
  final DateTime startDate;
  final DateTime? endDate;
  final String location;
  final int attendeesCount;
  final int maxAttendees;
  final bool isFree;
  final String? entryFee;
  final String? prizePool;
  final List<String> tags;
  final bool isTrending;
  final bool isFeatured;
  final String status;

  Opportunity({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.type,
    required this.imageUrl,
    required this.organizerName,
    required this.organizerImage,
    required this.startDate,
    this.endDate,
    required this.location,
    required this.attendeesCount,
    required this.maxAttendees,
    this.isFree = true,
    this.entryFee,
    this.prizePool,
    required this.tags,
    this.isTrending = false,
    this.isFeatured = false,
    this.status = 'upcoming',
  });

  String get formattedDate {
    final now = DateTime.now();
    final difference = startDate.difference(now).inDays;
    
    if (difference == 0) return 'Today';
    if (difference == 1) return 'Tomorrow';
    if (difference < 7) return 'In $difference days';
    return '${startDate.day} ${_monthName(startDate.month)}';
  }

  String get timeRange {
    final start = '${_pad(startDate.hour)}:${_pad(startDate.minute)}';
    if (endDate != null) {
      final end = '${_pad(endDate!.hour)}:${_pad(endDate!.minute)}';
      return '$start - $end';
    }
    return start;
  }

  String _monthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  String _pad(int n) => n.toString().padLeft(2, '0');
}
