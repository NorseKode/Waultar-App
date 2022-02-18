import 'package:waultar/core/models/index.dart';

abstract class IVideoRepository {
  int addVideo(VideoModel image);
  VideoModel? getVideoById(int id);
  List<VideoModel>? getAllVideos();
  List<VideoModel>? getAllVideosByService(ServiceModel service);
  List<VideoModel>? getAllVideosByProfile(ProfileModel profile);
}