import 'package:waultar/core/models/content/event_model.dart';
import 'package:waultar/data/entities/content/event_objectbox.dart';

abstract class IEventRepository {
  List<EventModel>? getAllEvents();
  EventModel? getSingleEvent(int id);
  int addEvent(EventModel event);
  int removeAllEvents();
  List<EventObjectBox> getAllEventsAsEntity();
}
