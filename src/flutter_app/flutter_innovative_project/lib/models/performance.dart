class Performance {
  int id;
  List<int> artistIds;
  final int eventId;
  final int artistId;
  String description;
  DateTime starttime;
  DateTime endtime;

  Performance({
    required this.id,
    required this.artistIds,
    required this.eventId,
    required this.artistId,
    required this.description,
    required this.starttime,
    required this.endtime
  });
}
