<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
  	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
  	<title>Forgot Password</title>
    <link rel='stylesheet' type='text/css' media='screen' href='<%=request.getContextPath()%>/css/styles.css'>
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
    <script defer src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script defer src="<%=request.getContextPath()%>/js/script.js"></script>
	<script defer src="<%=request.getContextPath()%>/js/main.js"></script>
	<script type="text/javascript"> function preback() { window.history.forward(); } setTimeout("preback()", 0); window.onunload = function () { null }; </script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
  </head>
  
<body class="f_2_arr">

  <div class="header-container">
	<h1>BANKING</h1>
  </div>
  
   <div class="header_col_1">
        <a href="back" class="fas fa-arrow-left align-left"></a>
    </div>
  
  <div class="header_row_error">
	       <c:if test="${not empty Invalid_Email}">
           		<p class="error_email"><span id="error_string">ERROR: </span>${Invalid_Email}</p>
           </c:if>
           <c:if test="${not empty Invalid_UserId}">
           		<p class="error_userid"><span id="error_string">ERROR: </span>${Invalid_UserId}</p>
           </c:if>
    </div>
  <div class="outer-container">
  <img id="col-gif_2" src="<%=request.getContextPath()%>/img/forgotpassword.gif" alt="Be patient..." />
  
  <div class="container_2">

    <div class="content">
      <form action="forgotpassword" method="post">
        <div class="user-details_2">
          <div class="title">Forgot Password</div>      
          <br>
          <div class="input-box">
            <span class="details">userID</span>
            <input class="user-input" name="usr_id" type="text" maxlength="8"  placeholder="Enter your UserID" autocomplete="off" required>
            <br>
            <label for="Tooltips" class="error2"></label>
          </div>
          
          <div class="input-box">
            <span class="details">Email</span>
            <input class="user-input" name="email" type="text" id="email" placeholder="Enter your Email ID" autocomplete="off" required>
            <br>
            <label for="Tooltips" class="error1"></label>
          </div>  
        </div>
		<br>
		<br>
        <input class="sub_size1" type="submit" value="Verify">
      </form>
      
    </div>
  </div>
	</div>
</body>
</html>
