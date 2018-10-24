const Espanol =
{
"Pagar":"PAGAR con TronWalletMe",
"Enviar":"ENVIAR con cualquier Wallet",
"Importe":"Importe",
"Descripcion":"Descripción",
"Resultado":"Estamos verificando el envío",
"Tiempo":"Tiempo de espera superado"
}
const Ingles =
{
"Pagar":"PAY with TronWalletMe",
"Enviar":"SEND with any Wallet",
"Importe":"Import",
"Descripcion":"Description",
"Resultado":"We are verifing the sending",
"Tiempo":"Time exceeded"
}

function Copy()
{
  const el = document.createElement('textarea');
  el.value = $("#Propietario").text();
  alert("Copiado: " + el.value);
  document.body.appendChild(el);
  el.setAttribute('readonly', '');
  el.style = {position: 'absolute', left: '-9999px'};
  el.select();
  document.execCommand('copy');
  document.body.removeChild(el);
}

function Verificar (sCuenta, sIdioma,sFuncion) 
{
	$("#PanelPago").css("display","block");
	switch (sIdioma)
	{
	case "ES":
		{oLiterales=Espanol;break}	
	case "EN":
		{oLiterales=Ingles;break}
	}
	$("#lPagar").text(oLiterales.Pagar);
	$("#lEnviar").text(oLiterales.Enviar);
	$.get( "/api/jsp/GenerarToken.jsp?Cuenta='"+sCuenta+"'", function(resp) {
		var obj = JSON.parse(resp);
		sDescripcion = obj.Descripcion;
		if (sDescripcion=="Cuenta no Registrada")
		{
			alert("Cuenta no Registrada");
		}
		else
		{
			sImporte = "1";
			$("#Importe").val(sImporte);
			$("#Descripcion").val(sDescripcion);
			$("#DatosEnviar").html("("+oLiterales.Importe+": <b>1 IdTronix</b>. "+oLiterales.Descripcion+": <b>"+sDescripcion+"</b>)");
			var qrcodePagar = new QRCode(document.getElementById("qrcodePagar"), {
				width : 180,
				height : 180
			});
			var qrcodeEnviar = new QRCode(document.getElementById("qrcodeEnviar"), {
				width : 180,
				height : 180
			});
			qrcodeEnviar.makeCode(sCuenta);
			sText = '{"amount":"'+sImporte+'","data":"'+sDescripcion+'","token":"IdTronix","address":"'+sCuenta+'"}';
			qrcodePagar.makeCode(sText);
		}


		sDescripcion=$("#Descripcion").val();
		sImporte = $("#Importe").val();
		$("#resultado").html("<h3>"+oLiterales.Resultado+"</h3>");
		$.get( "/api/jsp/Identificar.jsp?Cuenta='"+sCuenta+"'&Descripcion='"+sDescripcion+"'", function(resp) {
			var obj = JSON.parse(resp);
			
			if (obj.From=="Error")
			{
				$("#resultado").html("<h3>"+oLiterales.Tiempo+"</h3>");
				$("#Pago").css("display","none");
				$("#resultado").css("display","block");
			}
			else
			{
				if ((obj.Amount==sImporte) || (obj.Data==sDescripcion))
				{	
					$("#Pago").css("display","none");
					$("#From").val(obj.From);
					eval( sFuncion + '("'+obj.From+'")' ); 
				}
			}
		});
	});
}
