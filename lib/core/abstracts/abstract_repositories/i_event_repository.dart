import 'package:waultar/core/models/content/event_model.dart';

abstract class IEventRepository {
  List<EventModel>? getAllEvents();
  EventModel? getSingleEvent(int id);
  int addEvent(EventModel event);
  int removeAllEvents();
}
