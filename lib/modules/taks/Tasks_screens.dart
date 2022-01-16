import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';

import 'package:todoapp/shared/components/components.dart';
import 'package:todoapp/shared/components/constants.dart';
import 'package:todoapp/shared/cubit.dart';
import 'package:todoapp/shared/stated.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
 return BlocConsumer<AppCubit , AppStates>(
   listener: (context , state){},
   builder: (context , state){
     var tasks = AppCubit.get(context).newTasks;
     return taskBuilder(tasks: tasks);
   },
 );
  }
}