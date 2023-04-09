import 'package:cloud_firestore/cloud_firestore.dart';

class DataDownload {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getCata(String email) async {
    final DocumentSnapshot<Map<String, dynamic>> userDoc =
        await _firestore.collection('Users').doc(email).get();
    final Map<String, dynamic> cataTransactions =
        userDoc.get('CataTransactions') as Map<String, dynamic>;
    return cataTransactions;
  }

  Future<List<dynamic>> getInstances(String searchText) async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
        .collection('Users')
        .where('transactions.desc', arrayContains: searchText)
        .get();
    final List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
        querySnapshot.docs;
    final int numInstances = docs.length;
    final num sumAmounts = docs.fold(0,
        (previousValue, doc) => previousValue + doc.get('transactions.amount'));
    return [numInstances, sumAmounts];
  }

  Future<String> getMostFrequent(String email) async {
    final DocumentSnapshot<Map<String, dynamic>> userDoc =
        await _firestore.collection('Users').doc(email).get();
    final List<dynamic> transactions =
        userDoc.get('transactions') as List<dynamic>;
    final Map<String, int> matches = {};
    for (final transaction in transactions) {
      final String name = transaction['name'] as String;
      final String firstChar = name.split(' ')[0];
      if (matches.containsKey(firstChar)) {
        matches[firstChar] = matches[firstChar]! + 1;
      } else {
        matches[firstChar] = 1;
      }
    }
    final List<String> keys = matches.keys.toList();
    keys.sort((a, b) => matches[b]!.compareTo(matches[a]!));
    return keys.isNotEmpty ? keys.first : '';
  }
}
