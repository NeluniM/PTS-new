/**
 * 
 */

function checkEligibility() {
     var epfNumber = document.getElementById("epfNumber").value;

     var epfNumberReturn = '';
     var username = epfNumber;
     var password = 'test123';
     var hash = '...';
     var actualUrl = "/CBRS/validateADLoginPensioners?username=" + username + "&password=" + password;
     $.ajax({

         type: 'GET',
         url: actualUrl,
         data: {},
         contentType: "application/json; charset=utf-8",
         success: function (response) {
             //alert(response.Userno);
             if (response.Userno != null) {
                 //if(response.Userno !=null){
                 epfNumberReturn = response.Userno.trim();
                 if (epfNumber === epfNumberReturn) {
                     document.getElementById("vip").value = response.Vip;
                     document.getElementById("epf").value = epfNumberReturn;
                     document.getElementById("telephoneNumber").value = response.TelephoneNo;
                     document.getElementById("empName").value = response.Name;
                     document.getElementById("emailEmp").value = response.Email;

                     document.getElementById('epf_error').style.display = 'none';
                     showCongratulationsPopup();
                 } else {
                     document.getElementById('epf_error').style.display = 'none';
                     showSorryPopup();
                 }


             } else {
                 var epfStr = epfNumber.toString();
                 if (epfStr.length !== 6) {
                     document.getElementById('epf_error').style.display = 'block';
                 } else {
                     document.getElementById('epf_error').style.display = 'none';
                     showSorryPopup();
                 }
             }

         }
     });


 }
