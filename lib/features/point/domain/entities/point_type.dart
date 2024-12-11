enum PointType {
  EARNED,
  USED,
  EXPIRED,
}


extension PointTypeExtension on PointType {
  String get name {
    switch (this) {
      case PointType.EARNED:
        return 'earned';
      case PointType.USED:
        return 'used';
      case PointType.EXPIRED:
        return 'expired';
    }
  }
}