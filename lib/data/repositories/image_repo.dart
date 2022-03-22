// import 'package:waultar/core/abstracts/abstract_repositories/i_image_repository.dart';
// import 'package:waultar/core/models/misc/service_model.dart';
// import 'package:waultar/core/models/media/image_model.dart';
// import 'package:waultar/core/models/profile/profile_model.dart';
// import 'package:waultar/data/configs/objectbox.dart';
// import 'package:waultar/data/configs/objectbox.g.dart';

// class ImageRepository implements IImageRepository {
//   late final ObjectBox _context;
//   late final Box<ImageObjectBox> _imageBox;
//   late final IObjectBoxDirector _entityDirector;
//   late final IModelDirector _modelDirector;

//   ImageRepository(this._context, this._entityDirector, this._modelDirector) {
//     _imageBox = _context.store.box<ImageObjectBox>();
//   }

//   @override
//   int addImage(ImageModel image) {
//     var entity = _entityDirector.make<ImageObjectBox>(image);
//     int id = _imageBox.put(entity);
//     return id;
//   }

//   @override
//   List<ImageModel>? getAllImages() {
//     var images = _imageBox.getAll();

//     if (images.isEmpty) {
//       return null;
//     }

//     var imageModels = <ImageModel>[];
//     for (var image in images) {
//       var model = _modelDirector.make<ImageModel>(image);
//       imageModels.add(model);
//     }

//     return imageModels;
//   }

//   @override
//   List<ImageModel>? getAllImagesByProfile(ProfileModel profile) {
//     var builder = _imageBox.query();
//     builder.link(ImageObjectBox_.profile, ProfileObjectBox_.id.equals(profile.id));
//     var images = builder.build().find();

//     if (images.isEmpty) {
//       return null;
//     }

//     var imageModels = <ImageModel>[];
//     for (var image in images) {
//       imageModels.add(_modelDirector.make<ImageModel>(image));
//     }
//     return imageModels;
//   }

//   @override
//   List<ImageModel>? getAllImagesByService(ServiceModel service) {
//     var builder = _imageBox.query();
//     builder.link(ImageObjectBox_.profile, ProfileObjectBox_.service.equals(service.id));
//     var images = builder.build().find();

//     if (images.isEmpty) {
//       return null;
//     }

//     var imageModels = <ImageModel>[];
//     for (var image in images) {
//       imageModels.add(_modelDirector.make<ImageModel>(image));
//     }
//     return imageModels;
//   }

//   @override
//   ImageModel? getImageById(int id) {
//     var image = _imageBox.get(id);

//     if (image == null) {
//       return null;
//     } else {
//       return _modelDirector.make<ImageModel>(image);
//     }
//   }

//   @override
//   int removeAll() {
//     return _imageBox.removeAll();
//   }

//   @override
//   List<ImageModel> search(String search, int offset, int limit) {
//     var build = _imageBox.query(ImageObjectBox_.textSearch.contains(search)).build();

//     build
//       ..offset = offset
//       ..limit = limit;

//     return build.find().map((e) => _modelDirector.make<ImageModel>(e)).toList();
//   }

//   @override
//   int updateSingle(ImageModel model) {
//     var entity = _imageBox.get(model.id);

//     if (entity == null) {
//       throw ObjectBoxException(
//           "Tried to update a profile that doesn't exists: ${model.toString()}");
//     } else {
//       var updatedEntity = _entityDirector.make<ImageObjectBox>(model);
//       updatedEntity.id = entity.id;

//       return _imageBox.put(updatedEntity);
//     }
//   }

//   @override
//   List<ImageModel> getPagination(int offset, int limit) {
//     var build = _imageBox.query().build();

//     build
//       ..offset = offset
//       ..limit = limit;

//     return build.find().map((e) => _modelDirector.make<ImageModel>(e)).toList();
//   }

//   @override
//   void updateMany(List<ImageModel> images) {
//     _imageBox.putMany(images.map((e) => _entityDirector.make<ImageObjectBox>(e)).toList());
//   }
// }
