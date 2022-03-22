// import 'package:waultar/core/abstracts/abstract_repositories/i_link_repository.dart';
// import 'package:waultar/core/models/index.dart';
// import 'package:waultar/data/configs/objectbox.dart';
// import 'package:waultar/data/configs/objectbox.g.dart';
// import 'package:waultar/data/repositories/model_builders/i_model_director.dart';
// import 'package:waultar/data/repositories/objectbox_builders/i_objectbox_director.dart';

// class LinkRepository implements ILinkRepository {
//   late final ObjectBox _context;
//   late final Box<LinkObjectBox> _linkBox;
//   late final IObjectBoxDirector _entityDirector;
//   late final IModelDirector _modelDirector;

//   LinkRepository(this._context, this._entityDirector, this._modelDirector) {
//     _linkBox = _context.store.box<LinkObjectBox>();
//   }

//   @override
//   int addLink(LinkModel link) {
//     var entity = _entityDirector.make<LinkObjectBox>(link);
//     int id = _linkBox.put(entity);
//     return id;
//   }

//   @override
//   List<LinkModel>? getAllLinks() {
//     var links = _linkBox.getAll();

//     if (links.isEmpty) {
//       return null;
//     }

//     var linkModels = <LinkModel>[];
//     for (var link in links) {
//       var model = _modelDirector.make<LinkModel>(link);
//       linkModels.add(model);
//     }
//     return linkModels;
//   }

//   @override
//   List<LinkModel>? getAllLinksByProfile(ProfileModel profile) {
//     var builder = _linkBox.query();
//     builder.link(
//         LinkObjectBox_.profile, ProfileObjectBox_.id.equals(profile.id));
//     var links = builder.build().find();

//     if (links.isEmpty) {
//       return null;
//     }

//     var linkModels = <LinkModel>[];
//     for (var link in links) {
//       linkModels.add(_modelDirector.make<LinkModel>(link));
//     }
//     return linkModels;
//   }

//   @override
//   List<LinkModel>? getAllLinksByService(ServiceModel service) {
//     var builder = _linkBox.query();
//     builder.link(
//         LinkObjectBox_.profile, ProfileObjectBox_.service.equals(service.id));
//     var links = builder.build().find();

//     if (links.isEmpty) {
//       return null;
//     }

//     var linkModels = <LinkModel>[];
//     for (var link in links) {
//       linkModels.add(_modelDirector.make<LinkModel>(link));
//     }
//     return linkModels;
//   }

//   @override
//   LinkModel? getLinkById(int id) {
//     var link = _linkBox.get(id);

//     if (link == null) {
//       return null;
//     } else {
//       return _modelDirector.make<LinkModel>(link);
//     }
//   }

//   @override
//   int removeAll() {
//     return _linkBox.removeAll();
//   }
// }
