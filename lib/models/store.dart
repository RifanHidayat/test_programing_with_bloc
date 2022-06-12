import 'dart:convert';

class StoreModel {
  var storeId;
  var storeCode;
  var storeName;
  var address;
  var dcName;
  var accountId;
  var accountName;
  var subCahnnelId;
  var subChannelName;

  StoreModel(
      {this.storeId,
      this.storeCode,
      this.storeName,
      this.address,
      this.dcName,
      this.accountId,
      this.accountName,
      this.subCahnnelId,
      this.subChannelName});

  Map<String, dynamic> toMap() {
    return {
      'store_id': storeId,
      'store_code': storeCode,
      'store_name': storeName,
      "address": address,
      'dc_name': dcName,
      'account_id': accountId,
      'account_name': accountName
    };
  }

  factory StoreModel.fromJson(Map<String, dynamic> map) {
    return StoreModel(
        storeId: map['store_id'],
        storeCode: map['store_code'],
        storeName: map['store_name'],
        address: map['address'],
        dcName: map['dc_name'],
        accountId: map['account_id'],
        accountName: map['account_name']);
  }

  static List<StoreModel> fromJsonToList(List data) {
    return List<StoreModel>.from(data.map(
      (item) => StoreModel.fromJson(item),
    ));
  }

  static String toJson(StoreModel data) {
    final mapData = data.toMap();
    return json.encode(mapData);
  }
}
