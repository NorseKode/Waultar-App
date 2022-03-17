// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:waultar/core/inodes/inode.dart';
import 'package:collection/collection.dart';

class DataBuilder {
  DataCategory category;
  late DataPointName name;

  DataBuilder(this.category);

  void setName(String name) {
    this.name = DataPointName(name: name);
  }
}

enum Decision {
  embedAsDataPoint,
  linkAsDataPoint,
  linkAsNewName,
}

enum InternalValueDecision { scalar, map, list }

class JsonExpert {
  static Function eq = const ListEquality().equals;


  static Decision processListElement(dynamic element) {
    if (element is Map<String, dynamic>) {
     
      // TODO - do this smarter
      // how to check for nested datapoint ?
      // the only cases where we should return linkAsNewName is 
      // when we encounter something like recently_viewed, but at the same time
      // exclude stuff like your_posts which has similiar pattern
      if (element.containsKey('children') || element.containsKey('entries')) {
        return Decision.linkAsNewName;
      }
      
      // defaul if no nested datapoints were found:
      return Decision.linkAsDataPoint;
    }

    if (element is List<dynamic>) {
      return Decision.linkAsNewName;
    } 
    
    return Decision.embedAsDataPoint;
    
  }

  static Decision process(dynamic json) {
    // handle maps, and decide the inner value
    if (json is Map<String, dynamic>) {
      var count = json.length;

      // can either have a nested obj or list as value or scalar
      // the _inferInner helper method will decide this for us
      if (count == 1) {
        var inferredDecision = _inferInner(json.entries.first.value);
        switch (inferredDecision) {
          // a scalar value should just be embedded as datapoint in the current name
          case InternalValueDecision.scalar:
            return Decision.embedAsDataPoint;

          // otherwise, we make a new name and attach that
          // name as child node to current parent name node
          case InternalValueDecision.map:
          case InternalValueDecision.list:
            return Decision.linkAsNewName;
        }
      }

      if (count > 1) {
        return Decision.linkAsNewName;
      }
    }

    // handle lists, and decide the elements of the list
    if (json is List<dynamic>) {
      // decide for special cases like recently_viewed
      if (json.isEmpty) {
        return Decision.embedAsDataPoint;
      }

      if (json.first is List<dynamic>) {
        return Decision.linkAsNewName;
      }
      if (json.first is Map<String, dynamic>) {
        return Decision.linkAsNewName;
      }

      return Decision.embedAsDataPoint;
      //
    }

    // if none of the above, it's a scalar value which the parser should just embed
    return Decision.embedAsDataPoint;
  }

  static InternalValueDecision _inferInner(dynamic innerValue) {
    if (innerValue is Map<String, dynamic>) {
      return InternalValueDecision.map;
    }
    if (innerValue is List<dynamic>) {
      return InternalValueDecision.list;
    }
    return InternalValueDecision.scalar;
  }
}

