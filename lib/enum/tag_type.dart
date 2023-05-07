
import '../http/api.dart';

enum TagType {project, publicNumber}

extension Ext on TagType {

  int get pageNum {
    switch (this) {
      case TagType.project:
        return 1;
      case TagType.publicNumber:
        return 1;
    }
  }

  String get tabApi {
    switch (this) {
      case TagType.project:
        return Api.getProjectClassify;
      case TagType.publicNumber:
        return Api.getPubilicNumber;
    }
  }

}