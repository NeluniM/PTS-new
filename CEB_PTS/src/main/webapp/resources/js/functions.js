//Function to validate a list box
function validateList(filed)
{
    var listbox = document.getElementById(filed).selectedIndex;

    if (listbox==0) 
    {
            return false;	
    }
    else
    {
            return true;
    }
}

//Function to validate empty text feild
function validateEmpty(filed)
{
    var text = document.getElementById(filed).value;

    if (text=="" || text=="." || text==" ") 
    {
            return false;	
    }
    else
    {
            return true;
    }
}

//Function to validate numaric value
function validateNumaric(field)
{
    var text = document.getElementById(field).value;

    if(isNaN(text))
    {
            return false;
    }
    else
    {
            return true;
    }
}

//Function to validate amount
function validateAmount(field)
{
    var text = document.getElementById(field).value;

    if(isNaN(text))
    {
            return false;
    }
    else
    {
            if(document.getElementById(field).value > 0)
            {
                    return true;
            }
            else
            {
                    return false;
            }
    }
}

//Function to validate check box
function validateCheckBox(field)
{
    var CheckBox = document.getElementById(field).checked;

    return CheckBox;
}

//Function to validate Email address
function validateEmail(filed) 
{
    var x = document.getElementById(filed).value;

    var atpos=x.indexOf("@");
    var dotpos=x.lastIndexOf(".");

    if (atpos<1 || dotpos<atpos+2 || dotpos+2>=x.length)
    {
            return false;
    }
    else
    {
            return true
    }
}

//Function to validate 10 digit phone number
function validatePhone(field)
{
    var x = document.getElementById(field).value;

    if(x.length==10)
    {
            return true;	
    }
    else
    {
            return false;	
    }
}

//Select list item automatically when value is passed
function selectList(field,lvalue)
{
    sel = document.getElementById(field);

    str = lvalue;

    for (i=0; i<sel.options.length; i++) 
    {
            if (sel.options[i].value == str) 
            {
                    sel.selectedIndex = i;
            }
    }
}

//Scroll window to an Element
function ScrollToElement(id)
{
    $('html, body').animate({scrollTop: $("#"+id).offset().top-150}, 1000);
}

//Show notification messages
function showNotification(message,type)
{
        var notification = new NotificationFx({
                message : message,
                layout : 'bar',
		effect : 'slidetop',
                type : type // notice, warning or error
        });

        notification.show();
}

function ConfirmAction(title,message,confirm_label,cancel_label,successfunction,successargs)
{
        bootbox.confirm({
                title: title,
                message: message,
                buttons: {
                        cancel: {
                        label: '<i class="fa fa-times"></i> ' + cancel_label
                        },
                        confirm: {
                        label: '<i class="fa fa-check"></i> ' + confirm_label
                        }
                },
                callback: function (result) 
                {
                        if(result==true)
                        {
                                successfunction.apply(this, successargs);
                        }
                        
                }
        });
}

function signOut()
{

        //Send Ajax Request
        $.ajax
        ({
            type: 'POST',
            url: 'authenticate_control.php',
            data: {action: 'signOut'},
            success: function (response)
            {
                var data = JSON.parse(response);

                location.replace("index.php");

            }
        });
    
}

