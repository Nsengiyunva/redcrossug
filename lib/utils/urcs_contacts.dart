/// Central place for URCS phone numbers and external links used across the
/// app, so a number change is a one-line edit instead of a hunt through
/// screens.
///
/// Source: redcrossug.org (Oct 2026) — "Call +256 760 588 189 — First Aid
/// Trainings & Commercial ambulances" and "Toll free 0800 211 088".
/// Confirm both with URCS Ops before release.
class UrcsContacts {
  // ── Commercial Ambulance Team ────────────────────────────────────────────
  static const String commercialAmbulanceTeamName =
      'URCS Commercial Ambulance Team';
  static const String commercialAmbulanceDisplay = '+256 760 588 189';
  static const String commercialAmbulanceDial = '+256760588189';

  // ── Emergency Response — Road Traffic Toll-Free Line ─────────────────────
  static const String roadTrafficTollFreeDisplay = '0800 211 088';
  static const String roadTrafficTollFreeDial = '0800211088';

  // ── Donations ────────────────────────────────────────────────────────────
  /// Donation page on the URCS website. Leave null until the web donation
  /// flow is live — the landing-page Donate button then shows a
  /// "coming soon" sheet instead of opening a browser. Set it to the real
  /// URL (e.g. 'https://redcrossug.org/donate') to switch the button over.
  static const String? donationUrl = null;
}
