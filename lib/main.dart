import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

import './widget/new_transaction.dart';
import './widget/transaction_list.dart';
import './model/transaction.dart';
import 'widget/chart.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Exapanses',
      theme: ThemeData(
        primaryColor: Colors.purple,
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Courgette',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'Courgette',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
        buttonTheme: ThemeData.light().buttonTheme.copyWith(
              disabledColor: Colors.purple,
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Lobster',
                  fontWeight: FontWeight.bold,
                  // color: Colors.red,
                  // color: Colors.black87,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];
  bool _showChart = false;

  void _addNewTransaction(String title, double amount, DateTime date) {
    final tx = Transaction(
      amount: amount,
      date: date,
      title: title,
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransactions.add(tx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,

      context: ctx,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
      elevation: 7,
      isDismissible: true,

      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.vertical(
      //     top: Radius.circular(
      //       30,
      //     ),
      //   ),
      // ),
    );
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  List<Widget> _buildLandScapeContent(
    MediaQueryData mediaQuery,
    AppBar appBar,
    Widget txList,
  ) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Show Chart',
            style: TextStyle(
              fontFamily: 'Courgette',
            ),
          ),
          Switch.adaptive(
            value: _showChart,
            onChanged: (val) => setState(() {
              _showChart = val;
            }),
          )
        ],
      ),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  .7,
              child: Chart(_recentTransactions),
            )
          : txList,
    ];
  }

  List<Widget> _buildPotraitContent(
    MediaQueryData mediaQuery,
    AppBar appBar,
    Widget txList,
  ) {
    return [
       Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    .3,
                child: Chart(_recentTransactions),
              ),
               txList
    ];
  }

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final _isLandScape = (mediaQuery.orientation == Orientation.landscape);

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text(
              'Exapanse Manager',
            ),
            trailing: Row(
              children: [
                GestureDetector(
                  onTap: () => _startAddNewTransaction,
                  child: const Icon(Icons.add),
                )
              ],
            ),
          )
        : AppBar(
            title: const Text(
              'Expanse Manager',
              // style: Theme.of(context).appBarTheme.titleTextStyle,
              // style: TextStyle(
              //   fontFamily: 'Lobster',
              //   fontSize: 30,
              // ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () => _startAddNewTransaction(context),
              )
            ],
          );

    final txList = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          .7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // It is LandScape content
            if (_isLandScape)
              ..._buildLandScapeContent(mediaQuery, appBar, txList),

            if (!_isLandScape)
            ..._buildPotraitContent(mediaQuery, appBar, txList),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: pageBody,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              child: const Icon(
                Icons.add,
              ),
              onPressed: () => _startAddNewTransaction(context),

              // backgroundColor: ,
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
