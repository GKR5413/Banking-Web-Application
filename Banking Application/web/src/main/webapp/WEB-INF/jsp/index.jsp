<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Banking</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <link rel='stylesheet' type='text/css' media='screen' href='<%=request.getContextPath()%>/css/main.css'>
	<script defer src="<%=request.getContextPath()%>/js/script.js"></script>
    <script type="text/javascript"> function preback() { window.history.forward(); } setTimeout("preback()", 0); window.onunload = function () { null }; </script> 
</head>

<body>
    <div class="logo_header">
        <h1 id="logo">BANKING</h1>
    </div>
    
    <div class="header_col_1">
        <p>Welcome! </p>
    </div>
    
	    <div class="header_row_error">
		    <c:if test="${not empty Invalid_Password}">
		    	<p class="error_password"><span id="error_string">ERROR: </span>${Invalid_Password}</p>
		    </c:if>
		    <c:if test="${not empty Invalid_UserId}">
		       	<p class="error_userid"><span id="error_string">ERROR: </span>${Invalid_UserId}</p>
		    </c:if>
	    </div>
	    
	   <div class="outer-container">
	    
	    <img id="col-gif" src="<%=request.getContextPath()%>/img/bank5.gif" alt="Be patient..." />	    
	    
	    <div class="container">
	        <h2>Banking Login</h2>
	        <form method="post" action="login">
	            <div class="txt_field" >
	                <input type="text" name="userId" onkeypress="return onlyNumberKey(event)" maxlength="10" autocomplete="off" required>
	                <span></span>
	                <label>UserId</label>
	            </div>
		        <div class="txt_field">
	                <input type="password" name="cred" maxlength="25" autocomplete="off" required>
	                <span></span>
	                <label>Password</label>
	            </div>
	            <a class="pass" href="/forgotpassword">Forgot Password?</a><br>
	            <input type="submit" value="Login">
	            <div class="signup_link">
	                Not a member? <a href="/register">Signup</a>
	            </div>
	        </form>
	    </div>
	   </div>
	    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
    <script src='main.js'></script>
    
  <input type="hidden" id="alert_msg" value="${alert_msg}">
	<!-- ----------------------JavaScript------------------ -->
	 <script>
	 	
	 	const msg = document.getElementById("alert_msg").value;
	 		if(msg != 'null'){
	 			alert(msg);
	 		}
	 	
	 </script>
	 
</body>

</html>