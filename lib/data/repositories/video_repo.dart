import 'package:waultar/core/abstracts/abstract_repositories/i_video_repository.dart';
import 'package:waultar/core/models/index.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';
import 'package:waultar/data/entities/media/video_objectbox.dart';
import 'package:waultar/data/repositories/model_builders/i_model_director.dart';
import 'package:waultar/data/repositories/objectbox_builders/i_objectbox_director.dart';

class VideoRepository implements IVideoRepository {
  late final ObjectBox _context;
  late final Box<VideoObjectBox> _videoBox;
  late final IObjectBoxDirector _entityDirector;
  late final IModelDirector _modelDirector;

  VideoRepository(this._context, this._entityDirector, this._modelDirector) {
    _videoBox = _context.store.box<VideoObjectBox>();
  }

  @override
  int addVideo(VideoModel video) {
    var entity = _entityDirector.make<VideoObjectBox>(video);
    int id = _videoBox.put(entity);
    return id;
  }

  @override
  List<VideoModel>? getAllVideos() {
    var videos = _videoBox.getAll();

    if (videos.isEmpty) {
      return null;
    }

    var videoModels = <VideoModel>[];
    for (var video in videos) {
      var model = _modelDirector.make<VideoModel>(video);
      videoModels.add(model);
    }
    return videoModels;
  }

  @override
  List<VideoModel>? getAllVideosByProfile(ProfileModel profile) {
    var builder = _videoBox.query();
    builder.link(
        VideoObjectBox_.profile, ProfileObjectBox_.id.equals(profile.id));
    var videos = builder.build().find();

    if (videos.isEmpty) {
      return null;
    }

    var videoModels = <VideoModel>[];
    for (var video in videos) {
      videoModels.add(_modelDirector.make<VideoModel>(video));
    }
    return videoModels;
  }

  @override
  List<VideoModel>? getAllVideosByService(ServiceModel service) {
    var builder = _videoBox.query();
    builder.link(
        VideoObjectBox_.profile, ProfileObjectBox_.service.equals(service.id));
    var videos = builder.build().find();

    if (videos.isEmpty) {
      return null;
    }

    var videoModels = <VideoModel>[];
    for (var video in videos) {
      videoModels.add(_modelDirector.make<VideoModel>(video));
    }
    return videoModels;
  }

  @override
  VideoModel? getVideoById(int id) {
    var video = _videoBox.get(id);

    if (video == null) {
      return null;
    } else {
      return _modelDirector.make<VideoModel>(video);
    }
  }
}
