import 'dart:io';
import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'file_upload_service.dart';

class ConvertFileService {
  Future<void> convertFile() async {
    var firestore = FirebaseFirestore.instance;
    final file = await FileUploadService.getFile();
    if (file == null) {
      return;
    }
    final input = file.openRead();

    final List<List<dynamic>> fields = await input
        .transform(utf8.decoder)
        .transform(const CsvToListConverter(eol: '\n'))
        .toList();

    var groupedTransactionsNum = {}; // number of transaction type (5)
    var groupedTransactionsTotal = {}; // total expenditure of type ($100)

    var startMonth = 12;
    var endMonth = 0;
    final User? user = FirebaseAuth.instance.currentUser;
    for (int i = 1; i < fields.length; i++) {
      var amount = fields[i][5];
      var category = fields[i][3];
      DateFormat dateFormat = DateFormat("MM/dd/yyyy");
      var date =
          dateFormat.parse(fields[i][0]); // convert string to DateTime object
      var desc = fields[i][2];
      var type = fields[i][4];

      // check if a document with similar fields already exists
      if (fields[i][3] != "") {
        var snapshot = await firestore
            .collection('transactions')
            .where('amount', isEqualTo: amount)
            .where('category', isEqualTo: category)
            .where('date', isEqualTo: date)
            .where('desc', isEqualTo: desc)
            .where('type', isEqualTo: type)
            .get();

        if (snapshot.docs.isEmpty) {
          // add the document
          firestore.collection('transactions').add({
            'amount': amount,
            'category': category,
            'date': date,
            'desc': desc,
            'type': type
          });
          var userDoc = firestore.collection('Users').doc(user?.email);
          var cataTransactions = (await userDoc.get())['CateTransactions'];
          if (cataTransactions.containsKey(category)) {
            cataTransactions[category] += amount;
          } else {
            cataTransactions[category] = amount;
          }
          await userDoc.update({'CateTransactions': cataTransactions});
        }
        if (groupedTransactionsNum[fields[i][3]] == null) {
          groupedTransactionsNum[fields[i][3]] = 1;
          groupedTransactionsTotal[fields[i][3]] = 0 - fields[i][5];
        } else {
          groupedTransactionsNum[fields[i][3]] += 1;
          groupedTransactionsTotal[fields[i][3]] =
              groupedTransactionsTotal[fields[i][3]] - fields[i][5];
        }
      }

      var currMonth = int.parse(fields[i][0].split("/")[0]);
      if (currMonth < startMonth) {
        startMonth = currMonth;
      } else if (currMonth > endMonth) {
        endMonth = currMonth;
      }
    }

    var timeSpan = endMonth - startMonth;
    print("Terminated end");
  }
}
