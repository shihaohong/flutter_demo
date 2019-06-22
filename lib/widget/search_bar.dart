import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//实现PreferredSizeWidget，否则不能作为appBar控件引用

class SearchAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final double height;
  final double elevation; //阴影
  final Widget leading;
  final String hintText;
  final IconData prefixIcon;
  final VoidCallback onEditingComplete;
  final bool normalSearch;
  final void Function() inputBoxClick;  
 

  const SearchAppBarWidget(
      {this.height: 76.0,
      this.elevation: 0.5,
      this.leading,
      this.hintText: '搜索',
      this.onEditingComplete,
      this.normalSearch = true,
      this.prefixIcon=Icons.search,
      this.inputBoxClick});
  
  _SearchAppBarState createState() =>  _SearchAppBarState();
  
  @override
  Size get preferredSize => Size.fromHeight(height);//这里设置控件（appBar）的高度
}


class _SearchAppBarState extends State<SearchAppBarWidget> {
  bool _hasdeleteIcon = false;
  final TextEditingController _controller = TextEditingController();
  final int themeColor = 0xFFC91B3A;
  final double inputBoxHeight = 34;
  final double fontSize = 16;
  final Color fontColor = Colors.grey;
 
  @override
  Widget build(BuildContext context) {
     
    return !widget.normalSearch ? _inputBox : _normalInputBox;
    
  }

  
  Widget get _inputBox {

    return PreferredSize(
          child: Stack(
            children: <Widget>[
              Container(
                height: widget.height,
                decoration: BoxDecoration(
                  color: Color(themeColor),
                ),
              ),
              Row(
                children: <Widget>[
                  _backIcon,
                  Expanded(
                    flex: 1,
                    child: _inputBlock,
                  ),
                  _searchBtn
                ],
              )
            ],
          ),
         
          preferredSize: Size.fromHeight(widget.height));
  }
  
  Widget get _normalInputBox {

    return PreferredSize(
     
     child: Stack(
       children: <Widget>[
         Container(
           height: widget.height,
           decoration: BoxDecoration(
             color: Color(themeColor),
           ),
         ),         
         GestureDetector(
           onTap: (){
              if(widget.inputBoxClick !=null) 
                  widget.inputBoxClick();
              
           },
           child: Container(
             height: inputBoxHeight,
             margin: EdgeInsetsDirectional.only(start: 16.0,end: 16.0,top: 33.0),
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.circular(4)
               
             ),
             child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsetsDirectional.only(start:5,top:2,end: 5),
                    child: Icon(
                        Icons.search,
                        size: 24,
                        color: fontColor,
                    ),
                  ),
                  Text(
                    widget.hintText,style: TextStyle(color: fontColor,fontSize: fontSize),                 
                  )
                ],
           ),
          )
         )
       ],
     ),
     preferredSize: Size.fromHeight(widget.height),
   );

  }

  Widget get _input {
    
    return TextField(
      autofocus: true,
      controller: _controller,
      maxLines: 1,
      
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: fontColor,
          fontSize: fontSize,
          
        ),
         
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      filled: true,
      fillColor: Colors.transparent,
      border: InputBorder.none,
      ),
      
      onChanged: (str) {
        setState(() {
          if (str.isEmpty) {
            _hasdeleteIcon = false;
          } else {
            _hasdeleteIcon = true;
          }
        });
      },
      onEditingComplete: widget.onEditingComplete);
      
  }

  Widget get _inputBlock {

    return Container(
      height: inputBoxHeight,
      margin: EdgeInsetsDirectional.only(end: 10.0,top: 33.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4)
      ),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsetsDirectional.only(start:5,top:2,end: 5),
            child: Icon(
                Icons.search,
                size: 24,
                color: fontColor,
            ),
          ),
          Expanded(
            flex: 1,
            child: _input,
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(start:5,top:2,end: 5),
            child: _hasdeleteIcon ? _deleteIcon : Text('')
          ),
        ],
      ),
    );
  } 

  Widget get _searchBtn {

    return  Container(
      height: 26,
      width: 66,
      margin: EdgeInsetsDirectional.only(top: 30.0,end: 8),
      child: FlatButton(
   
        onPressed: (){

        },
        child: Text("搜索"),
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
        ),
      ),
    );
  }
  
  Widget get _deleteIcon {
    
    return new GestureDetector(
      onTap: (() {
        setState(() {
          _controller.text = '';
          _hasdeleteIcon = false;
        });
      }),
      child: Icon(
        Icons.clear,
        size: 18.0,
        color: Colors.black,
      ));
                     
  } 
 
  Widget get _backIcon {

    return Container(
      height: inputBoxHeight,
      margin: EdgeInsetsDirectional.only(top: 30.0),
      child: IconButton(
        icon: Icon(Icons.arrow_back,size: 24, color: Colors.white),
        highlightColor: Colors.black,
        onPressed: () {
            Navigator.pop(context);
        }),
    );
  }



}

 
