<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>

<html lang="en" dir="ltr">
<head>
<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Register</title>
<link rel='stylesheet' type='text/css' media='screen' href='<%=request.getContextPath()%>/css/styles.css'>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
<script defer src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript"> function preback() { window.history.forward(); } setTimeout("preback()", 0); window.onunload = function () { null }; </script>
<script defer src="<%=request.getContextPath()%>/js/script.js"></script>
<script defer src="<%=request.getContextPath()%>/js/main.js"></script>


<script type="text/javascript">
	function preback() {
		window.history.forward();
	}
	setTimeout("preback()", 0);
	window.onunload = function() {
		null
	};
</script>
</head>
<body class="lp_body">
	<div class="header-container">
		<h1>BANKING</h1>
	</div>
	<div class="header_col_1">
        <a href="back" class="fas fa-arrow-left align-left"></a>
    </div>
	 <div class="header_row_error">
		<c:if test="${not empty Email_Error}">
        <p class="error_email"><span id="error_string">ERROR: </span>${Email_Error}</p>
        </c:if>
        <c:if test="${not empty PhoneNumber_Error}">
        <p class="error_phone"><span id="error_string">ERROR: </span>${PhoneNumber_Error}</p>
        </c:if>
        <c:if test="${not empty Aadhar_Error}">
        <p class="error_aadhar"><span id="error_string">ERROR: </span>${Aadhar_Error}</p>
        </c:if>
        <c:if test="${not empty Pan_Error}">
        <p class="error_pan"><span id="error_string">ERROR: </span>${Pan_Error}</p>
        </c:if>  
        <c:if test="${not empty PasswordError}">
      		<p class="error_password"><span id="error_string">ERROR: </span>${PasswordError}</p>
        </c:if>
	</div>	
	
	<div class="container">
		<div class="content">
			<c:if test="${not empty input}">
		     <form action="register" method="post" enctype="multipart/form-data">
				
				<div class="title">Account Registration</div>
				
				<div class="user-details">
		
							<!--Account  details -->
					<c:if test="${input.getAccount_Type() == 'savings'}">
						<div class="sub_head">Account Information</div>
							<div class="input-box">
								<span class="details">Account Type</span> <select
									name="Account_Type">
									<option value="">-- Select --</option>
									<option value="savings" selected>Savings Account</option>
									<option value="current">Current Account</option>
								</select>
								<div class="error"></div>
							</div>
					</c:if>
					
					<c:if test="${input.getAccount_Type() == 'current'}">
						<div class="sub_head"><span class="number">1</span>Account Information</div>
							<div class="input-box">
								<span class="details">Account Type</span> <select
									name="Account_Type">
									<option value="">-- Select --</option>
									<option value="savings">Savings Account</option>
									<option value="current" selected>Current Account</option>
								</select>
								<div class="error"></div>
							</div>
					</c:if>

					
					<c:if test="${input.getCurrency_Type() == 'usd'}">
						<div class="input-box">
								<span class="details">Currency</span> <select name="Currency_Type">
									<option value="">-- Select --</option>
									<option value="usd" selected>USD - US Dollar</option>
									<option value="eur">Euro</option>
									<option value="rupee">IND - Rupee</option>
								</select>
								<div class="error"></div>
							</div>
					</c:if>
					
					<c:if test="${input.getCurrency_Type() == 'eur'}">
						<div class="input-box">
								<span class="details">Currency</span> <select name="Currency_Type">
									<option value="">-- Select --</option>
									<option value="usd">USD - US Dollar</option>
									<option value="eur" selected>Euro</option>
									<option value="rupee">IND - Rupee</option>
								</select>
								<div class="error"></div>
							</div>
					</c:if>
					
					<c:if test="${input.getCurrency_Type() == 'rupee'}">
						<div class="input-box">
								<span class="details">Currency</span> <select name="Currency_Type">
									<option value="">-- Select --</option>
									<option value="usd">USD - US Dollar</option>
									<option value="eur">Euro</option>
									<option value="rupee" selected>IND - Rupee</option>
								</select>
								<div class="error"></div>
							</div>
					</c:if>

					<!-- personal details -->
					<div class="sub_head"><span class="number">2</span>Personal Information</div>

					<div class="row_col">
						<div class="input-box">
							<span class="details">First Name</span> <input class="user-input"
								type="text" id="name1" name="First_Name" value ="${input.getFirst_Name()}" minlength="3" maxlength="30" autocomplete="off" required/>
							<div class="error"></div>
						</div>

						<div class="input-box">
							<span class="details">Last Name</span> <input class="user-input"
								type="text" id="name2" name="Last_Name" value ="${input.getLast_Name()}" minlength="1" maxlength="20" autocomplete="off" required/>
							<div class="error"></div>
						</div>
					</div>

					<div class="input-box">
						<span class="details">Date Of Birth</span> <input
							class="user-input" id="txtDate" name="Date" value ="${input.getDate()}" pattern="yyyy/MM/dd" type="date" autocomplete="off" required/>
						<div class="error"></div>
					</div>

					<div class="row_col">
						<div class="input-box">
							<span class="details">Email</span> <input class="user-input"
								type="text" name="Email" id="email" value ="${input.getEmail()}" minlength="11" maxlength="62" autocomplete="off" required/>
							<div class="error"></div>
						</div>

						<div class="input-box">
							<span class="details">Phone Number</span> <input
								class="user-input" type="text" id="phone"
								name="PhoneNumber" onkeypress="return onlyNumberKey(event)" value ="${input.getPhoneNumber()}"  minlength="10" maxlength=10 autocomplete="off" required/>
							<div class="error"></div>
						</div>
					</div>

					<div class="row_col">
						<div class="input-box">
							<span class="details">Password</span> <input class="user-input"
								type="password" name="cred" id="pass" minlength="8" maxlength="25" autocomplete="off" required>
							<div class="error"></div>
						</div>

						<div class="input-box">
							<span class="details">Confirm Password</span> <input
								class="user-input" type="password" name="cred2" id="passc" maxlength="25" autocomplete="off" required>
							<div class="error"></div>
						</div>
					</div>

					<div class="show" id="details">
						<!-- SavingsAccount -->
						<div class="sub_head"><span class="number">3</span>Address</div>
						<!-- Address BLock -->
						<div class="row_col">
							<div class="input-box">
								<span class="details">Street</span> <input class="user-input"
									id="address_row_1" name="Street" type="text" value ="${input.getStreet()}" maxlength="100" autocomplete="off" required/>
								<div class="error"></div>
							</div>
							<div class="input-box">
								<span class="details">City</span> <input class="user-input"
									id="address_row_2" name="City" type="text" value ="${input.getCity()}" maxlength="20" autocomplete="off" required/>
								<div class="error"></div>
							</div>
							<div class="input-box">
								<span class="details">Pincode</span> <input class="user-input"
									id="address_row_3" name="Zipcode" type="text" value ="${input.getZipcode()}" onkeypress="return onlyNumberKey(event)" maxlength="6" autocomplete="off" required/>
								<div class="error"></div>
							</div>
							<div class="input-box">
								<span class="details">State</span> <input class="user-input"
									id="address_row_4"  name="State" type="text" value ="${input.getState()}" maxlength="20" autocomplete="off" required/>
								<div class="error"></div>
							</div>
							<div class="input-box">
								<span class="details">Country</span> <input class="user-input"
									id="address_row_5" name="Country" type="text" value ="${input.getCountry()}" maxlength="20" autocomplete="off" required/>
								<div class="error"></div>
							</div>

							<!-- Address Proofs -->
							<div class="input-box">
								<span class="details">Aadhar Number</span> <input
									class="user-input" name="Res_id" id="id_proof_1" value ="${input.getRes_id()}" onkeypress="return onlyNumberKey(event)" type="text" minlength="12" maxlength="12" autocomplete="off" required/>
								<div class="error"></div>
							</div>
							<div class="input-box">
								<span class="details">Pan Number</span> <input
									class="user-input" name="Fin_id" id="id_proof_2" value ="${input.getFin_id()}" type="text" minlength="10" maxlength="10" autocomplete="off" required/>
								<div class="error"></div>
							</div>	
						</div>

						<div>
							<br> <input type="checkbox" id="check1" onclick="enable()">
							<label>Aadhar Card</label> <input type="file" name="Res_proof"
								id="aadhar" onchange="return fileValidation_1()" disabled /> 
							<br> <br> <input type="checkbox" id="check2"
								onclick="enable2()"> <label>PAN Card</label> <input
								type="file" name="Fin_proof" id="pan"
								onchange="return fileValidation_2()" disabled/>
						</div>
					</div>
			
					<input type="submit" id="submit" value="Register" class="btn" />
				
					</div>
				</form>
            </c:if>
		
			<c:if test="${ empty input}">
			
			<form action="register" method="post" enctype="multipart/form-data">
				<div class="title">Account Registration</div>
				<div class="user-details">

					<!--Account  details -->
					<div class="sub_head"><span class="number">1</span>Account Information</div>
					<div class="input-box">
						<span class="details">Account Type</span> <select
							name="Account_Type">
							<option value="">-- Select --</option>
							<option value="savings">Savings Account</option>
							<option value="current">Current Account</option>
						</select>
						<div class="error"></div>
					</div>

					<div class="input-box">
						<span class="details">Currency</span> <select name="Currency_Type">
							<option value="">-- Select --</option>
							<option value="usd">USD - US Dollar</option>
							<option value="eur">Euro</option>
							<option value="rupee">IND - Rupee</option>
						</select>
						<div class="error"></div>
					</div>

					<!-- personal details -->
					<div class="sub_head"><span class="number">2</span>Personal Information</div>

					<div class="row_col">
						<div class="input-box">
							<span class="details">First Name</span> <input class="user-input"
								type="text" id="name1" name="First_Name" minlength="3" maxlength="30" autocomplete="off" required/>
							<div class="error"></div>
						</div>

						<div class="input-box">
							<span class="details">Last Name</span> <input class="user-input"
								type="text" id="name2" name="Last_Name" minlength="1" maxlength="20" autocomplete="off" required/>
							<div class="error"></div>
						</div>
					</div>

					<div class="input-box">
						<span class="details">Date Of Birth</span> <input
							class="user-input" id="txtDate" name="Date" pattern="yyyy/MM/dd" type="date" autocomplete="off" required/>
						<div class="error"></div>
					</div>

					<div class="row_col">
						<div class="input-box">
							<span class="details">Email</span> <input class="user-input"
								type="text" name="Email" id="email" minlength="11" maxlength="62" autocomplete="off" required/>
							<div class="error"></div>
						</div>

						<div class="input-box">
							<span class="details">Phone Number</span> <input
								class="user-input" type="text" id="phone"
								name="PhoneNumber" onkeypress="return onlyNumberKey(event)" minlength="10" maxlength=10 autocomplete="off" required/>
							<div class="error"></div>
						</div>
					</div>

					<div class="row_col">
						<div class="input-box">
							<span class="details">Password</span> <input class="user-input"
								type="password" name="cred" id="pass" minlength="8" maxlength="25" autocomplete="off" required>
							<div class="error"></div>
						</div>

						<div class="input-box">
							<span class="details">Confirm Password</span> <input
								class="user-input" type="password" name="cred2" id="passc" maxlength="25" autocomplete="off" required>
							<div class="error"></div>
						</div>
					</div>

					<div class="show" id="details">
						<!-- SavingsAccount -->
						<div class="sub_head"><span class="number">3</span>Address</div>
						<!-- Address BLock -->
						<div class="row_col">
							<div class="input-box">
								<span class="details">Street</span> <input class="user-input"
									id="address_row_1" name="Street" type="text" maxlength="100" autocomplete="off" required/>
								<div class="error"></div>
							</div>
							<div class="input-box">
								<span class="details">City</span> <input class="user-input"
									id="address_row_2" name="City" type="text" maxlength="20" autocomplete="off" required/>
								<div class="error"></div>
							</div>
							<div class="input-box">
								<span class="details">Pincode</span> <input class="user-input"
									id="address_row_3" name="Zipcode" type="text" onkeypress="return onlyNumberKey(event)" maxlength="6" autocomplete="off" required/>
								<div class="error"></div>
							</div>
							<div class="input-box">
								<span class="details">State</span> <input class="user-input"
									id="address_row_4"  name="State" type="text" maxlength="20" autocomplete="off" required/>
								<div class="error"></div>
							</div>
							<div class="input-box">
								<span class="details">Country</span> <input class="user-input"
									id="address_row_5" name="Country" type="text" maxlength="20" autocomplete="off" required/>
								<div class="error"></div>
							</div>

							<!-- Address Proofs -->
							<div class="input-box">
								<span class="details">Aadhar Number</span> <input
									class="user-input" name="Res_id" id="id_proof_1" onkeypress="return onlyNumberKey(event)" type="text" minlength="12" maxlength="12" autocomplete="off" required/>
								<div class="error"></div>
							</div>
							<div class="input-box">
								<span class="details">Pan Number</span> <input
									class="user-input" name="Fin_id" id="id_proof_2" type="text" minlength="10" maxlength="10" autocomplete="off" required/>
								<div class="error"></div>
							</div>	
						</div>

						<div>
							<br> <input type="checkbox" id="check1" onclick="enable()">
							<label>Aadhar Card</label> <input type="file" name="Res_proof"
								id="aadhar" onchange="return fileValidation_1()" disabled /> 
							<br> <br> <input type="checkbox" id="check2"
								onclick="enable2()"> <label>PAN Card</label> <input
								type="file" name="Fin_proof" id="pan"
								onchange="return fileValidation_2()" disabled/>
						</div>
					</div>
					<input class="sub_size2" type="submit" id="submit" value="Register" class="btn" />
				
				</div>
			</form>
			</c:if>
			</div>
		</div>
</body>
</html>
