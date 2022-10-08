import 'package:final_project/character_Details/views.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


import '../models/character.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({Key? key, required this.character}) : super(key: key);


 final Character character;





@override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
        CharacterDetailsView(charID:character.id),
        ));
},
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
        
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12)
                  ),
                  child: Image.network(
                  character.image,
                    fit: BoxFit.cover,
                    width: double.infinity,

                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(character.name,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                  maxLines: 1,
                overflow: TextOverflow.ellipsis,
                ),
            )
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 0),
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2)
            ]),
      ),
    );
  }


}
