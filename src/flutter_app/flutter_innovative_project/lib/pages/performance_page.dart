import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_innovative_project/components/event_card.dart';
import 'package:flutter_innovative_project/components/timeline_tile.dart';
import 'package:flutter_innovative_project/models/performance.dart';
import 'package:flutter_innovative_project/repositories/performance_repository.dart';
import 'package:flutter_innovative_project/pages/artists_page.dart';

class PerformancesPage extends StatefulWidget {
  final int eventId;
  final PerformanceRepository performanceRepository;

  const PerformancesPage({
    Key? key,
    required this.eventId,
    required this.performanceRepository,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PerformancesPageState createState() => _PerformancesPageState();
}

class _PerformancesPageState extends State<PerformancesPage> {
  late PerformanceRepository performanceRepository;
  List<Performance> performances = [];
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    performanceRepository = widget.performanceRepository;
    performances =
        performanceRepository.getPerformancesForEvent(widget.eventId);

    _timer = Timer.periodic(const Duration(seconds: 30), (Timer timer) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  Performance? getCurrentPerformance() {
    DateTime currentTime = DateTime.now();

    for (Performance performance in performances) {
      if (performance.starttime.isBefore(currentTime) &&
          performance.endtime.isAfter(currentTime)) {
        return performance;
      }
    }

    return null;
  }

  bool isPerformanceLive(Performance performance) {
    DateTime currentTime = DateTime.now();
    return performance.starttime.isBefore(currentTime) &&
        performance.endtime.isAfter(currentTime);
  }

  @override
  Widget build(BuildContext context) {
    Performance? currentPerformance = getCurrentPerformance();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lineup', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: performances.length,
        itemBuilder: (context, index) {
          Performance performance = performances[index];
          bool isCurrentPerformance = performance == currentPerformance;
          bool isLive = isPerformanceLive(performance);

          return GestureDetector(
            onTap: () {
              if (performance.artistIds.isNotEmpty) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        ArtistsPage(performanceId: performance.id),
                  ),
                );
              }
            },
            child: CustomTimelineTile(
              isFirst: performances.first == performance,
              isLast: performances.last == performance,
              isPast: performance.endtime.isBefore(DateTime.now()),
              isLive: isLive,
              eventCard: EventCard(
                isPast: performance.endtime.isBefore(DateTime.now()),
                isLive: isLive,
                isFirst: performances.first == performance,
                isLast: performances.last == performance,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Center(
                        child: Text(
                          performance.description,
                          style: TextStyle(
                            color: performance.endtime.isBefore(DateTime.now())
                                ? Colors.white
                                : Colors.black,
                            fontSize: 28,
                          ),
                        ),
                      ),
                      subtitle: Center(
                        child: Text(
                          '${performance.starttime.hour.toString().padLeft(2, '0')}:${performance.starttime.minute.toString().padLeft(2, '0')} - '
                          '${performance.endtime.hour.toString().padLeft(2, '0')}:${performance.endtime.minute.toString().padLeft(2, '0')}',
                          style: TextStyle(
                            color: performance.endtime.isBefore(DateTime.now())
                                ? Colors.white
                                : Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      tileColor: isLive
                          ? Colors.red
                          : (isCurrentPerformance ? Colors.yellow : null),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
