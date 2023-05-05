
import '../http/api.dart';

enum TagType {project, tree}

extension Ext on TagType {

  int get pageNum {
    switch (this) {
      case TagType.project:
        return 1;
      case TagType.tree:
        return 0;
    }
  }

  String get tabApi {
    switch (this) {
      case TagType.project:
        return Api.getProjectClassify;
      case TagType.tree:
        return Api.getTree;
    }
  }

}