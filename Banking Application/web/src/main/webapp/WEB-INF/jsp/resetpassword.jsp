<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">	
	<title>Reset Password</title>
 	<link rel='stylesheet' type='text/css' media='screen' href='../css/styles.css'> 
    <script defer src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
    <script defer src="../js/script.js"></script> 
    <script defer src="../js/main.js"></script> 
    <script type="text/javascript"> function preback() {window.history.forward();} setTimeout("preback()",0); window.onunload=function() {null}; </script>
  	 <script>
    	alert(" Validation Successful\n Redirecting to Password Rest Page.");
    </script>
<title>Reset Password</title>
</head>
<body>
	<div class="header-container">
		<h1>BANKING</h1>	
	</div>
	
	   <div class="header_col_1">
       <a class="fas fa-arrow-left align-left" href="back"></a>
    </div>
	
	  <div class="header_row_error">
	     	<c:if test="${not empty PasswordError}">
      			<p class="error_password"><span id="error_string">ERROR: </span>${PasswordError}</p>
           	</c:if>
    </div>
    <div class="outer-container">
	<img id="col-gif_3" src="<%=request.getContextPath()%>/img/Lock.gif" alt="Be patient..." />
	
	<div class="container_2">
		<div class="content">
			<form action="resetpassword" method="post">
				<div class="title">Reset Account Password</div>
				<br>
				<div class="user-details_2">
					<input type="hidden" name="usr_id" type="text" value="${usid}" />
					<div class="input-box">
						<span class="details">Password</span> 
							<input class="user-input" name="cred" type="password" minlength="8" maxlength="25" placeholder="Enter New Password" id="pass" autocomplete="off" required >
			            <br>
			            <label for="Tooltips" class="error5"></label>
					</div>
					<div class="input-box">
						<span class="details">Re-enter Password</span> 
							<input class="user-input" name="cred2" type="password" minlength="8" maxlength="25" placeholder="Re-enter the Password" id="passc" autocomplete="off" required>
			            <br>
			            <label for="Tooltips" class="error6"></label>
					</div>
				</div>
				<input class="sub_size1" type="submit" value="Submit" class="btn">
			</form>
		</div>
	</div>
 </div>
</body>
</html>