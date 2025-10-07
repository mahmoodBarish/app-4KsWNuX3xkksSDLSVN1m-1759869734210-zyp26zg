import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class WeatherSearchAdd extends StatelessWidget {
  const WeatherSearchAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF1C1C27),
            ),
          ),
          Positioned(
            top: 80,
            right: -150,
            child: _buildBlurCircle(352, const Color(0x80612FAD)),
          ),
          Positioned(
            bottom: 20,
            left: -180,
            child: _buildBlurCircle(365, const Color(0x80612FAD)),
          ),
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                _CustomAppBar(),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    itemCount: _weatherDataList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: _WeatherCard(data: _weatherDataList[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlurCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
        child: Container(
          padding: const EdgeInsets.only(bottom: 10),
          color: Colors.white.withOpacity(0.05),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new,
                                size: 22, color: Color(0x99EBEBF5)),
                            onPressed: () => context.pop(),
                          ),
                          Text(
                            'Weather',
                            style: GoogleFonts.raleway(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_horiz,
                          size: 28, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                child: TextField(
                  style: GoogleFonts.raleway(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0x421E203B),
                    hintText: 'Search for a city or airport',
                    hintStyle: GoogleFonts.raleway(
                      color: const Color(0x99EBEBF5),
                      fontSize: 17,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0x99EBEBF5),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WeatherCard extends StatelessWidget {
  final _WeatherData data;

  const _WeatherCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go('/home');
      },
      child: AspectRatio(
        aspectRatio: 342 / 184,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 30,
                offset: const Offset(0, 10),
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    data.backgroundPath,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF5A36B2).withOpacity(0.8),
                          const Color(0xFF362A84).withOpacity(0.8),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: -20,
                  right: 0,
                  child: Image.asset(
                    data.imagePath,
                    width: 160,
                    height: 160,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.city,
                                  style: GoogleFonts.raleway(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  data.temperature,
                                  style: GoogleFonts.raleway(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            data.largeTemp,
                            style: GoogleFonts.raleway(
                              color: Colors.white,
                              fontSize: 64,
                              fontWeight: FontWeight.w200,
                              letterSpacing: 0.37,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data.country,
                            style: GoogleFonts.raleway(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            data.condition,
                            style: GoogleFonts.raleway(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WeatherData {
  final String city;
  final String temperature;
  final String country;
  final String largeTemp;
  final String condition;
  final String imagePath;
  final String backgroundPath;

  _WeatherData({
    required this.city,
    required this.temperature,
    required this.country,
    required this.largeTemp,
    required this.condition,
    required this.imagePath,
    required this.backgroundPath,
  });
}

final List<_WeatherData> _weatherDataList = [
  _WeatherData(
    city: 'Montreal',
    temperature: 'H:24° L:18°',
    country: 'Canada',
    largeTemp: '19°',
    condition: 'Mid Rain',
    imagePath: 'assets/images/I235_1423_2_341_2_90.png',
    backgroundPath: 'assets/images/I235_316_61_4119.png',
  ),
  _WeatherData(
    city: 'Toronto',
    temperature: 'H:21° L:-19°',
    country: 'Canada',
    largeTemp: '20°',
    condition: 'Fast Wind',
    imagePath: 'assets/images/I235_1424_2_341_2_88.png',
    backgroundPath: 'assets/images/I235_316_61_4119.png',
  ),
  _WeatherData(
    city: 'Tokyo',
    temperature: 'H:16° L:8°',
    country: 'Japon',
    largeTemp: '13°',
    condition: 'Showers',
    imagePath: 'assets/images/I235_1425_2_341_2_92.png',
    backgroundPath: 'assets/images/I235_316_61_4119.png',
  ),
  _WeatherData(
    city: 'Tennessee',
    temperature: 'H:26° L:16°',
    country: 'United States',
    largeTemp: '23°',
    condition: 'Tornado',
    imagePath: 'assets/images/I235_1426_232_5277_232_5206_121_4339.png',
    backgroundPath: 'assets/images/I235_316_61_4119.png',
  ),
];