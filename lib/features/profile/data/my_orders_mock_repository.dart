import 'package:sayyor/core/l10n/app_localizations.dart';

class MasterEarningPointData {
  final String periodLabel;
  final int amount;

  const MasterEarningPointData({
    required this.periodLabel,
    required this.amount,
  });
}

class MyOrderReviewData {
  final double rating;
  final String text;

  const MyOrderReviewData({required this.rating, required this.text});

  MyOrderReviewData copyWith({double? rating, String? text}) {
    return MyOrderReviewData(
      rating: rating ?? this.rating,
      text: text ?? this.text,
    );
  }
}

class MyOrderData {
  final String id;
  final String serviceTitle;
  final String masterName;
  final String masterAvatarUrl;
  final String customerName;
  final String customerAvatarUrl;
  final String price;
  final String location;
  final String completedOn;
  final bool isCompleted;
  final bool isMine;
  final bool isAsMaster;
  final MyOrderReviewData? review;

  const MyOrderData({
    required this.id,
    required this.serviceTitle,
    required this.masterName,
    required this.masterAvatarUrl,
    required this.customerName,
    required this.customerAvatarUrl,
    required this.price,
    required this.location,
    required this.completedOn,
    required this.isCompleted,
    required this.isMine,
    required this.isAsMaster,
    this.review,
  });

  MyOrderData copyWith({MyOrderReviewData? review}) {
    return MyOrderData(
      id: id,
      serviceTitle: serviceTitle,
      masterName: masterName,
      masterAvatarUrl: masterAvatarUrl,
      customerName: customerName,
      customerAvatarUrl: customerAvatarUrl,
      price: price,
      location: location,
      completedOn: completedOn,
      isCompleted: isCompleted,
      isMine: isMine,
      isAsMaster: isAsMaster,
      review: review ?? this.review,
    );
  }
}

class MyOrdersFeedData {
  final List<MyOrderData> activeOrders;
  final List<MyOrderData> completedOrders;
  final List<MyOrderData> providedServices;
  final List<MyOrderData> usedMasterServices;
  final List<MasterEarningPointData> earningsTimeline;

  const MyOrdersFeedData({
    required this.activeOrders,
    required this.completedOrders,
    required this.providedServices,
    required this.usedMasterServices,
    required this.earningsTimeline,
  });
}

class MyOrdersMockRepository {
  Future<MyOrdersFeedData> loadOrders(AppLocalizations l10n) async {
    await Future<void>.delayed(const Duration(milliseconds: 550));

    return MyOrdersFeedData(
      activeOrders: <MyOrderData>[
        MyOrderData(
          id: 'order-1',
          serviceTitle: l10n.homeJobRequestOneTitle,
          masterName: 'Alisher Tursunov',
          masterAvatarUrl: 'https://i.pravatar.cc/150?img=11',
          customerName: 'Toshmat Eshmatov',
          customerAvatarUrl: 'https://i.pravatar.cc/150?img=32',
          price: '150,000 so\'m',
          location: 'Yunusobod tumani',
          completedOn: '---',
          isCompleted: false,
          isMine: true,
          isAsMaster: false,
          review: null,
        ),
        MyOrderData(
          id: 'order-2',
          serviceTitle: l10n.homeJobRequestTwoTitle,
          masterName: 'Sherzod Valiyev',
          masterAvatarUrl: 'https://i.pravatar.cc/150?img=12',
          customerName: 'Toshmat Eshmatov',
          customerAvatarUrl: 'https://i.pravatar.cc/150?img=32',
          price: '120,000 so\'m',
          location: 'Chilonzor tumani',
          completedOn: '---',
          isCompleted: false,
          isMine: true,
          isAsMaster: false,
          review: null,
        ),
      ],
      completedOrders: <MyOrderData>[
        MyOrderData(
          id: 'order-3',
          serviceTitle: l10n.homeMasterPortfolioItemOneDescription,
          masterName: 'Jasur Rahmatov',
          masterAvatarUrl: 'https://i.pravatar.cc/150?img=15',
          customerName: 'Toshmat Eshmatov',
          customerAvatarUrl: 'https://i.pravatar.cc/150?img=32',
          price: '180,000 so\'m',
          location: 'Mirzo Ulug\'bek tumani',
          completedOn: '2026-04-12',
          isCompleted: true,
          isMine: true,
          isAsMaster: false,
          review: const MyOrderReviewData(
            rating: 4.5,
            text:
                'Usta tez keldi, ishni sifatli bajardi. Muloqot ham yaxshi bo\'ldi.',
          ),
        ),
        MyOrderData(
          id: 'order-4',
          serviceTitle: l10n.homeMasterPortfolioItemTwoDescription,
          masterName: 'Sherzod Valiyev',
          masterAvatarUrl: 'https://i.pravatar.cc/150?img=12',
          customerName: 'Toshmat Eshmatov',
          customerAvatarUrl: 'https://i.pravatar.cc/150?img=32',
          price: '250,000 so\'m',
          location: 'Chilonzor tumani',
          completedOn: '2026-04-08',
          isCompleted: true,
          isMine: true,
          isAsMaster: false,
          review: null,
        ),
      ],
      providedServices: <MyOrderData>[
        MyOrderData(
          id: 'master-work-1',
          serviceTitle: l10n.homeMasterPortfolioItemOneDescription,
          masterName: 'Maxmud Karimov',
          masterAvatarUrl: 'https://i.pravatar.cc/150?img=44',
          customerName: 'Dilnoza Alimuhamedova',
          customerAvatarUrl: 'https://i.pravatar.cc/150?img=5',
          price: '220,000 so\'m',
          location: 'Yashnobod tumani',
          completedOn: '2026-04-20',
          isCompleted: true,
          isMine: true,
          isAsMaster: true,
          review: null,
        ),
        MyOrderData(
          id: 'master-work-2',
          serviceTitle: l10n.homeMasterPortfolioItemTwoDescription,
          masterName: 'Maxmud Karimov',
          masterAvatarUrl: 'https://i.pravatar.cc/150?img=44',
          customerName: 'Sarvar Nosirov',
          customerAvatarUrl: 'https://i.pravatar.cc/150?img=30',
          price: '310,000 so\'m',
          location: 'Olmazor tumani',
          completedOn: '2026-04-17',
          isCompleted: true,
          isMine: true,
          isAsMaster: true,
          review: null,
        ),
        MyOrderData(
          id: 'master-work-3',
          serviceTitle: l10n.homeJobRequestOneTitle,
          masterName: 'Maxmud Karimov',
          masterAvatarUrl: 'https://i.pravatar.cc/150?img=44',
          customerName: 'Umid Islomov',
          customerAvatarUrl: 'https://i.pravatar.cc/150?img=52',
          price: '180,000 so\'m',
          location: 'Sergeli tumani',
          completedOn: '2026-04-14',
          isCompleted: true,
          isMine: true,
          isAsMaster: true,
          review: null,
        ),
      ],
      usedMasterServices: <MyOrderData>[
        MyOrderData(
          id: 'used-service-1',
          serviceTitle: l10n.homeJobRequestTwoTitle,
          masterName: 'Kamoliddin Ergashev',
          masterAvatarUrl: 'https://i.pravatar.cc/150?img=61',
          customerName: 'Maxmud Karimov',
          customerAvatarUrl: 'https://i.pravatar.cc/150?img=44',
          price: '140,000 so\'m',
          location: 'Bektemir tumani',
          completedOn: '2026-04-09',
          isCompleted: true,
          isMine: true,
          isAsMaster: false,
          review: const MyOrderReviewData(
            rating: 5,
            text: 'Kelishilgan vaqtda kelib, ishni toza qilib tugatdi.',
          ),
        ),
      ],
      earningsTimeline: const <MasterEarningPointData>[
        MasterEarningPointData(periodLabel: 'Yan', amount: 1150000),
        MasterEarningPointData(periodLabel: 'Fev', amount: 1430000),
        MasterEarningPointData(periodLabel: 'Mar', amount: 1670000),
        MasterEarningPointData(periodLabel: 'Apr', amount: 2010000),
        MasterEarningPointData(periodLabel: 'May', amount: 1760000),
        MasterEarningPointData(periodLabel: 'Iyn', amount: 2210000),
      ],
    );
  }
}
