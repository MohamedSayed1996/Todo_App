import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/shared/cubit.dart';



Widget buildScreens(Map model , context) => Dismissible(
  key: Key(model['id'].toString()),
  onDismissed: (direction){
    AppCubit.get(context).deleteData(id: model['id']);
  },
  child:   Padding(
  
        padding: const EdgeInsets.all(20.0),
  
        child: Row(
  
          children: [
  
            CircleAvatar(
  
              radius: 40.0,
  
              child: Text(
  
                '${model ['time']}',
  
              ),
  
            ),
  
            SizedBox(
  
              width: 20,
  
            ),
  
            Expanded(
  
              child: Column(
  
                crossAxisAlignment: CrossAxisAlignment.start,
  
                mainAxisSize: MainAxisSize.min,
  
                children: [
  
                  Text(' ${model ['title']}',
  
                  style: TextStyle(
  
                    fontSize: 16.0,
  
                    fontWeight: FontWeight.bold,
  
                  ),
  
                  ),
  
                  Text(' ${model ['date']}',
  
                  style: TextStyle(
  
                    fontSize: 16.0,
  
                    color: Colors.grey,
  
                  ),
  
                  ),
  
                ],
  
              ),
  
            ),
  
            SizedBox(
  
              width: 20,
  
            ),
  
            IconButton(
  
              color: Colors.green,
  
              onPressed: (){
  
                AppCubit.get(context).updateData(status: 'done', id: model['id'],);
  
              },
  
              icon: Icon(
  
                Icons.check_box
  
              ),
  
              ),
  
            IconButton(
  
              onPressed: (){
  
                AppCubit.get(context).updateData(status: 'archive', id: model['id'],);
  
              },
  
              icon: Icon(
  
                Icons.archive,
  
              ),
  
              ),
  
          ],
  
          
  
        ),
  
      ),
);



Widget defaultTextFormField({
  @required TextEditingController conterller,
  @required TextInputType type,
  @required String LabelText,
  @required IconData prefix,
  @required Function validate,
  IconData suffix,
  Function onTap,
  bool obsecure = false,
  Function suffixpressed,

  }
  )=> TextFormField(
                    onTap: onTap,
                    controller: conterller,
                    obscureText: obsecure,
                    keyboardType: type,
                    decoration: InputDecoration(
                      labelText: LabelText,
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        prefix,
                      ),
                      suffixIcon: IconButton( 
                      icon: Icon(
                        suffix,
                      ),
                      onPressed: suffixpressed,
                      ),
                    ),
                    validator: validate
                  );







Widget taskBuilder({
@required List<Map> tasks,
}) => ConditionalBuilder(
       condition: tasks.length > 0,
       builder: (context)=> ListView.separated(
            itemBuilder: (context, index) => buildScreens(tasks[index] ,  context),
            separatorBuilder: (context, index) => Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey,
                ),
            itemCount: tasks.length),



    fallback: (context)=> Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.menu,
            size: 75.0,
          ),
          Text('No Task Yet, Please add some tasks',
          style: TextStyle(fontSize: 16.0,
          fontWeight: FontWeight.bold)
          )
        ],
      ),
    ),

     );




