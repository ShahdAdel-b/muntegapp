class StoreSetupData {
  String storeName;
  String description;
  String storeType;
  String category;
  String region;
  String currency;
  String year;

  String phone;
  String email;
  String instagram;
  String telegram;
  String tiktok;
  String facebook;

  bool phoneEnabled;
  bool emailEnabled;
  bool instagramEnabled;
  bool telegramEnabled;
  bool tiktokEnabled;
  bool facebookEnabled;

  StoreSetupData({
    this.storeName = "",
    this.description = "",
    this.storeType = "",
    this.category = "",
    this.region = "",
    this.currency = "",
    this.year = "",
    this.phone = "",
    this.email = "",
    this.instagram = "",
    this.telegram = "",
    this.tiktok = "",
    this.facebook = "",
    this.phoneEnabled = true,
    this.emailEnabled = true,
    this.instagramEnabled = true,
    this.telegramEnabled = true,
    this.tiktokEnabled = true,
    this.facebookEnabled = false,
  });
}