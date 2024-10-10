import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantix_app/app/core/theme/app_color.dart';
import 'package:plantix_app/app/core/theme/typography.dart';
import 'package:plantix_app/app/core/widgets/custom_loading.dart';
import 'package:plantix_app/app/modules/home/home_controller.dart';
import 'package:plantix_app/app/modules/home/widgets/card_article_widget.dart';
import 'package:plantix_app/app/routes/analisa_usaha_tani_routes.dart';
import 'package:plantix_app/app/routes/calendar_routes.dart';
import 'package:plantix_app/app/routes/kalkulasi_tanam_routes.dart';
import 'package:plantix_app/app/routes/lahan_tanam_routes.dart';

Widget buildHomePage(BuildContext context, HomeController controller) {
  return Column(
    children: [
      buildUserProfileHeader(context, controller),
      const SizedBox(height: 2.0),
      Expanded(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildBanner(controller),
              const SizedBox(height: 12.0),
              const Text(
                "Ayo Mulai!",
                style: TStyle.head4,
              ),
              buildMenuGrid(context),
              const SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Artikel Pertanian",
                    style: TStyle.head4,
                  ),
                  const SizedBox(width: 4),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Lihat Semua",
                      style:
                          TStyle.bodyText2.copyWith(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12.0,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    5, // Jumlah item yang ingin ditampilkan
                    (index) => const Padding(
                      padding: EdgeInsets.only(right: 12.0),
                      child: ArtikelPertanianCard(
                        judulArtikel: 'Lorem ipsum dolor sit amet',
                        penulis: 'Penulis Artikel',
                        tanggalPublikasi: '15 Maret 2024',
                        gambarUrl:
                            "https://i0.wp.com/walhisulteng.org/wp-content/uploads/2024/09/WhatsApp-Image-2024-09-24-at-01.44.41.jpeg?w=1283&ssl=1",
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Builder buildBanner(HomeController controller) {
  return Builder(builder: (context) {
    List images = [
      "https://stockistnasa.com/wp-content/uploads/2015/04/produk-nasa-pertanian.jpg",
      "https://biopsagrotekno.co.id/wp-content/uploads/2021/09/Harga-Produk-Pertanian-Tidak-Stabil-Ini-Alasannya.jpg",
      "https://portal.sukoharjokab.go.id/wp-content/uploads/2021/11/259488491_1078707562878980_8521623073405566500_n.jpg",
      "https://img.freepik.com/free-vector/hand-drawn-agriculture-company-sale-banner_23-2149696779.jpg"
    ];

    return Column(
      children: [
        CarouselSlider(
          carouselController: controller.carouselSliderController,
          options: CarouselOptions(
            height: 160.0,
            autoPlay: true,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              controller.currentIndex.value = index;
            },
          ),
          items: images.map((imageUrl) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  clipBehavior: Clip.antiAlias,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(3, 6),
                        blurRadius: 6,
                      ),
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(6.0),
                    ),
                  ),
                  child: Image.network(
                    filterQuality: FilterQuality.low,
                    imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: LoadingWidget(size: 24),
                      );
                    },
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error, color: Colors.red),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              "Gagal memuat gambar",
                              style: TextStyle(
                                fontSize: 8.0,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(
          height: 4.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: images.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () =>
                  controller.carouselSliderController.animateToPage(entry.key),
              child: Obx(() {
                return Container(
                  width: 6.0,
                  height: 6.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 3.5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? AppColors.secondary
                            : AppColors.secondary.withOpacity(
                                0.6,
                              ))
                        .withOpacity(controller.currentIndex.value == entry.key
                            ? 0.9
                            : 0.4),
                  ),
                );
              }),
            );
          }).toList(),
        ),
      ],
    );
  });
}

Widget buildUserProfileHeader(BuildContext context, HomeController controller) {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          AppColors.secondary,
          AppColors.primary,
        ],
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hai, Pak Tani 👋',
                  style: TStyle.head3.copyWith(
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Lahan: 2 hektar | Tanaman: Padi',
                  style: TStyle.bodyText2.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                // Get.toNamed(NotificationRoutes.notification);
              },
              child: Badge(
                label: Obx(() {
                  return Text(
                    controller.getNotificationLength().toString(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  );
                }),
                child: const Icon(Icons.notifications,
                    size: 24.0, color: AppColors.background),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildMenuGrid(BuildContext context) {
  final List<Map<String, dynamic>> menuItems = [
    {
      'icon': Icons.calendar_today,
      'title': 'Jadwal Tanam',
      'route': CalendarRoutes.calendar
    },
    {
      'icon': Icons.article,
      'title': 'Lahan Tanam',
      'route': LahanTanamRoutes.lahanTanam
    },
    {
      'icon': Icons.calculate,
      'title': 'Kalkulasi Tanam',
      'route': KalkulasiTanamRoutes.kalkulasiTanam
    },
    {
      'icon': Icons.currency_exchange,
      'title': 'Analisa Usaha Tani',
      'route': AnalisaUsahaTaniRoutes.analisaUsahaTani
    },
  ];

  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: menuItems.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      childAspectRatio: 1.0,
    ),
    itemBuilder: (context, index) {
      return Card(
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Ink(
          child: InkWell(
            onTap: () {
              Get.toNamed(menuItems[index]['route']);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(menuItems[index]['icon'],
                    size: 35, color: AppColors.primary),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text(
                    menuItems[index]['title'],
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
