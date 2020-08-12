
class UserProfileData{

    String vehicle;
    String profileImage;
    String phoneNumber;
    int hunts;

    UserProfileData({
    this.vehicle,
    this.hunts,
    this.phoneNumber,
    this.profileImage,
    });

    UserProfileData.fromMap(Map map): this( 
      vehicle: map['vehicle'] ?? 'Car',
      profileImage: map['profileImage'] ,
      phoneNumber: map['phoneNumber'] ,
      hunts: map['hunts'] ,
      );

    Map<String, dynamic> toMap() => {
      'vehicle': vehicle ?? 'Car',
      'profileImage' : profileImage ?? '/assets/profileImages/default.png',
      'phoneNumber': phoneNumber ?? '0612345678',
      'hunts': hunts ?? 0,
    };

}