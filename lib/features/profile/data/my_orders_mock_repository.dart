import 'package:sayyor/core/l10n/app_localizations.dart';

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
  final String price;
  final String location;
  final String completedOn;
  final bool isCompleted;
  final bool isMine;
  final MyOrderReviewData? review;

  const MyOrderData({
    required this.id,
    required this.serviceTitle,
    required this.masterName,
    required this.masterAvatarUrl,
    required this.price,
    required this.location,
    required this.completedOn,
    required this.isCompleted,
    required this.isMine,
    this.review,
  });

  MyOrderData copyWith({MyOrderReviewData? review}) {
    return MyOrderData(
      id: id,
      serviceTitle: serviceTitle,
      masterName: masterName,
      masterAvatarUrl: masterAvatarUrl,
      price: price,
      location: location,
      completedOn: completedOn,
      isCompleted: isCompleted,
      isMine: isMine,
      review: review ?? this.review,
    );
  }
}

class MyOrdersFeedData {
  final List<MyOrderData> activeOrders;
  final List<MyOrderData> completedOrders;

  const MyOrdersFeedData({
    required this.activeOrders,
    required this.completedOrders,
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
          price: '150,000 so\'m',
          location: 'Yunusobod tumani',
          completedOn: '---',
          isCompleted: false,
          isMine: true,
          review: null,
        ),
        MyOrderData(
          id: 'order-2',
          serviceTitle: l10n.homeJobRequestTwoTitle,
          masterName: 'Sherzod Valiyev',
          masterAvatarUrl: 'https://i.pravatar.cc/150?img=12',
          price: '120,000 so\'m',
          location: 'Chilonzor tumani',
          completedOn: '---',
          isCompleted: false,
          isMine: true,
          review: null,
        ),
      ],
      completedOrders: <MyOrderData>[
        MyOrderData(
          id: 'order-3',
          serviceTitle: l10n.homeMasterPortfolioItemOneDescription,
          masterName: 'Jasur Rahmatov',
          masterAvatarUrl: 'https://i.pravatar.cc/150?img=15',
          price: '180,000 so\'m',
          location: 'Mirzo Ulug\'bek tumani',
          completedOn: '2026-04-12',
          isCompleted: true,
          isMine: true,
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
          price: '250,000 so\'m',
          location: 'Chilonzor tumani',
          completedOn: '2026-04-08',
          isCompleted: true,
          isMine: true,
          review: null,
        ),
      ],
    );
  }
}
