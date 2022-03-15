import 'package:waultar/core/abstracts/abstract_repositories/i_event_repository.dart';
import 'package:waultar/core/models/index.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';
import 'package:waultar/data/entities/content/event_objectbox.dart';
import 'package:waultar/data/repositories/model_builders/i_model_director.dart';
import 'package:waultar/data/repositories/objectbox_builders/i_objectbox_director.dart';

class EventRepository implements IEventRepository {
  late final ObjectBox _context;
  late final Box<EventObjectBox> _eventBox;
  late final IObjectBoxDirector _entityDirector;
  late final IModelDirector _modelDirector;

  EventRepository(this._context, this._entityDirector, this._modelDirector) {
    _eventBox = _context.store.box<EventObjectBox>();
  }

  @override
  int addEvent(EventModel event) {
    var entity = _entityDirector.make<EventObjectBox>(event);
    int id = _eventBox.put(entity);
    return id;
  }

  @override
  EventModel? getSingleEvent(int id) {
    var entity = _eventBox.get(id);
    if (entity != null) {
      var model = _modelDirector.make<EventModel>(entity);
      return model;
    } else {
      return null;
    }
  }

  @override
  List<EventModel>? getAllEvents() {
    var eventEntities = _eventBox.getAll();
    if (eventEntities.isNotEmpty) {
      return eventEntities
          .map((e) => _modelDirector.make<EventModel>(e))
          .toList();
    } else {
      return null;
    }
  }

  @override
  int removeAllEvents() {
    return _eventBox.removeAll();
  }

  @override
  List<EventObjectBox> getAllEventsAsEntity() {
    return _eventBox.getAll();
  }
}
