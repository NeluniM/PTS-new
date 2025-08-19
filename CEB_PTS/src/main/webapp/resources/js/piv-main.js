function numericValidate(obj,event)
{
	var key = event.keyCode;
	
	if((key>=48 && key<=57)|| key==190)	{}
	else
	{
		var val = obj.value.toUpperCase();
		var keyVal = String.fromCharCode ( event.keyCode )
		var index = val.indexOf(keyVal);
		if(index!=-1)
		{
			obj.value = val.substring(0,index)+val.substring(index+1);
		}
	}

}

//Allow only Numbers (0-9) and retrict to two decimal position
function restrictToTwoDecimalPossition(obj,event){
    event = event || window.event;
    if (event.which!="undefined"){
        if (event.which!=0){
            var key = event.keyCode || event.which;
            if( (key != 46) && (key < 48 || key > 57)){
                return false;
            }
            if(obj.value.indexOf('.')!=(-1) && key==46){
                return false;
            }
            if(key!=46){
                if(obj.value.indexOf('.')!=(-1)){
                    if(obj.value.substr(obj.value.indexOf('.')).length>2)// number
																			// of
																			// decimal
																			// places
                    {
                        return false;
                    }
                }else {
                    if(obj.value.length>10){
                        return false;
                    }
                }
            }
            if(obj.value.indexOf('.')!=(-1)){
                if(obj.value.substr(obj.value.indexOf('.')).length>2){
                    return false;
                }
            }
            return true;
        }// equal to zero
        return true;
    }// equal to undefind
    return true;
}