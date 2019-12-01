class Consumption {
  int collectionCount;
  int shareCount;
  int replyCount;
  int realCollectionCount;

  Consumption.fromJson(Map<String, dynamic> json) {
    collectionCount = json['collectionCount'];
    shareCount = json['shareCount'];
    replyCount = json['replyCount'];
    realCollectionCount = json['realCollectionCount'];
  }

  @override
  String toString() {
    return 'Consumption{ collectionCount: $collectionCount,shareCount:$shareCount,replyCount:$replyCount, realCollectionCount:$realCollectionCount}';
  }
}
