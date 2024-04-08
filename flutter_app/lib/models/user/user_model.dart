import 'package:flutter_app/constants/constant.dart';
// import 'package:flutter_app/models/home/event_home_model.dart';

class UserSearchResponse {
  List<UserModel>? data;
  String? message;

  UserSearchResponse({this.data, this.message});

  UserSearchResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <UserModel>[];
      json['data'].forEach((v) {
        data!.add(UserModel.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class UserModel {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? fullName;
  String? phoneNumber;
  String phoneCode = '';
  String? gender;
  String? birthDate;
  String? bio;
  String? avatar;
  String? imgBackground;
  String? name;
  Country? country;
  List<Sports>? sports;
  String? status;
  String ecFullName = '';
  int? ecRelationShipId;
  String ecMainPhoneCd = '';
  String ecMainPhoneNumb = '';
  String ecAltPhoneCd = '';
  String ecAltPhoneNumb = '';
  String ecEmail = '';
  int countFollower = 0;
  int countFollowing = 0;
  int countTeam = 0;
  bool? hasPassword;
  Currency? currency;
  String? interactionStatus;
  // List<MediaEventModel>? media;

  bool? isAvatarOffensive;
  bool? isCoverImgOffensive;

  UserModel(
      {this.id,
      this.email,
      this.firstName,
      this.lastName,
      this.fullName,
      // this.media,
      this.phoneNumber,
      this.phoneCode = '',
      this.gender,
      this.birthDate,
      this.bio,
      this.avatar,
      this.imgBackground,
      this.country,
      this.sports,
      this.ecFullName = Constant.empty,
      this.ecRelationShipId,
      this.ecMainPhoneCd = Constant.empty,
      this.ecMainPhoneNumb = Constant.empty,
      this.ecAltPhoneCd = Constant.empty,
      this.ecAltPhoneNumb = Constant.empty,
      this.ecEmail = Constant.empty,
      this.countFollower = 0,
      this.countFollowing = 0,
      this.countTeam = 0,
      this.currency,
      this.name,
      this.hasPassword,
      this.interactionStatus,
      this.isAvatarOffensive = false,
      this.isCoverImgOffensive = false,
      this.status});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    fullName = json['full_name'];
    phoneNumber = json['phone'];
    phoneCode = json['phone_code'] ?? '';
    gender = json['gender'];
    birthDate = json['birth_date'];
    bio = json['bio'];
    avatar = json['avatar'];
    imgBackground = json['background_image'];
    name = json['name'];
    hasPassword = json['has_password'];
    ecFullName = json['ec_fullname'] ?? Constant.empty;
    ecRelationShipId = json['ec_relationship'];
    ecMainPhoneCd = json['ec_main_pcode'] ?? Constant.empty;
    ecMainPhoneNumb = json['ec_main_pnum'] ?? Constant.empty;
    ecAltPhoneCd = json['ec_alt_pcode'] ?? Constant.empty;
    ecAltPhoneNumb = json['ec_alt_pnum'] ?? Constant.empty;
    ecEmail = json['ec_email'] ?? Constant.empty;
    interactionStatus = json['my_interaction_status'];
    country =
        json['country'] != null ? Country.fromJson(json['country']) : null;
    if (json['sports'] != null) {
      sports = <Sports>[];
      json['sports'].forEach((v) {
        sports!.add(Sports.fromJson(v));
      });
    }
    currency =
        json['currency'] != null ? Currency.fromJson(json['currency']) : null;
    status = json['status'];
    countFollower = json['count_follower'] ?? 0;
    countFollowing = json['count_following'] ?? 0;
    countTeam = json['count_team'] ?? 0;

    // if (json['media'] != null) {
    //   media = <MediaEventModel>[];
    //   json['media'].forEach((v) {
    //     media!.add(MediaEventModel.fromJson(v));
    //   });
    // }

    if (json['media'] != null && json['media'] is List) {
      json['media'].forEach((e) {
        if (avatar == e['original_url']) {
          isAvatarOffensive = e['status'] == 1;
        }

        if (imgBackground == e['original_url']) {
          isCoverImgOffensive = e['status'] == 1;
        }
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['full_name'] = fullName;
    data['phone_number'] = phoneNumber;
    data['phone_code'] = phoneCode;
    data['gender'] = gender;
    data['birth_date'] = birthDate;
    data['bio'] = bio;
    data['avatar'] = avatar;
    data['background_image'] = imgBackground;
    data['ec_fullname'] = ecFullName;
    data['ec_relationship'] = ecRelationShipId;
    data['ec_main_pcode'] = ecMainPhoneCd;
    data['ec_main_pnum'] = ecMainPhoneNumb;
    data['ec_alt_pcode'] = ecAltPhoneCd;
    data['ec_alt_pnum'] = ecAltPhoneNumb;
    data['name'] = name;
    data['has_password'] = hasPassword;
    data['ec_email'] = ecEmail;
    data['interactionStatus'] = interactionStatus;
    if (country != null) {
      data['country'] = country!.toJson();
    }
    if (sports != null) {
      data['sports'] = sports!.map((v) => v.toJson()).toList();
    }
    if (currency != null) {
      data['currency'] = currency!.toJson();
    }
    // if (media != null) {
    //   data['media'] = media!.map((v) => v.toJson()).toList();
    // }
    data['status'] = status;
    data['count_follower'] = countFollower;
    data['count_following'] = countFollowing;
    data['count_team'] = countTeam;
    return data;
  }
}

class Avatar {
  int? id;
  String? modelType;
  int? modelId;
  String? uuid;
  String? collectionName;
  String? name;
  String? fileName;
  String? mimeType;
  String? disk;
  String? conversionsDisk;
  int? size;
  int? orderColumn;
  String? createdAt;
  String? updatedAt;
  String? originalUrl;
  String? previewUrl;
  String? url;

  Avatar(
      {this.id,
      this.modelType,
      this.modelId,
      this.uuid,
      this.collectionName,
      this.name,
      this.fileName,
      this.mimeType,
      this.disk,
      this.conversionsDisk,
      this.size,
      this.orderColumn,
      this.createdAt,
      this.updatedAt,
      this.originalUrl,
      this.previewUrl,
      this.url});

  Avatar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modelType = json['model_type'];
    modelId = json['model_id'];
    uuid = json['uuid'];
    collectionName = json['collection_name'];
    name = json['name'];
    fileName = json['file_name'];
    mimeType = json['mime_type'];
    disk = json['disk'];
    conversionsDisk = json['conversions_disk'];
    size = json['size'];
    orderColumn = json['order_column'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    originalUrl = json['original_url'];
    previewUrl = json['preview_url'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['model_type'] = modelType;
    data['model_id'] = modelId;
    data['uuid'] = uuid;
    data['collection_name'] = collectionName;
    data['name'] = name;
    data['file_name'] = fileName;
    data['mime_type'] = mimeType;
    data['disk'] = disk;
    data['conversions_disk'] = conversionsDisk;
    data['size'] = size;
    data['order_column'] = orderColumn;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['original_url'] = originalUrl;
    data['preview_url'] = previewUrl;
    data['url'] = url;
    return data;
  }
}

class Country {
  int? id;
  String? name;
  String? code;
  String? phoneCode;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Country(
      {this.id,
      this.name,
      this.code,
      this.phoneCode,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    phoneCode = json['phone_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['phone_code'] = phoneCode;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class Sports {
  int? id;
  String? name;
  String? description;
  int? maxPlayerPerTeam;
  int? minPlayerPerTeam;
  String? isRequireChooseRole;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? creatorId;
  String? code;
  String? icon;
  Pivot? pivot;
  List<Media>? media;

  Sports(
      {this.id,
      this.name,
      this.description,
      this.maxPlayerPerTeam,
      this.minPlayerPerTeam,
      this.isRequireChooseRole,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.creatorId,
      this.code,
      this.icon,
      this.pivot,
      this.media});

  Sports.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    maxPlayerPerTeam = json['max_player_per_team'];
    minPlayerPerTeam = json['min_player_per_team'];
    isRequireChooseRole = json['is_require_choose_role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    creatorId = json['creator_id'];
    code = json['code'];
    icon = json['icon'] ?? '';
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(Media.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['max_player_per_team'] = maxPlayerPerTeam;
    data['min_player_per_team'] = minPlayerPerTeam;
    data['is_require_choose_role'] = isRequireChooseRole;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['creator_id'] = creatorId;
    data['code'] = code;
    data['icon'] = icon;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    if (media != null) {
      data['media'] = media!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Currency {
  int? id;
  int? countryId;
  String? name;
  String? code;
  String? symbol;
  String? createdAt;
  String? updatedAt;

  Currency(
      {this.id,
      this.countryId,
      this.name,
      this.code,
      this.symbol,
      this.createdAt,
      this.updatedAt});

  Currency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    name = json['name'];
    code = json['code'];
    symbol = json['symbol'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['country_id'] = countryId;
    data['name'] = name;
    data['code'] = code;
    data['symbol'] = symbol;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class UserIcon {
  int? id;
  String? modelType;
  int? modelId;
  String? uuid;
  String? collectionName;
  String? name;
  String? fileName;
  String? mimeType;
  String? disk;
  String? conversionsDisk;
  int? size;
  int? orderColumn;
  String? createdAt;
  String? updatedAt;
  String? originalUrl;
  String? previewUrl;
  String? url;

  UserIcon(
      {this.id,
      this.modelType,
      this.modelId,
      this.uuid,
      this.collectionName,
      this.name,
      this.fileName,
      this.mimeType,
      this.disk,
      this.conversionsDisk,
      this.size,
      this.orderColumn,
      this.createdAt,
      this.updatedAt,
      this.originalUrl,
      this.previewUrl,
      this.url});

  UserIcon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modelType = json['model_type'];
    modelId = json['model_id'];
    uuid = json['uuid'];
    collectionName = json['collection_name'];
    name = json['name'];
    fileName = json['file_name'];
    mimeType = json['mime_type'];
    disk = json['disk'];
    conversionsDisk = json['conversions_disk'];
    size = json['size'];
    orderColumn = json['order_column'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    originalUrl = json['original_url'];
    previewUrl = json['preview_url'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['model_type'] = modelType;
    data['model_id'] = modelId;
    data['uuid'] = uuid;
    data['collection_name'] = collectionName;
    data['name'] = name;
    data['file_name'] = fileName;
    data['mime_type'] = mimeType;
    data['disk'] = disk;
    data['conversions_disk'] = conversionsDisk;
    data['size'] = size;
    data['order_column'] = orderColumn;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['original_url'] = originalUrl;
    data['preview_url'] = previewUrl;
    data['url'] = url;
    return data;
  }
}

class Pivot {
  int? userId;
  int? sportId;

  Pivot({this.userId, this.sportId});

  Pivot.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    sportId = json['sport_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['sport_id'] = sportId;
    return data;
  }
}

class Media {
  int? id;
  String? modelType;
  int? modelId;
  String? uuid;
  String? collectionName;
  String? name;
  String? fileName;
  String? mimeType;
  String? disk;
  String? conversionsDisk;
  int? size;
  int? orderColumn;
  String? createdAt;
  String? updatedAt;
  String? originalUrl;
  String? previewUrl;

  Media(
      {this.id,
      this.modelType,
      this.modelId,
      this.uuid,
      this.collectionName,
      this.name,
      this.fileName,
      this.mimeType,
      this.disk,
      this.conversionsDisk,
      this.size,
      this.orderColumn,
      this.createdAt,
      this.updatedAt,
      this.originalUrl,
      this.previewUrl});

  Media.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modelType = json['model_type'];
    modelId = json['model_id'];
    uuid = json['uuid'];
    collectionName = json['collection_name'];
    name = json['name'];
    fileName = json['file_name'];
    mimeType = json['mime_type'];
    disk = json['disk'];
    conversionsDisk = json['conversions_disk'];
    size = json['size'];
    orderColumn = json['order_column'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    originalUrl = json['original_url'];
    previewUrl = json['preview_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['model_type'] = modelType;
    data['model_id'] = modelId;
    data['uuid'] = uuid;
    data['collection_name'] = collectionName;
    data['name'] = name;
    data['file_name'] = fileName;
    data['mime_type'] = mimeType;
    data['disk'] = disk;
    data['conversions_disk'] = conversionsDisk;
    data['size'] = size;
    data['order_column'] = orderColumn;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['original_url'] = originalUrl;
    data['preview_url'] = previewUrl;
    return data;
  }
}

class SportProfileModel {
  int? id;
  String? name;
  String? description;
  int? maxPlayerPerTeam;
  int? minPlayerPerTeam;
  String? isRequireChooseRole;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? creatorId;
  String? code;
  String? icon;
  Pivot? pivot;
  List<Media>? media;

  SportProfileModel(
      {this.id,
      this.name,
      this.description,
      this.maxPlayerPerTeam,
      this.minPlayerPerTeam,
      this.isRequireChooseRole,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.creatorId,
      this.code,
      this.icon,
      this.pivot,
      this.media});

  SportProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    maxPlayerPerTeam = json['max_player_per_team'];
    minPlayerPerTeam = json['min_player_per_team'];
    isRequireChooseRole = json['is_require_choose_role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    creatorId = json['creator_id'];
    code = json['code'];
    icon = json['icon'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(Media.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['max_player_per_team'] = maxPlayerPerTeam;
    data['min_player_per_team'] = minPlayerPerTeam;
    data['is_require_choose_role'] = isRequireChooseRole;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['creator_id'] = creatorId;
    data['code'] = code;
    data['icon'] = icon;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    if (media != null) {
      data['media'] = media!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
