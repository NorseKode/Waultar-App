
import 'package:waultar/core/inodes/inode.dart';

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

enum InternalValueDecision {
  scalar,
  map,
  list
}

class JsonExpert {
  
  static Decision processList(List<dynamic> jsonList) {
    if (jsonList.first is Map<String, dynamic>) {
      return Decision.linkAsDataPoint;
    }
    return Decision.embedAsDataPoint;
  }

  static Decision processListElement(dynamic element) {
    if (element is Map<String, dynamic>) {
      return Decision.linkAsDataPoint;
    } else {
      return Decision.embedAsDataPoint;
    }

  }

  static Decision processMap(Map<String, dynamic> jsonMap) {
    var count = jsonMap.length;
    if (count == 1) {
      var inferredDecision = _inferInner(jsonMap.entries.first.value);
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

    return Decision.linkAsNewName;
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

class JsonDecider {
  static JSONDecision process(dynamic json) {
    if (json is List<dynamic>) {}

    if (json is Map<String, dynamic>) {
      var count = json.length;

      if (count == 1) {
        var value = json.entries.first.value;
        InternalDecision result = _inferInnerValueType(value);

        switch (result) {
          case InternalDecision.listWithScalars:
            return JSONDecision.useKeyAsNameAndEmbedAll;

          case InternalDecision.listWithMaps:
          case InternalDecision.listWithMixed:
          case InternalDecision.listWithLists:
          case InternalDecision.map:
            return JSONDecision.useKeyAsNameAndRecurse;

          case InternalDecision.singleScalar:
            return JSONDecision.linkAsChild;

          case InternalDecision.unknown:
            return JSONDecision.useKeyAsNameAndRecurse;
        }
      }

      if (count > 1) {
        var keys = json.keys;
        if (_checkNestedDataPoint(keys.toList())) {
          return JSONDecision.attachNewNameToParent;
        } else {
          return JSONDecision.linkAsChild;
        }

      }
    }

    return JSONDecision.isScalarValue;
  }

  static bool _checkNestedDataPoint(List<String> keys) {
    var concat = keys.join(':');
    return concat == 'name:description:children' || concat == 'name:description:entries';
  }

  static InternalDecision _inferInnerValueType(dynamic innerValue) {
    if (innerValue is List<dynamic>) {
      var typeSet = <String>{};
      for (var value in innerValue) {
        if (value is Map<String, dynamic>) {
          typeSet.add('map');
        } else if (value is List<dynamic>) {
          typeSet.add('list');
        } else {
          typeSet.add('scalar');
        }
      }

      if (typeSet.length == 1 && typeSet.first == 'scalar') {
        return InternalDecision.listWithScalars;
      }

      if (typeSet.length == 1 && typeSet.first == 'map') {
        return InternalDecision.listWithMaps;
      }

      if (typeSet.length == 1 && typeSet.first == 'list') {
        return InternalDecision.listWithLists;
      }

      return InternalDecision.listWithMixed;
    }

    if (innerValue is Map<String, dynamic> && innerValue.isNotEmpty) {
      return InternalDecision.map;
    }

    return InternalDecision.singleScalar;
  }
}

enum InternalDecision {
  listWithScalars,
  listWithMaps,
  listWithLists,
  listWithMixed,
  singleScalar,
  map,
  unknown
}

enum JSONDecision {
  attachNewNameToParent, // nested datapoints where we need to create a subtree with new name attached to current parent
  embedInCurrent, // key-value attribute where value is scalar
  useKeyAsNameAndEmbedAll, // map with one key which value is a list of scalars
  useKeyAsNameAndRecurse, // typically a map wiht ONE entry which value is a list of maps
  linkAsChild, // create a datapoint from the json and link it to current nameNode
  discard, // it's and empty list, empty string or the like, which we don't want
  isScalarValue // only used if root node in input json is a list of scalars values with no keys
}
