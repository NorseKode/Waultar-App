
import 'package:objectbox/objectbox.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_post_repository.dart';
import 'package:waultar/core/models/content/post_model.dart';
import 'package:waultar/data/configs/objectbox.dart';
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

class PostRepository implements IPostRepository {

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

  PostRepository(ObjectBox context) {
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
  void addPost(PostModel post) {
    // TODO: implement addPost
  }

  @override
  Future addPostAsync(PostModel post) {
    // TODO: implement addPostAsync
    throw UnimplementedError();
  }

  @override
  PostModel getAllPosts() {
    // TODO: implement getAllPosts
    throw UnimplementedError();
  }

  @override
  PostModel getAllPostsPagination(int offset, int limit) {
    // TODO: implement getAllPostsPagination
    throw UnimplementedError();
  }

  @override
  PostModel getSinglePost(int id) {
    // TODO: implement getSinglePost
    throw UnimplementedError();
  }

  @override
  Stream<PostModel> watchAllPosts() {
    // TODO: implement watchAllPosts
    throw UnimplementedError();
  }

  @override
  Stream<PostModel> watchFacebookPosts() {
    // TODO: implement watchFacebookPosts
    throw UnimplementedError();
  }

  @override
  Stream<PostModel> watchInstagramPosts() {
    // TODO: implement watchInstagramPosts
    throw UnimplementedError();
  }
  
}