
// Used for aadhar and pan file submissions 
function enable() {
	var check1 = document.getElementById("check1");
	var aadhar = document.getElementById("aadhar");

	if (check1.checked) {
		aadhar.removeAttribute("disabled");

	} else {
		aadhar.disabled = "true";
	}
}

function enable2() {
	var check2 = document.getElementById("check2");
	var pan = document.getElementById("pan");

	if (check2.checked) {
		pan.removeAttribute("disabled");
	} else {
		pan.disabled = "true";
	}
}

function enable3() {
	var check3 = document.getElementById("check3");
	var GST = document.getElementById("pan2");

	if (check3.checked) {
		GST.removeAttribute("disabled");

	} else {
		GST.disabled = "true";

	}
}


function onlyNumberKey(evt) {

	// Only ASCII character in that range allowed
	var ASCIICode = (evt.which) ? evt.which : evt.keyCode
	if (ASCIICode > 31 && (ASCIICode < 48 || ASCIICode > 57))	
		return false;
	return true;
}



//date
$(function(){
    var dtToday = new Date();

    var month = dtToday.getMonth() + 1;
    var day = dtToday.getDate();
    var year = dtToday.getFullYear();

    if(month < 10)
        month = '0' + month.toString();
    if(day < 10)
        day = '0' + day.toString();

    var maxDate = year + '-' + month + '-' + day;    
    $('#txtDate').attr('max', maxDate);
});

//file validations
function fileValidation_1() {
    var fileInput =
        document.getElementById('aadhar');
     
    var filePath = fileInput.value;
 
    // Allowing file type
    var allowedExtensions =
            /(\.jpg|\.jpeg|\.png|\.gif)$/i;
     
    if (!allowedExtensions.exec(filePath)) {
        alert('Invalid file type');
        fileInput.value = '';
        return false;
    }
    else
    {
     
        // Image preview
        if (fileInput.files && fileInput.files[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById(
                    'imagePreview').innerHTML =
                    '<img src="' + e.target.result
                    + '"/>';
            };
             
            reader.readAsDataURL(fileInput.files[0]);
        }
    }
}

function fileValidation_2() {
    var fileInput =
        document.getElementById('pan');
     
    var filePath = fileInput.value;
 
    // Allowing file type
    var allowedExtensions =
            /(\.jpg|\.jpeg|\.png|\.gif)$/i;
     
    if (!allowedExtensions.exec(filePath)) {
        alert('Invalid file type');
        fileInput.value = '';
        return false;
    }
    else
    {
     
        // Image preview
        if (fileInput.files && fileInput.files[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById(
                    'imagePreview').innerHTML =
                    '<img src="' + e.target.result
                    + '"/>';
            };
             
            reader.readAsDataURL(fileInput.files[0]);
        }
    }
}

