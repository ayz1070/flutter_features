class Grade {
  final int? id;
  final String name;
  final double pointRate;            // 포인트 적립률
  final List<String> benefits;       // 혜택 리스트
  final double discountRate;         // 등급별 할인률
  final double upgradeAmount;        // 등급 상향을 위한 최소 누적 구매 금액
  final int upgradePurchaseCount;    // 등급 상향을 위한 최소 구매 횟수
  final DateTime createdAt;          // 등급 생성 날짜
  final DateTime updatedAt;          // 등급 수정 날짜

  const Grade({
    this.id,
    required this.name,
    required this.pointRate,
    required this.benefits,
    required this.discountRate,
    required this.upgradeAmount,
    required this.upgradePurchaseCount,
    required this.createdAt,
    required this.updatedAt,
  });

  // 등급별 기본 데이터를 반환하는 함수
  static List<Grade> gradeList() {
    DateTime now = DateTime.now(); // 현재 시간을 생성 날짜와 수정 날짜로 사용
    return [
      Grade(
        name: 'welcome',
        pointRate: 1.0,
        benefits: [
          '좋은 혜택이 있습니다~'
        ],
        discountRate: 0,             // 기본 등급은 할인 없음
        upgradeAmount: 500000,        // 50만 원
        upgradePurchaseCount: 10,     // 10회
        createdAt: now,
        updatedAt: now,
      ),
      Grade(
        name: 'silver',
        pointRate: 1.5,
        benefits: [],
        discountRate: 0.02,           // 2% 할인
        upgradeAmount: 3000000,       // 300만 원
        upgradePurchaseCount: 20,     // 20회
        createdAt: now,
        updatedAt: now,
      ),
      Grade(
        name: 'gold',
        pointRate: 2.0,
        benefits: [],
        discountRate: 0.03,           // 3% 할인
        upgradeAmount: 5000000,       // 500만 원
        upgradePurchaseCount: 40,     // 40회
        createdAt: now,
        updatedAt: now,
      ),
      Grade(
        name: 'platinum',
        pointRate: 2.5,
        benefits: [],
        discountRate: 0.04,           // 4% 할인
        upgradeAmount: 10000000,      // 1,000만 원
        upgradePurchaseCount: 60,     // 60회
        createdAt: now,
        updatedAt: now,
      ),
      Grade(
        name: 'vip',
        pointRate: 3.0,
        benefits: [],
        discountRate: 0.05,           // 5% 할인
        upgradeAmount: 0,             // 최고 등급이므로 상향 조건 없음
        upgradePurchaseCount: 0,      // 최고 등급이므로 상향 조건 없음
        createdAt: now,
        updatedAt: now,
      ),
    ];
  }

  String getTranslatedName() {
    switch (name) {
      case 'welcome':
        return '웰컴';
      case 'silver':
        return '실버';
      case 'gold':
        return '골드';
      case 'platinum':
        return '플래티넘';
      case 'vip':
        return '브이아이피';
      default:
        return name;
    }
  }
}