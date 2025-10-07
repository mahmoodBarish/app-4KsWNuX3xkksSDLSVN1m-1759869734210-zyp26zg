import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackgroundImage(),
          Positioned.fill(
            top: MediaQuery.of(context).size.height * 0.35,
            child: Image.asset(
              'assets/images/I235_316_284_2232_284_2228.png',
              fit: BoxFit.contain,
              alignment: Alignment.bottomCenter,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 1),
                _WeatherInfoSection(),
                const Spacer(flex: 4),
              ],
            ),
          ),
          _BottomModalSheet(),
          const _CustomBottomNavBar(),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-0.89, -0.99),
          end: Alignment(0.81, 0.98),
          colors: [Color(0xFF2E335A), Color(0xFF1C1B33)],
        ),
      ),
      child: Image.asset(
        'assets/images/I235_316_61_4119_218_4440.png',
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        opacity: const AlwaysStoppedAnimation(.2),
      ),
    );
  }
}

class _WeatherInfoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Montreal',
          style: GoogleFonts.inter(
            fontSize: 34,
            fontWeight: FontWeight.w400,
            color: Colors.white,
            letterSpacing: 0.37,
          ),
        ),
        Text(
          '19°',
          style: GoogleFonts.inter(
            fontSize: 96,
            fontWeight: FontWeight.w200,
            color: Colors.white,
          ),
        ),
        Text(
          'Mostly Clear',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white.withOpacity(0.6),
            letterSpacing: 0.38,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'H:24°   L:18°',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 0.38,
          ),
        ),
      ],
    );
  }
}

class _BottomModalSheet extends StatefulWidget {
  @override
  _BottomModalSheetState createState() => _BottomModalSheetState();
}

class _BottomModalSheetState extends State<_BottomModalSheet> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.42,
      minChildSize: 0.42,
      maxChildSize: 0.85,
      builder: (context, scrollController) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(44)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: const Alignment(0.03, -1.0),
                  end: const Alignment(-0.03, 1.0),
                  colors: [
                    const Color(0xFF2E335A).withOpacity(0.26),
                    const Color(0xFF1C1B33).withOpacity(0.26),
                  ],
                ),
                border: Border(
                  top: BorderSide(
                    color: Colors.white.withOpacity(0.5),
                    width: 1,
                  ),
                ),
              ),
              child: ListView(
                controller: scrollController,
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: 48,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  _buildForecastTabs(),
                  const SizedBox(height: 16),
                  _buildHourlyForecastList(),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: _buildDailyForecastSummary(),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildForecastTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => setState(() => _selectedTabIndex = 0),
                child: Text(
                  'Hourly Forecast',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: _selectedTabIndex == 0
                        ? Colors.white
                        : Colors.white.withOpacity(0.6),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _selectedTabIndex = 1),
                child: Text(
                  'Weekly Forecast',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: _selectedTabIndex == 1
                        ? Colors.white
                        : Colors.white.withOpacity(0.6),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(color: Color(0x4DFFFFFF), height: 1),
        ],
      ),
    );
  }

  Widget _buildDailyForecastSummary() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Image.asset(
        'assets/images/I235_316_195_3265_195_3198.png',
        fit: BoxFit.cover,
      ),
    );
  }
}

class HourlyForecast {
  final String time;
  final String iconAsset;
  final String temperature;
  final bool isActive;
  final String? precipitation;

  HourlyForecast({
    required this.time,
    required this.iconAsset,
    required this.temperature,
    this.isActive = false,
    this.precipitation,
  });
}

Widget _buildHourlyForecastList() {
  final List<HourlyForecast> forecastData = [
    HourlyForecast(
        time: '12 AM',
        iconAsset:
            'assets/images/I235_316_61_4526_50_1822_229_4455_229_4451_217_4578.png',
        temperature: '19°',
        precipitation: '30%'),
    HourlyForecast(
        time: 'Now',
        iconAsset:
            'assets/images/I235_316_61_4526_50_1823_232_4582_229_4451_217_4578.png',
        temperature: '19°',
        isActive: true),
    HourlyForecast(
        time: '2 AM',
        iconAsset:
            'assets/images/I235_316_61_4526_50_1824_229_4491_229_4451_229_4526_217_4571.png',
        temperature: '18°'),
    HourlyForecast(
        time: '3 AM',
        iconAsset:
            'assets/images/I235_316_61_4526_50_1825_229_4499_229_4451_217_4578.png',
        temperature: '19°'),
    HourlyForecast(
        time: '4 AM',
        iconAsset:
            'assets/images/I235_316_61_4526_50_1826_229_4507_229_4451_217_4578.png',
        temperature: '19°'),
  ];

  return SizedBox(
    height: 146,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: forecastData.length,
      separatorBuilder: (context, index) => const SizedBox(width: 12),
      itemBuilder: (context, index) {
        final item = forecastData[index];
        return _HourlyForecastCard(item: item);
      },
    ),
  );
}

class _HourlyForecastCard extends StatelessWidget {
  final HourlyForecast item;

  const _HourlyForecastCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: item.isActive
            ? const Color(0xFF48319D)
            : const Color(0x3348319D),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.white.withOpacity(item.isActive ? 0.5 : 0.2),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            item.time,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          if (item.precipitation != null) ...[
            Image.asset(item.iconAsset, width: 32, height: 32),
            Text(
              item.precipitation!,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF40C8D4),
              ),
            )
          ] else ...[
            Image.asset(item.iconAsset, width: 32, height: 32),
          ],
          Text(
            item.temperature,
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomBottomNavBar extends StatelessWidget {
  const _CustomBottomNavBar();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SizedBox(
        height: 100,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.asset(
              'assets/images/I235_316_68_4450_61_8091.png',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
            Positioned(
              bottom: 14,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.location_on_outlined,
                        color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 130),
                  IconButton(
                    onPressed: () {},
                    icon:
                        const Icon(Icons.list, color: Colors.white, size: 28),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 28,
              child: GestureDetector(
                onTap: () {
                  context.push('/weather_search_add');
                },
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment(0.3, -0.95),
                      end: Alignment(-0.3, 0.95),
                      colors: [Color(0xFFF8F8FA), Color(0xFFD5DAE0)],
                    ),
                  ),
                  child: const Icon(Icons.add,
                      color: Color(0xFF48319D), size: 32),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}