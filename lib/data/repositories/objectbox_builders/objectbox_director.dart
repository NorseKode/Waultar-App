
import 'package:waultar/core/models/content/post_model.dart';
import 'package:waultar/core/models/index.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';
import 'package:waultar/data/entities/content/event_objectbox.dart';
import 'package:waultar/data/entities/content/group_objectbox.dart';
import 'package:waultar/data/entities/content/life_event_objectbox.dart';
import 'package:waultar/data/entities/content/poll_objectbox.dart';
import 'package:waultar/data/entities/content/post_objectbox.dart';
import 'package:waultar/data/entities/media/file_objectbox.dart';
import 'package:waultar/data/entities/media/image_objectbox.dart';
import 'package:waultar/data/entities/media/link_objectbox.dart';
import 'package:waultar/data/entities/media/video_objectbox.dart';
import 'package:waultar/data/entities/misc/person_objectbox.dart';
import 'package:waultar/data/entities/misc/service_objectbox.dart';
import 'package:waultar/data/entities/misc/tag_objectbox.dart';
import 'package:waultar/data/entities/profile/profile_objectbox.dart';
import 'package:waultar/data/repositories/objectbox_builders/i_objectbox_director.dart';

class ObjectBoxDirector implements IObjectBoxDirector {

  late final ObjectBox _context;
  late final Box<PostObjectBox> _postBox;
  late final Box<ProfileObjectBox> _profileBox;
  late final Box<ImageObjectBox> _imageBox;
  late final Box<VideoObjectBox> _videoBox;
  late final Box<FileObjectBox> _fileBox;
  late final Box<LinkObjectBox> _linkBox;
  late final Box<PersonObjectBox> _personBox;
  late final Box<TagObjectBox> _tagBox;
  late final Box<EventObjectBox> _eventBox;
  late final Box<GroupObjectBox> _groupBox;
  late final Box<PollObjectBox> _pollBox;
  late final Box<LifeEventObjectBox> _lifeEventBox;
  late final Box<ServiceObjectBox> _serviceBox;

  ObjectBoxDirector(ObjectBox context) {
    _context = context;
    _postBox = _context.store.box<PostObjectBox>();
    _profileBox = _context.store.box<ProfileObjectBox>();
    _imageBox = _context.store.box<ImageObjectBox>();
    _videoBox = _context.store.box<VideoObjectBox>();
    _fileBox = context.store.box<FileObjectBox>();
    _linkBox = _context.store.box<LinkObjectBox>();
    _personBox = _context.store.box<PersonObjectBox>();
    _tagBox = _context.store.box<TagObjectBox>();
    _eventBox = _context.store.box<EventObjectBox>();
    _groupBox = _context.store.box<GroupObjectBox>();
    _pollBox = _context.store.box<PollObjectBox>();
    _lifeEventBox = _context.store.box<LifeEventObjectBox>();
    _serviceBox = _context.store.box<ServiceObjectBox>();
  }

  @override
  T make<T>(dynamic model) {

    if (model == null) throw Exception("Model cannot be null");

    switch (model.runtimeType) {
      case PostModel:
        return _makePost(model as PostModel) as T;
        
      default:
        throw UnimplementedError("Maker for ${model.runtimeType} has not been implemented"); 
    }

  }

  PostObjectBox _makePost(PostModel model) {
    var entity = PostObjectBox(raw: model.raw, timestamp: model.timestamp);

    // check and assigne all nullable fields in model
    if (model.title != null) {
      entity.title = model.title;
    }
    if (model.description != null) {
      entity.description = model.description;
    }
    if (model.isArchived != null) {
      entity.isArchived = model.isArchived;
    }
    if (model.meta != null) {
      entity.meta = model.meta;
    }

    // the profile HAS to be created in db before storing additional data
    if (model.profile.id == 0) {
      throw ObjectBoxException(
          "Profile Id is 0 - profile must be stored before calling me");
    } else {
      var profileEntity = _profileBox.get(model.profile.id);
      entity.profile.target = profileEntity;
    }

    // initiate targets for media
    var mediaList = model.content;
    if (mediaList != null) {
      var imagesToAdd = <ImageObjectBox>[];
      var videosToAdd = <VideoObjectBox>[];
      var linksToAdd = <LinkObjectBox>[];
      var filesToAdd = <FileObjectBox>[];

      for (var media in mediaList) {
        switch (media.runtimeType) {
          case ImageModel:
            var entity = _makeImage(media as ImageModel);
            imagesToAdd.add(entity);
            break;

          case VideoModel:
            var entity = _makeVideo(media as VideoModel);
            videosToAdd.add(entity);
            break;

          case LinkModel:
            var entity = _makeLink(media as LinkModel);
            linksToAdd.add(entity);
            break;

          case FileModel:
            var entity = _makeFile(media as FileModel);
            filesToAdd.add(entity);
            break;
        }
      }
      entity.images.addAll(imagesToAdd);
      entity.videos.addAll(videosToAdd);
      entity.files.addAll(filesToAdd);
      entity.links.addAll(linksToAdd);
    }

    var mentions = model.mentions;
    if (mentions != null) {
      var mentionsToAdd = <PersonObjectBox>[];
      for (var person in mentions) {
        var entity = _makePerson(person);
        mentionsToAdd.add(entity);
      }
      entity.mentions.addAll(mentionsToAdd);
    }

    var tags = model.tags;
    if (tags != null) {
      var tagsToAdd = <TagObjectBox>[];
      for (var tag in tags) {
        var entity = _makeTag(tag);
        tagsToAdd.add(entity);
      }
      entity.tags.addAll(tagsToAdd);
    }

    return entity;
  }

  ImageObjectBox _makeImage(ImageModel model) {
    var entity = _imageBox
        .query(ImageObjectBox_.uri.equals(model.uri.path))
        .build()
        .findFirst();
    if (entity == null) {
      entity = ImageObjectBox(uri: model.uri.path, raw: model.raw);

      entity.title = model.title;
      entity.description = model.description;

      // the profile HAS to be created in db before storing additional data
      if (model.profile.id == 0) {
        throw ObjectBoxException(
            "Profile Id is 0 - profile must be stored before calling me");
      } else {
        var profileEntity = _profileBox.get(model.profile.id);
        entity.profile.target = profileEntity;
      }

      if (model.metadata != null) {
        entity.metadata = model.metadata;
      }
      if (model.timestamp != null) {
        entity.timestamp = model.timestamp;
      }

      return entity;
    } else {
      return entity;
    }
  }

  VideoObjectBox _makeVideo(VideoModel model) {
    var entity = _videoBox
        .query(VideoObjectBox_.uri.equals(model.uri.path))
        .build()
        .findFirst();
    if (entity == null) {
      entity = VideoObjectBox(uri: model.uri.path, raw: model.raw);

      entity.title = model.title;
      entity.description = model.description;

      // the profile HAS to be created in db before storing additional data
      if (model.profile.id == 0) {
        throw ObjectBoxException(
            "Profile Id is 0 - profile must be stored before calling me");
      } else {
        var profileEntity = _profileBox.get(model.profile.id);
        entity.profile.target = profileEntity;
      }

      if (model.metadata != null) {
        entity.metadata = model.metadata;
      }
      if (model.timestamp != null) {
        entity.timestamp = model.timestamp;
      }
      if (model.thumbnail != null) {
        entity.thumbnail = model.thumbnail!.path;
      }

      return entity;
    } else {
      return entity;
    }
  }

  LinkObjectBox _makeLink(LinkModel model) {
    var entity = _linkBox
        .query(LinkObjectBox_.uri.equals(model.uri.path))
        .build()
        .findFirst();
    if (entity == null) {
      entity = LinkObjectBox(uri: model.uri.path, raw: model.raw);

      // the profile HAS to be created in db before storing additional data
      if (model.profile.id == 0) {
        throw ObjectBoxException(
            "Profile Id is 0 - profile must be stored before calling me");
      } else {
        var profileEntity = _profileBox.get(model.profile.id);
        entity.profile.target = profileEntity;
      }

      if (model.metadata != null) {
        entity.metadata = model.metadata;
      }
      if (model.timestamp != null) {
        entity.timestamp = model.timestamp;
      }
      if (model.source != null) {
        entity.source = model.source;
      }

      return entity;
    } else {
      return entity;
    }
  }

  FileObjectBox _makeFile(FileModel model) {
    var entity = _fileBox
        .query(FileObjectBox_.uri.equals(model.uri.path))
        .build()
        .findFirst();
    if (entity == null) {
      entity = FileObjectBox(uri: model.uri.path, raw: model.raw);

      // the profile HAS to be created in db before storing additional data
      if (model.profile.id == 0) {
        throw ObjectBoxException(
            "Profile Id is 0 - profile must be stored before calling me");
      } else {
        var profileEntity = _profileBox.get(model.profile.id);
        entity.profile.target = profileEntity;
      }

      if (model.metadata != null) {
        entity.metadata = model.metadata;
      }
      if (model.timestamp != null) {
        entity.timestamp = model.timestamp;
      }
      if (model.thumbnail != null) {
        entity.thumbnail = model.thumbnail!.path;
      }

      return entity;
    } else {
      return entity;
    }
  }

  PersonObjectBox _makePerson(PersonModel model) {
    QueryBuilder<PersonObjectBox> builder = _personBox.query(PersonObjectBox_.name.equals(model.name));
    builder.link(PersonObjectBox_.profile, ProfileObjectBox_.id.equals(model.profile.id));
    Query<PersonObjectBox> query = builder.build();
    var entity = query.findFirst();

    if (entity == null) {
      entity = PersonObjectBox(raw: model.raw, name: model.name);

      // the profile HAS to be created in db before storing additional data
      if (model.profile.id == 0) {
        throw ObjectBoxException(
            "Profile Id is 0 - profile must be stored before calling me");
      } else {
        var profileEntity = _profileBox.get(model.profile.id);
        entity.profile.target = profileEntity;
      }

      if (model.uri != null) {
        entity.uri = model.uri!.path;
      }

      return entity;
    } else {
      return entity;
    }
  }

  TagObjectBox _makeTag(TagModel model) {
    var entity = _tagBox.query(TagObjectBox_.name.equals(model.name)).build().findUnique();
    if (entity == null) {
      return TagObjectBox(name: model.name);
    } else {
      return entity;
    }
  }
  
}

class Blob implements IObjectBoxDirector {
  @override
  T make<T>(Type model) {
    // TODO: implement make
    throw UnimplementedError();
  }
  
}