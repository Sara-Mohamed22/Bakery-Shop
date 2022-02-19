// ignore_for_file: missing_return

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:mill_10/backend/helper/firestoreHelper.dart';
import 'package:mill_10/backend/provider/eventsProvider.dart';
import 'package:mill_10/backend/provider/adminProvider.dart';
import 'package:mill_10/backend/provider/userProvider.dart';
import 'package:mill_10/model/meeting.dart';
import 'package:mill_10/model/user.dart';
import 'package:mill_10/screens/Administration/supervisr.dart';
import 'package:mill_10/screens/Administration/utils.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:string_validator/string_validator.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';


class Entertime extends StatefulWidget {
  const Entertime({Key key}) : super(key: key);
   get time => null;
 @override
  _EntertimeState createState() => _EntertimeState();
}

class _EntertimeState extends State<Entertime> {


  String note;
  DateTime from;
  DateTime to;
  DateTime selectedDate = DateTime.now();

@override
void initState(){
 super.initState();

 if(widget.time == null){
   Provider.of<EventsProvider>(context,listen:false).fromDate = DateTime.now().add( Duration(hours:6));
   Provider.of<EventsProvider>(context,listen:false).toDate =  DateTime.now().add( Duration(hours:6));
 }
}



  Future saveForm(BuildContext context) async{

    final timeKey=Provider.of<EventsProvider>(context,listen:false).timeKey;
    final provider=Provider.of<EventsProvider>(context,listen:false);
provider.dateEvent=Utils.toDate(Provider.of<EventsProvider>(context,listen:false).fromDate);
    if(timeKey.currentState.validate()){
      timeKey.currentState.save();
      final DateTime today = DateTime.now();
       final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String formatted = formatter.format(today);
      // Appointment appoint=Appointment(
      //   subject: provider.nameController.text,
      //     notes: provider.noteController.text ,
      //     isAllDay: false,
      //     startTime:provider.fromDate, endTime:provider.toDate);
      Meeting event=Meeting(
          name: provider.dropdownValue,
          note: provider.noteController.text,
          from:provider.fromDate ,
          to:provider.toDate,
          isAllDay: false,
          date:provider.dateEvent,
      );
      provider.addEvent(event,context);
    }
  }
  DateTime datedate;
@override

  @override
  Widget build(BuildContext context){
  final timeKey=Provider.of<EventsProvider>(context,listen:false).timeKey;
  final provider=Provider.of<EventsProvider>(context,listen:false);
    return Scaffold(
      backgroundColor:const Color(0xFFFFF3E0),
      appBar:AppBar(
        leading: const CloseButton(),
        actions: buildSaveActions(
          press: ()=> saveForm(context) ),
        backgroundColor: const Color(0xFF3E2723),
        elevation: 0.0,
        title: const Text('Enter time',
              style: TextStyle(
               fontSize: 19.0,
              color: Color(0xFFFFF3E0),
        ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child:Consumer<EventsProvider>(builder: (context, provider, widget) {
          return SingleChildScrollView(
                padding: const EdgeInsets.all(12),
           child: Form(key:provider.timeKey,
             child: Column(mainAxisSize: MainAxisSize.min,
              children:<Widget> [
                const  SizedBox(height: 30,),
                  inputemployee(),
              // entername(namecontroller: provider.nameController),

                const  SizedBox(height: 30,),

                 enternote(notecontroller: provider.noteController),

                const  SizedBox(height: 30,),

               buildEntertime(),

        ],
      ),));})
      ));
  }
List<Widget> buildSaveActions({Function press})=>[
  ElevatedButton.icon(
    style: ElevatedButton.styleFrom(
      primary: Colors.transparent,
      shadowColor: Colors.transparent,
    ),
    onPressed: press,
    icon:const Icon(Icons.done),
    label:const Text("Save"),
  )

];

 Widget  inputemployee() =>Row(
       children: [
    const Text(" Employee Name is : ",
             style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Color(0xFF3E2723) ),
              ),

  StreamBuilder(
             stream: FirebaseFirestore.instance.collection('users').where("type", isEqualTo: "employee").snapshots(),
             builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

     if (!snapshot.hasData) {
           return Center(child: CircularProgressIndicator(),);
      }else{
      return Flexible(
       child:Container(padding:const  EdgeInsets.symmetric(horizontal: 7,vertical: 7),
        child: DropdownButtonHideUnderline(
           child:  DropdownButton<String>(
                isExpanded: true,
               hint: Text('select name'),
              underline: Container(),
                items: snapshot.data.docs.map((document) {
                 UserModel model =UserModel.toMap(document);
                 print("employe: ${model.name}");
                   return DropdownMenuItem<String>(
                    child: Text(model.name),
                    value:model.name,
                );
                }).toList(),
                        value:Provider.of<EventsProvider>(context,listen: false).dropdownValue,
                        icon: const Icon(Icons.arrow_drop_down,color:Color(0xFF3E2723)),
                            iconSize: 36, style: const TextStyle(color: Color(0xFF3E2723)),
                       onChanged: ( String e){
                         setState(() {
                           Provider.of<EventsProvider>(context,listen: false).dropdownValue= e;
                         });
                         print(e);

                      },),
        ),
      ));
                      }},)]);




  Widget  enternote({TextEditingController notecontroller}) =>


   TextFormField(controller: notecontroller,
     style: const TextStyle(fontSize: 16), decoration:const InputDecoration(
       border: UnderlineInputBorder(),
       hintText: "Add Note",
      ),
  onFieldSubmitted:(_) =>saveForm(context),

    );



  Widget  entername({TextEditingController namecontroller}) =>
    TextFormField(controller: namecontroller,
          style: const TextStyle(fontSize: 16), decoration:const InputDecoration(
            border: UnderlineInputBorder(),
           hintText:"Enter Employee Name"
  ),
          onFieldSubmitted:(_) =>saveForm(context),

  );








  Widget  buildEntertime() => Column(
      children: [
     buildfrom(),
     buildTo(),

 ],
);

  Widget  buildfrom() =>buildHeader(
    header:"From",
    child: Row(
      children: [
        Expanded(
          flex:2,
          child: builDropdownField(
            text: Utils.toDate(Provider.of<EventsProvider>(context,listen:false).fromDate),
            onclicked: (){
              pickFromDateTime(pickDate:true);
            }
          ),
        ),
        Expanded(
          child: builDropdownField(
            text: Utils.toTime(Provider.of<EventsProvider>(context,listen:false).fromDate),
            onclicked: ()=>pickFromDateTime(pickDate:false),
          ),
        )
      ],
    ),
  );
  Widget  buildTo() =>buildHeader(
    header:"To",
    child: Row(
      children: [
        Expanded(
          flex:2,
          child: builDropdownField(
            text: Utils.toDate(Provider.of<EventsProvider>(context,listen:false).toDate),
            onclicked: ()=>pickToDateTime(pickDate:true),
                // selectDate(context),

          ),
        ),
        Expanded(
          child: builDropdownField(
            text: Utils.toTime(Provider.of<EventsProvider>(context,listen:false).toDate),
            onclicked: ()=>pickToDateTime(pickDate:false),
          ),
        )
      ],
    ),
  );

  Widget  builDropdownField({
    text,
    onclicked,
  }) => ListTile(
    title: Text(text,style:TextStyle(fontSize: 10),),
    trailing:const Icon(Icons.arrow_drop_down),
    onTap: onclicked,
  );


  Widget buildHeader({
    header,
    child,
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(header,style:const TextStyle(fontWeight: FontWeight.bold),),
      child,
    ],
  );


  Future pickFromDateTime({pickDate}) async{
    final date = await pickDateTime(
      Provider.of<EventsProvider>(context,listen:false).fromDate,
      pickDate:pickDate,
    );
    if(date==null) return;

    if(date.isAfter(Provider.of<EventsProvider>(context,listen:false).toDate)){
      Provider.of<EventsProvider>(context,listen:false).toDate=
          DateTime(date.year, date.month, date.day, Provider.of<EventsProvider>(context,listen:false).toDate.hour, Provider.of<EventsProvider>(context,listen:false).toDate.minute);
    }
    setState(() =>Provider.of<EventsProvider>(context,listen:false).fromDate=date );
  }


  Future pickToDateTime({ pickDate}) async{
    final date = await pickDateTime(
      Provider.of<EventsProvider>(context,listen:false).toDate,
      pickDate:pickDate,
      firstDate: pickDate ? Provider.of<EventsProvider>(context,listen:false).fromDate : null,
    );
    if(date==null) return;

    if(date.isAfter(Provider.of<EventsProvider>(context,listen:false).toDate)){
      Provider.of<EventsProvider>(context,listen:false).toDate=DateTime(date.year, date.month, date.day, Provider.of<EventsProvider>(context,listen:false).toDate.hour, Provider.of<EventsProvider>(context,listen:false).toDate.minute);
     to=DateTime(date.year, date.month, date.day);
    }
    setState(() =>Provider.of<EventsProvider>(context,listen:false).toDate=date );
  }





  selectDate(BuildContext context) async {
  final DateTime selected = await showDatePicker(
  context: context,
  initialDate: selectedDate,
  firstDate: DateTime(2010),
  lastDate: DateTime(2025),
    );
  if (selected != null && selected != selectedDate)
  setState(() {
  selectedDate = selected;
  });
}




  Future<DateTime> pickDateTime(DateTime initialDate,{pickDate, firstDate,})async{

    if(pickDate){
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate = DateTime(2021,8),
        lastDate: DateTime(2101),);

      if(date == null) return null;

      final time =
      Duration(hours: initialDate.hour, minutes:initialDate.minute, );
      return date.add(time);
    }else{
      final timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );
      if(timeOfDay == null) return null;
       datedate = DateTime(initialDate.year, initialDate.month, initialDate.day,);
      final time= Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute );
      return datedate.add(time);
    }
  }





}


