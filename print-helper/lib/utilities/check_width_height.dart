import 'package:flutter_web_signin/utilities/constants.dart';

bool checkWidth(String val){
  if(!val.isEmpty){
  if(val.length > 0 && val != null){
    int width = int.parse(val);
    if(width > 5 && width < A1_WIDTH){
      return true;
    }
  }
  }
  return false;
} 


bool checkHeight(String val){
  if(!val.isEmpty){
    if(val.length > 0 && val != null){
      int height = int.parse(val);

        if(height > 5 && height < A1_HEIGHT){
          return true;
      }
    }
  }

  return false;
} 


bool checkIndent(String val){
  if(!val.isEmpty){
  if(val != null){
    int indent = int.parse(val);
    if(indent > 50){
      return false;
    }
  }
  }
  return true;
} 

bool checkPrinting(String val){
  if(!val.isEmpty){
  if(val != null){
    int printing = int.parse(val);
    if(printing > 0){
      return false;
    }
  }
  }
  return true;
}