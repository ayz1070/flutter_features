/// 기본 포인트 예외 클래스
class PointException implements Exception {
  final String message;       // 예외 메시지
  final String? pointId;      // 관련된 포인트 ID (선택 사항)
  final String? origin;       // 예외 발생 위치 (선택 사항)

  PointException(this.message, {this.pointId, this.origin});

  @override
  String toString() {
    String result = '포인트 예외: $message';
    if (pointId != null) result += ' (포인트 ID: $pointId)';
    if (origin != null) result += ' - 발생 위치: $origin';
    return result;
  }
}

/// 포인트를 찾지 못한 경우의 예외
class PointNotFoundException extends PointException {
  PointNotFoundException(String pointId, {String? origin})
      : super('$pointId에 해당하는 포인트를 찾을 수 없습니다.', pointId: pointId, origin: origin);
}

/// 포인트 데이터 유효성 검사 실패 예외
class InvalidPointDataException extends PointException {
  InvalidPointDataException(String message, {String? origin})
      : super(message, origin: origin);
}

/// Firestore와 관련된 예외
class PointFirestoreException extends PointException {
  PointFirestoreException(String message, {String? pointId, String? origin})
      : super('Firestore 오류: $message', pointId: pointId, origin: origin);
}

/// 포인트 초과 예외
class PointLimitExceededException extends PointException {
  PointLimitExceededException(double attemptedPoints, double maxPoints, {String? origin})
      : super(
    '시도한 포인트: $attemptedPoints, 최대 허용 포인트: $maxPoints를 초과했습니다.',
    origin: origin,
  );
}

/// 포인트 만료 예외
class PointExpiredException extends PointException {
  PointExpiredException(String pointId, DateTime expireDate, {String? origin})
      : super(
    '$pointId 포인트가 만료되었습니다. 만료일: ${expireDate.toIso8601String()}',
    pointId: pointId,
    origin: origin,
  );
}

/// 포인트 접근 권한 없음 예외
class PointAccessDeniedException extends PointException {
  PointAccessDeniedException(String pointId, {String? origin})
      : super('$pointId 포인트에 접근할 권한이 없습니다.', pointId: pointId, origin: origin);
}

/// 포인트 초기화 실패 예외
class PointInitializationException extends PointException {
  PointInitializationException(String message, {String? origin})
      : super('포인트 초기화 중 오류가 발생했습니다: $message', origin: origin);
}

/// 네트워크 연결 문제 예외
class PointNetworkException extends PointException {
  PointNetworkException({String? origin})
      : super('네트워크 연결 문제로 포인트 요청이 실패했습니다.', origin: origin);
}
