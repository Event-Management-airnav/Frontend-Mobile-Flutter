import 'package:flutter/material.dart';
import 'package:frontend_mobile_flutter/core/app_colors.dart';
import 'package:frontend_mobile_flutter/modules/event_detail/event_detail_controller.dart';
import 'package:frontend_mobile_flutter/modules/participant/home/widgets/register_event_popup.dart';
import 'package:get/get.dart';
import 'package:frontend_mobile_flutter/modules/participant/activity/widgets/app_bar.dart';
import 'package:frontend_mobile_flutter/modules/participant/home/home_controller.dart';

import '../participant/home/widgets/greeting_header.dart';
import '../participant/home/widgets/event_hero_card.dart';
import '../participant/home/widgets/about_event_card.dart';
import '../participant/home/widgets/section_tile_card.dart';
import '../participant/home/widgets/info_list_card.dart';
import '../participant/home/widgets/additional_info_card.dart';

class DetailPage extends GetView<EventDetailController> {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF005EA2);



    // TODO: ambil data dari controller kalau sudah ada
    const userName = 'Akbar';
    const registeredCount = 2;
    const totalEvents = 6;

    return Scaffold(
      appBar: TAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GreetingHeader(
              userName: userName,
              subtitle:
                  'Kamu terdaftar di $registeredCount dari $totalEvents event yang tersedia',
            ),
            const SizedBox(height: 16),

            const EventHeroCard(
              title: 'Smart & Precision Event Management System',
              location: 'AirNav, Tangerang',
              dateTimeText: '25 Oktober 2026, 09:00 - 12:00 WIB',
              imageAsset: 'assets/images/event-image.jpg',
              borderColor: Color(0xFF005EA2),
            ),

            const SizedBox(height: 20),

            AboutEventCard(
              titleWidget: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.titleLarge,
                  children: [
                    const TextSpan(text: 'Tentang '),
                    TextSpan(
                      text: 'Smart & Precision',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(text: '\nEvent Management'),
                  ],
                ),
              ),
              description:
                  'AirNav Event Management is a smart and integrated system designed to ensure efficiency, precision, and professionalism in every event. With advanced technology and an intuitive interface, it simplifies scheduling, participant management, and progress monitoring.',
              primaryColor: primaryColor,
              onRegister: () {
                // TODO: aksi daftar
                RegisterEventPopup.show(
                  context,
                  onSubmit: (agree, offline, online) {},
                );
              },
              onShareWhatsapp: () {},
              onShareFacebook: () {},
              onCopyLink: () {},
            ),

            const SizedBox(height: 16),

            SectionTileCard(
              leadingIcon: Icons.description_outlined,
              iconColor: primaryColor,
              title: 'Susunan Acara',
              trailing: TextButton(
                onPressed: () {
                  // TODO: buka detail susunan
                },
                child: const Text('Lihat Detail'),
              ),
              onTap: () {
                // TODO: optional tap
              },
            ),

            const SizedBox(height: 10),

            SectionTileCard(
              leadingIcon: Icons.menu_book_outlined,
              iconColor: primaryColor,
              title: 'Modul Acara',
              trailing: IconButton(
                onPressed: () {
                  // TODO: download modul
                },
                icon: const Icon(Icons.download_rounded),
                color: primaryColor,
              ),
              onTap: () {},
            ),

            const SizedBox(height: 16),

            const InfoListCard(
              title: 'Informasi Acara',
              items: [
                InfoItem(label: 'Alamat', value: 'Airnav, Tangerang'),
                InfoItem(
                  label: 'Pendaftaran',
                  value: '11 Okt 2026 - 20 Okt 2026',
                ),
                InfoItem(label: 'Jam Acara', value: '09.00 - 12.00 WIB'),
                InfoItem(label: 'Tanggal Acara', value: '25 Oktober 2026'),
              ],
            ),

            const SizedBox(height: 16),

            const AdditionalInfoCard(
              title: 'Informasi Tambahan',
              contentLines: [
                'Dress Code :',
                'Baju warna putih',
                'Celana/Rok berwarna hitam',
              ],
            ),
          ],
        ),
      ),
    );
  }
}
