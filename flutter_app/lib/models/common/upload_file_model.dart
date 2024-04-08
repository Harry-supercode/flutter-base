class UploadFileModel {
  String? name;
  String? fileName;
  String? disk;
  String? conversionsDisk;
  String? collectionName;
  String? mimeType;
  int? size;
  dynamic customProperties;
  dynamic generatedConversions;
  dynamic responsiveImages;
  dynamic manipulations;
  int? modelId;
  String? modelType;
  String? uuid;
  int? orderColumn;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? originalUrl;
  String? previewUrl;

  UploadFileModel(
      {this.name,
      this.fileName,
      this.disk,
      this.conversionsDisk,
      this.collectionName,
      this.mimeType,
      this.size,
      this.customProperties,
      this.generatedConversions,
      this.responsiveImages,
      this.manipulations,
      this.modelId,
      this.modelType,
      this.uuid,
      this.orderColumn,
      this.updatedAt,
      this.createdAt,
      this.id,
      this.originalUrl,
      this.previewUrl});

  UploadFileModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    fileName = json['file_name'];
    disk = json['disk'];
    conversionsDisk = json['conversions_disk'];
    collectionName = json['collection_name'];
    mimeType = json['mime_type'];
    size = json['size'];
    // if (json['custom_properties'] != null) {
    //   customProperties = <Null>[];
    //   json['custom_properties'].forEach((v) {
    //     customProperties!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['generated_conversions'] != null) {
    //   generatedConversions = <Null>[];
    //   json['generated_conversions'].forEach((v) {
    //     generatedConversions!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['responsive_images'] != null) {
    //   responsiveImages = <Null>[];
    //   json['responsive_images'].forEach((v) {
    //     responsiveImages!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['manipulations'] != null) {
    //   manipulations = <Null>[];
    //   json['manipulations'].forEach((v) {
    //     manipulations!.add(new Null.fromJson(v));
    //   });
    // }
    modelId = json['model_id'];
    modelType = json['model_type'];
    uuid = json['uuid'];
    orderColumn = json['order_column'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    originalUrl = json['original_url'];
    previewUrl = json['preview_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['file_name'] = fileName;
    data['disk'] = disk;
    data['conversions_disk'] = conversionsDisk;
    data['collection_name'] = collectionName;
    data['mime_type'] = mimeType;
    data['size'] = size;
    // if (this.customProperties != null) {
    //   data['custom_properties'] =
    //       this.customProperties!.map((v) => v.toJson()).toList();
    // }
    // if (this.generatedConversions != null) {
    //   data['generated_conversions'] =
    //       this.generatedConversions!.map((v) => v.toJson()).toList();
    // }
    // if (this.responsiveImages != null) {
    //   data['responsive_images'] =
    //       this.responsiveImages!.map((v) => v.toJson()).toList();
    // }
    // if (this.manipulations != null) {
    //   data['manipulations'] =
    //       this.manipulations!.map((v) => v.toJson()).toList();
    // }
    data['model_id'] = modelId;
    data['model_type'] = modelType;
    data['uuid'] = uuid;
    data['order_column'] = orderColumn;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['original_url'] = originalUrl;
    data['preview_url'] = previewUrl;
    return data;
  }
}
