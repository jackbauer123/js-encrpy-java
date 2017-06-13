<html>
<head>
	<script src="js/security.js"></script>
	<script src="js/jquery-1.7.2.js"></script>
</head>
<body>
	<h2>Hello World!</h2>
	<form action="/ajax-encrtpy/login" method="get">
	username:<input id="test" name="test"/>
	<input type="button" id="buttons" value="login">
	</form>
	
	<script type="text/javascript">
		var modulus=null, exponent=null;
			$.ajax({
				url:"/ajax-encrtpy/getPublicKey",
				type:"get",
				async:false,
				success:function(data){
					var obj=JSON.parse(data)
				 	modulus = obj.modulus;
				 	exponent = obj.exponent;
				 	
				}
		
			}); 
		
			$("#buttons").on('click',function(){
				var epwd = $('#test').val();
		        if (epwd.length != 256) {
		            var publicKey = RSAUtils.getKeyPair(exponent, '', modulus);
		            $('#test').val(RSAUtils.encryptedString(publicKey, epwd));
		        }
		        var passwd=$("#test").val();
				 $.ajax({
					url:"/ajax-encrtpy/login",
					type:"get",
					data:{'test':passwd},
					success:function(data){
						console.info(data);
					}
					
				}); 
			});
		
		
	</script>
</body>
</html>
