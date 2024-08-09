<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<title>Sell Stock</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> 
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
<link rel="stylesheet"  type='text/css' media='screen' href="<%=request.getContextPath()%>/css/checkoutpage.css">
<script type="text/javascript"> function preback() { window.history.forward(); } setTimeout("preback()", 0); window.onunload = function () { null }; </script>
<script type="text/javascript">
	function updateTextInput(x) {
	    	var price = parseFloat($('#price').text()) || 0;
			var qty = parseInt($('#myRange').val());
			const total = price * qty;
			const rt = total.toFixed(2);
			$('#total-val').text(rt);
			$('#amnt').val(rt);
			
			document.getElementById("slider_value").innerHTML= x;
			document.getElementById('qty').value= x;
	}
	
</script>


</head>
<body>

<div class="center-wrapper">
	<div class="content">
	<nav>
		<h1 class="logo">BANKING</h1>
	</nav>
	<div class="top-bar">
	<!-- 	<i class="fas fa-arrow-left"></i> -->
		<a href="selltodemat" class="fas fa-arrow-left"  style="text-decoration:none; color:blue;"></a>
		<span>SELL STOCK</span>
		<a href="logout" style="text-decoration:none; color:Red; float: right; font-weight: 800;">LOGOUT</a>
	</div>
	<div class="bag">
		<p class="bag-head"><span style="text-transform: uppercase">SELECTED STOCK</span></p>
	</div>
	<form action="sellselectedstock" method = "post">
		<div class="bag-product">
			<div class="description">
				<p class="product-code small muted">Stock ID: ${sd.getStock_id()}</p>
				<input type="hidden" name="stock_id" value="${sd.getStock_id()}">
				<input type="hidden" name="sno" value="${sd.getSno()}">
				<br>
				<h2>Stock Name: <span>${sd.getStock_name()}</span></h2>
				<input type="hidden" name="stock_name" value="${sd.getStock_name()}">
				<br>
				<p style="margin-bottom: 0.5rem; font-weight: 800;">Price:</p>
				<c:if test="${not empty ind}">
					<h2><span>&#8377 </span><span id="price">${sd.getPrice()}</span></h2>
				</c:if>
				<c:if test="${not empty usd}">
					<h2><span>&#36 </span><span id="price">${sd.getPrice()}</span></h2>
				</c:if>
				<c:if test="${not empty euro}">
					<h2><span>&#8364 </span><span id="price">${sd.getPrice()}</span></h2>
				</c:if>	
				
				<div class="quantity-wrapper">
					<div>
						<label for="quantity" style="margin-right: 0.5rem;">Quantity:</label>
  							
  							<span id="min_value">0</span>
  							<input type="range" min="0" max="${sd.getAvl_quantity()}" value="0" class="slider" id="myRange" oninput="updateTextInput(this.value);">
  							<span id="max_value">${sd.getAvl_quantity()}</span>
  							
  							<input type="hidden" id="qty" name="quantity" value="">
  							
							<span id="slider_value" style="color:green;font-size: 18px; font-weight:800;"></span>
					</div>
				</div>
			</div>
		</div>
		<div class="bag-total">
			
			<div class="total">
				<h3>Total:</h3>
				
					<c:if test="${not empty ind}">
						<h3><span>&#8377 </span><span id="total-val">0.00</span></h3>
					</c:if>
					<c:if test="${not empty usd}">
						<h3><span>&#36 </span><span id="total-val">0.00</span></h3>
					</c:if>
					<c:if test="${not empty euro}">	
						<h3><span>&#8364 </span><span id="total-val">0.00</span></h3>
					</c:if>	
			
				<input type="hidden" id="amnt" name="totalprice" value="">
			</div>
	
			<button class="btn-go-checkout">
				<span>SELL</span>
			</button>
		</div>
	</form>
</div>
</div>
</body>
</html>