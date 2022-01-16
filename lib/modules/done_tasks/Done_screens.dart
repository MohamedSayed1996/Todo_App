import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/shared/components/components.dart';
import 'package:todoapp/shared/cubit.dart';
import 'package:todoapp/shared/stated.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoneTasksScreem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates>(
   listener: (context , state){},
   builder: (context , state){
     var tasks = AppCubit.get(context).doneTasks;
     return taskBuilder(tasks: tasks);
   },
 );
  }
}