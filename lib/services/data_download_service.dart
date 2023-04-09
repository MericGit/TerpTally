import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class DataDownload {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  Future<Map<String, dynamic>> getCate() async {
    final DocumentSnapshot<Map<String, dynamic>> userDoc =
        await _firestore.collection('Users').doc(user?.email).get();
    final Map<String, dynamic> cateTransactions =
        userDoc.get('CateTransactions') as Map<String, dynamic>;
    return cateTransactions;
  }

  Future<List<num>> getInstances(String searchText) async {
    final User? user = FirebaseAuth.instance.currentUser;
    var userDoc = await _firestore.collection('Users').doc(user?.email).get();

    // Get array of transaction document references from user document
    List<DocumentReference> transactionRefs =
        List<DocumentReference>.from(userDoc['IndvTransactions']);

    // Initialize counter to track number of matching transactions and sum of amounts
    int increment = 0;
    int amountSum = 0;

    // Chunk transactionRefs into smaller lists with maximum length of 10
    List<List<DocumentReference>> chunks = [];
    for (var i = 0; i < transactionRefs.length; i += 10) {
      chunks.add(transactionRefs.sublist(i,
          i + 10 < transactionRefs.length ? i + 10 : transactionRefs.length));
    }

    // Query transactions collection for documents with matching search text and
    // referenced by user document, for each chunk of transactionRefs
    for (var chunk in chunks) {
      QuerySnapshot transactionsSnapshot = await _firestore
          .collection('transactions')
          .where(FieldPath.documentId, whereIn: chunk)
          .get();

      // Loop through matching documents and increment counter and sum of amounts for each
      for (var transactionDoc in transactionsSnapshot.docs) {
        if (transactionDoc['desc'].contains(searchText)) {
          increment++;
          num amount = transactionDoc['amount'];
          amountSum += amount.toInt();
        }
      }
    }
    print(increment);
    print(amountSum);
    return [increment, amountSum];
  }

  Future<String> getFreq(String searchText) async {
    final User? user = FirebaseAuth.instance.currentUser;
    var userDoc = await _firestore.collection('Users').doc(user?.email).get();

    // Get array of transaction document references from user document
    List<DocumentReference> transactionRefs =
        List<DocumentReference>.from(userDoc['IndvTransactions']);

    // Initialize counter to track number of matching transactions and sum of amounts
    int increment = 0;
    int amountSum = 0;

    // Chunk transactionRefs into smaller lists with maximum length of 10
    List<List<DocumentReference>> chunks = [];
    for (var i = 0; i < transactionRefs.length; i += 10) {
      chunks.add(transactionRefs.sublist(i,
          i + 10 < transactionRefs.length ? i + 10 : transactionRefs.length));
    }

    // Query transactions collection for documents with matching search text and
    // referenced by user document, for each chunk of transactionRefs
    for (var chunk in chunks) {
      QuerySnapshot transactionsSnapshot = await _firestore
          .collection('transactions')
          .where(FieldPath.documentId, whereIn: chunk)
          .get();

      // Loop through matching documents and increment counter and sum of amounts for each
      for (var transactionDoc in transactionsSnapshot.docs) {
        if (transactionDoc['desc'].contains(searchText)) {
          increment++;
          num amount = transactionDoc['amount'];
          amountSum += amount.toInt();
        }
      }
    }
    print(increment);
    print(amountSum);
    return increment.toString();
  }

    Future<String> getSum(String searchText) async {
    final User? user = FirebaseAuth.instance.currentUser;
    var userDoc = await _firestore.collection('Users').doc(user?.email).get();

    // Get array of transaction document references from user document
    List<DocumentReference> transactionRefs =
        List<DocumentReference>.from(userDoc['IndvTransactions']);

    // Initialize counter to track number of matching transactions and sum of amounts
    int increment = 0;
    int amountSum = 0;

    // Chunk transactionRefs into smaller lists with maximum length of 10
    List<List<DocumentReference>> chunks = [];
    for (var i = 0; i < transactionRefs.length; i += 10) {
      chunks.add(transactionRefs.sublist(i,
          i + 10 < transactionRefs.length ? i + 10 : transactionRefs.length));
    }

    // Query transactions collection for documents with matching search text and
    // referenced by user document, for each chunk of transactionRefs
    for (var chunk in chunks) {
      QuerySnapshot transactionsSnapshot = await _firestore
          .collection('transactions')
          .where(FieldPath.documentId, whereIn: chunk)
          .get();

      // Loop through matching documents and increment counter and sum of amounts for each
      for (var transactionDoc in transactionsSnapshot.docs) {
        if (transactionDoc['desc'].contains(searchText)) {
          increment++;
          num amount = transactionDoc['amount'];
          amountSum += amount.toInt();
        }
      }
    }
    return amountSum.toString();
  }

  Future<List<num>> getInstances2(String searchText) async {
    final User? user = FirebaseAuth.instance.currentUser;
    var userDoc = await _firestore.collection('Users').doc(user?.email).get();

    // Get array of transaction document references from user document
    List<DocumentReference> transactionRefs =
        List<DocumentReference>.from(userDoc['IndvTransactions']);

    // Initialize counter to track number of matching transactions and sum of amounts
    int increment = 0;
    int amountSum = 0;

    // Chunk transactionRefs into smaller lists with maximum length of 10
    List<List<DocumentReference>> chunks = [];
    for (var i = 0; i < transactionRefs.length; i += 10) {
      chunks.add(transactionRefs.sublist(i,
          i + 10 < transactionRefs.length ? i + 10 : transactionRefs.length));
    }

    // Query transactions collection for documents with matching search text and
    // referenced by user document, for each chunk of transactionRefs
    List<num> transactions = [];

    for (var chunk in chunks) {
      QuerySnapshot transactionsSnapshot = await _firestore
          .collection('transactions')
          .where(FieldPath.documentId, whereIn: chunk)
          .get();

      // Loop through matching documents and increment counter and sum of amounts for each
      for (var transactionDoc in transactionsSnapshot.docs) {
        if (transactionDoc['desc'].contains(searchText)) {
          increment++;
          DateFormat dateFormat = DateFormat("MM/dd/yyyy");
          var date = dateFormat.parse(transactionDoc['date']);
          num amount = transactionDoc['amount'];
          print(date);
        }
      }
    }
    print(increment);
    // print(amount);
    return [increment];
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
