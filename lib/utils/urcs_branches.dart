import 'package:redcross/models/branch.dart';

/// Bundled fallback list of URCS branches for the Branch Locator, used when
/// the `branches` API endpoint is unavailable or returns nothing.
///
/// ⚠ SEED DATA — replace before release. URCS has 51 branches; this list
/// covers the main district branches only. Coordinates are approximate
/// district-town centres, NOT verified branch-office GPS points (except
/// Kampala HQ on Rubaga Road, and Adjumani / Apac, which come from the
/// existing volunteer-registration data). The ideal fix is to serve
/// id/name/region/latitude/longitude/address/phone from the API and let this
/// list fall away.
class UrcsBranches {
  static Branch _b(int id, String name, String region, double lat, double lng,
          {String? address, String? phone}) =>
      Branch(
        id: id,
        name: name,
        districts: '',
        region: region,
        latitude: lat,
        longitude: lng,
        address: address,
        phone: phone,
      );

  static final List<Branch> seed = [
    // Central
    _b(-1, 'Kampala (National HQ)', 'Central', 0.3030, 32.5640,
        address: 'Plot 551/555 Rubaga Road, Kampala'),
    _b(-2, 'Wakiso', 'Central', 0.4044, 32.4594),
    _b(-3, 'Mukono', 'Central', 0.3533, 32.7553),
    _b(-4, 'Mpigi', 'Central', 0.2250, 32.3136),
    _b(-5, 'Masaka', 'Central', -0.3338, 31.7341),
    _b(-6, 'Rakai', 'Central', -0.7167, 31.4833),
    _b(-7, 'Kalangala', 'Central', -0.3089, 32.2250),
    _b(-8, 'Sembabule', 'Central', -0.0772, 31.4567),
    _b(-9, 'Mityana', 'Central', 0.4175, 32.0228),
    _b(-10, 'Mubende', 'Central', 0.5576, 31.3950),
    _b(-11, 'Luweero', 'Central', 0.8492, 32.4731),
    _b(-12, 'Nakasongola', 'Central', 1.3089, 32.4564),
    _b(-13, 'Kayunga', 'Central', 0.7025, 32.8886),
    _b(-14, 'Kiboga', 'Central', 0.9161, 31.7742),
    // Eastern
    _b(-20, 'Jinja', 'Eastern', 0.4244, 33.2042),
    _b(-21, 'Iganga', 'Eastern', 0.6092, 33.4686),
    _b(-22, 'Kamuli', 'Eastern', 0.9472, 33.1197),
    _b(-23, 'Bugiri', 'Eastern', 0.5714, 33.7417),
    _b(-24, 'Mayuge', 'Eastern', 0.4597, 33.4803),
    _b(-25, 'Busia', 'Eastern', 0.4669, 34.0900),
    _b(-26, 'Tororo', 'Eastern', 0.6928, 34.1808),
    _b(-27, 'Mbale', 'Eastern', 1.0806, 34.1750),
    _b(-28, 'Sironko', 'Eastern', 1.2306, 34.2481),
    _b(-29, 'Kapchorwa', 'Eastern', 1.3964, 34.4508),
    _b(-30, 'Pallisa', 'Eastern', 1.1450, 33.7094),
    _b(-31, 'Kumi', 'Eastern', 1.4608, 33.9361),
    _b(-32, 'Soroti', 'Eastern', 1.7147, 33.6111),
    _b(-33, 'Katakwi', 'Eastern', 1.8911, 33.9661),
    // Northern / Karamoja / West Nile
    _b(-40, 'Lira', 'Northern', 2.2350, 32.9097),
    _b(97, 'Apac', 'Northern', 1.9337258, 32.5018028),
    _b(-41, 'Gulu', 'Northern', 2.7746, 32.2990),
    _b(-42, 'Kitgum', 'Northern', 3.2783, 32.8867),
    _b(-43, 'Pader', 'Northern', 2.8806, 33.0861),
    _b(-44, 'Moroto', 'Karamoja', 2.5345, 34.6666),
    _b(-45, 'Kotido', 'Karamoja', 2.9806, 34.1331),
    _b(-46, 'Kaabong', 'Karamoja', 3.4836, 34.1492),
    _b(-47, 'Arua', 'West Nile', 3.0201, 30.9111),
    _b(-48, 'Nebbi', 'West Nile', 2.4783, 31.0889),
    _b(-49, 'Koboko', 'West Nile', 3.4136, 30.9600),
    _b(-50, 'Yumbe', 'West Nile', 3.4651, 31.2469),
    _b(-51, 'Moyo', 'West Nile', 3.6609, 31.7247),
    _b(57, 'Adjumani', 'West Nile', 3.237128, 31.7858246),
    // Western
    _b(-60, 'Mbarara', 'Western', -0.6072, 30.6545),
    _b(-61, 'Isingiro', 'Western', -0.8436, 30.8039),
    _b(-62, 'Ntungamo', 'Western', -0.8794, 30.2642),
    _b(-63, 'Bushenyi', 'Western', -0.5853, 30.2114),
    _b(-64, 'Ibanda', 'Western', -0.1336, 30.4950),
    _b(-65, 'Rukungiri', 'Western', -0.7900, 29.9250),
    _b(-66, 'Kanungu', 'Western', -0.8975, 29.7897),
    _b(-67, 'Kabale', 'Western', -1.2486, 29.9899),
    _b(-68, 'Kisoro', 'Western', -1.2854, 29.6850),
    _b(-69, 'Kasese', 'Western', 0.1833, 30.0833),
    _b(-70, 'Fort Portal (Kabarole)', 'Western', 0.6710, 30.2750),
    _b(-71, 'Bundibugyo', 'Western', 0.7085, 30.0634),
    _b(-72, 'Kyenjojo', 'Western', 0.6328, 30.6214),
    _b(-73, 'Hoima', 'Western', 1.4331, 31.3524),
    _b(-74, 'Masindi', 'Western', 1.6744, 31.7150),
    _b(-75, 'Kibaale', 'Western', 0.7969, 31.0767),
  ];
}
