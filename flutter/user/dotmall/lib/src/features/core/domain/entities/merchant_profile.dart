// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// import 'package:flutter/foundation.dart';

// import 'account.dart';
// import 'address.dart';
// import 'email.dart';
// import 'phone.dart';

// class MerchantProfile {
//   final String id;
//   final Address? address;
//   final List<Phone>? phones;
//   final List<Email>? emails;
//   final String accountId;
//   final Account account;
//   MerchantProfile({
//     required this.id,
//     this.address,
//     this.phones,
//     this.emails,
//     required this.accountId,
//     required this.account,
//   });
//   MerchantProfile copyWith({
//     String? id,
//     Address? address,
//     List<Phone>? phones,
//     List<Email>? emails,
//     String? accountId,
//     Account? account,
//   }) {
//     return MerchantProfile(
//       id: id ?? this.id,
//       address: address ?? this.address,
//       phones: phones ?? this.phones,
//       emails: emails ?? this.emails,
//       accountId: accountId ?? this.accountId,
//       account: account ?? this.account,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'address': address?.toMap(),
//       'phones': phones?.map((x) => x?.toMap()).toList(),
//       'emails': emails?.map((x) => x?.toMap()).toList(),
//       'accountId': accountId,
//       'account': account.toMap(),
//     };
//   }

//   factory MerchantProfile.fromMap(Map<String, dynamic> map) {
//     return MerchantProfile(
//       id: map['id'] as String,
//       address: map['address'] != null ? Address.fromMap(map['address'] as Map<String,dynamic>) : null,
//       phones: map['phones'] != null ? List<Phone>.from((map['phones'] as List<int>).map<Phone?>((x) => Phone.fromMap(x as Map<String,dynamic>),),) : null,
//       emails: map['emails'] != null ? List<Email>.from((map['emails'] as List<int>).map<Email?>((x) => Email.fromMap(x as Map<String,dynamic>),),) : null,
//       accountId: map['accountId'] as String,
//       account: Account.fromMap(map['account'] as Map<String,dynamic>),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory MerchantProfile.fromJson(String source) => MerchantProfile.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() {
//     return 'MerchantProfile(id: $id, address: $address, phones: $phones, emails: $emails, accountId: $accountId, account: $account)';
//   }

//   @override
//   bool operator ==(covariant MerchantProfile other) {
//     if (identical(this, other)) return true;
  
//     return 
//       other.id == id &&
//       other.address == address &&
//       listEquals(other.phones, phones) &&
//       listEquals(other.emails, emails) &&
//       other.accountId == accountId &&
//       other.account == account;
//   }

//   @override
//   int get hashCode {
//     return id.hashCode ^
//       address.hashCode ^
//       phones.hashCode ^
//       emails.hashCode ^
//       accountId.hashCode ^
//       account.hashCode;
//   }
// }
