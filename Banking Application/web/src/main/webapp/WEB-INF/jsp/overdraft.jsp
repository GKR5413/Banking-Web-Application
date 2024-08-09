<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel='stylesheet' type='text/css' media='screen' href='../css/styles.css'> 
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
    <script type="text/javascript"> function preback() { window.history.forward(); } setTimeout("preback()", 0); window.onunload = function () { null }; </script>
    <script defer src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script defer src="../js/script.js"></script> 
    <script defer src="../js/main.js"></script> 
<title>OverDraft</title>
</head>
<body>
	<div class="header-container">
		<h1>BANKING</h1>
	</div>

	 <div class="header_col_1">
	       <a class="fas fa-arrow-left align-left" href="backtoaccount"></a>
    	   <a class="fas align-right" href="logout">LOGOUT</a>
    </div>
	
	<div class="container">
		<div class="content">
			<form action="overdraft" method="post" enctype="multipart/form-data">
				<div class="title">Overdraft Application</div>
				<div class="user-details">
					<input type="hidden" name="usr_id" type="text" value="${usid}" />
					<div class="row_col">
					<div class="input-box">
						<span class="details">Required Loan Amount</span>
						<div class="p-holder">	
						
							<c:if test="${not empty ind}">
							<span class="currency">&#8377</span>
							</c:if>
							<c:if test="${not empty usd}">
							<span class="currency">&#36</span>
							</c:if>
							<c:if test="${not empty euro}">
							<span class="currency">&#8364</span>
							</c:if>
							
							<input class="user-input"
								name="rqloan_amnt" type="text" placeholder="xxxxxxxxxxxx"
								onkeypress="return onlyNumberKey(event)" maxlength="15" required />
						</div>
					</div>
					
					<div class="input-box">
						<span class="details">Monthly Income</span>
						<div class="p-holder">
							<c:if test="${not empty ind}">
								<span class="currency">&#8377</span>
							</c:if>
							<c:if test="${not empty usd}">
								<span class="currency">&#36</span>
							</c:if>
							<c:if test="${not empty euro}">
								<span class="currency">&#8364</span>
							</c:if>
							<input class="user-input"
									type="text" name="mnth_incm" placeholder="The amount you get in your account"
									onkeypress="return onlyNumberKey(event)" maxlength="10" required />
						</div>
					</div>
					</div>
					<div class="input-box">
						<span class="details">Salary Received in?</span>
						<select id="mode-of-salary" name="mode_of_salary">
							<option value="select">Select your mode of salary</option>
							<option value="cash">Cash</option>
							<option value="check">check</option>
							<option value="Bank Transfer">Bank Transfer</option>
						</select>
					</div>
				</div>
				<input class="sub_size2" type="submit" value="Submit" class="btn"> 
			</form>
		</div>
	</div>
</body>
</html>