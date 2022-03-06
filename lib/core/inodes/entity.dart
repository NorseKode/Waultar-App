import 'package:objectbox/objectbox.dart';
import 'package:waultar/core/inodes/inode.dart';

class Entity {

}

// search found keys to another table and link them to each other - this way we can stream the traversal and make custom queries in realtime :
// - stream the 


class Node {
  int id;

  // a node will always have a ToOne with datapoint name
  // each datapoint name will then could be tracked back to a category and then provide document based query traversals

  // may never be unique
  String keyname;

  // make enums for the types
  String associatedValueType;

  // data stores in the node
  final dataPoints = ToMany<DataPoint>();

  // its children - only if type is list or map
  final ToMany<Node> nodes = ToMany<Node>(); 

  Node(this.id, this.keyname, this.associatedValueType);
}

/*

### Notes

- json kommer altid som et map<String, dynamic> eller List<Dynamic> 
  - dynamic i JSON kan have typen :
    - Map<String, dynamic>
    - List<dynamic>
    - String
    - number (int eller double) - also represents timestamps in unix time often
    - bool
    - null

- hvis yderste object er en list kan den alid laves om til et map, via en key vi kan få fra metadata omkring .json 
  - denne meta data skulle gerne kunne sige noget om hvilken kategori eller andet fra vores skema, som de involverede datapointer er relatered til

- hvilken datastruktur kan et map omformes til som kan abtraheres i en noSQL database ? 
  - og samtidig kunne queries med det valgte framework (objectbox) ?

- graphs 
- trees

- solution : 
  - gem selve skemaet vi får fra facebook i en datastruktur og tillad dynisk querying ud fra forskellige key kombinationer og deres nestede værdier
  - hver node i strukturen indeholder data og pointers til 0 eller mange noder så vi kan lave traversal
  - dataen i hver node indeholder en liste af ids som referer over til det generisk data point 


- forøg default maks cap på objectbox størrlse


### paser algoritme steps :
1) kør alle filer igennem 
  - udled metadata om parent directory og filename og hvilken service der pt uploades
    - denne metadata skal bruges senere når vi parser selve json

2) for hver fil :
  - skab skema strukturen (keys og values) og byg et subtree eller tilføj til nyt subtree i vores db
  - hver datapoint entry i json filen tilføjes som  

*/