import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/shared/stated.dart';
import 'package:todoapp/modules/archive_tasks/Archive_screen.dart';
import 'package:todoapp/modules/done_tasks/Done_screens.dart';
import 'package:todoapp/modules/taks/Tasks_screens.dart';
import 'package:todoapp/shared/stated.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currenIndex = 0;
  List<Widget> screens = [
    TasksScreen(),
    DoneTasksScreem(),
    ArchiveTasksScreen(),
  ];

  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeIndex(int index) {
    currenIndex = index;
    emit(AppChangeBorromNavbarStat());
  }

  Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];

  void createDatabase() {
    openDatabase('todo.db', version: 1, onCreate: (database, version) {
      print('database created');
      database
          .execute(
              'CREATE TABLE test (id INTEGER PRIMARY KEY, title TEXT, date Text, time TEXT, statue Text)')
          .then((value) {
        print('Table created');
      }).catchError((error) {
        print('Error is when table created ${error.toString()}');
      });
    }, onOpen: (database) {
      getFromDatabase(database);
      print('database opened');
    }).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertDatabase({
    @required String title,
    @required String time,
    @required String date,
  }) async {
    await database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO test (title, date, time, statue) VALUES("$title", "$date", "$time", "new")')
          .then((value) {
        print('$value inserted successfully');
        emit(AppInsertDatabaseState());

        getFromDatabase(database);
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });
      return null;
    });
  }

  void getFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archiveTasks = [];
    emit(AppGetDatabaseLoadingScreenStat());
    database.rawQuery('SELECT * FROM test').then((value) {
      value.forEach((element) {
        if (element['statue'] == 'new')
          newTasks.add(element);
        else if (element['statue'] == 'done')
          doneTasks.add(element);
        else
          archiveTasks.add(element);
      });
      emit(AppGetDatabaseState());
    });
  }

  void updateData({
    @required String status,
    @required int id,
  }) async {
    database.rawUpdate(
      'UPDATE Test SET statue = ? WHERE id = ?',
      ['$status', '$id'],
    ).then((value) {
      getFromDatabase(database);
      emit(AppUpateDatabaseStat());
    });
  }

  void deleteData({@required int id}) async {
    database.rawDelete('DELETE FROM Test WHERE id = ?', ['$id']).then((value) {
      getFromDatabase(database);
      emit(AppDeleteDatabaseStat());
    });
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void ChagebottomSheetState(
    @required bool isShow,
    @required IconData icon,
  ) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetStat());
  }
}
