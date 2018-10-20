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

function Verificar (sCuenta,sFuncion) 
{
	$("#PanelPago").css("display","block");
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
			$("#DatosEnviar").html("(Importe: <b>1 IdTronix</b>. Descripción: <b>"+sDescripcion+"</b>)");
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
		$("#resultado").html("<h3>Estamos verificando el envío</h3>");
		$.get( "/api/jsp/Identificar.jsp?Cuenta='"+sCuenta+"'&Descripcion='"+sDescripcion+"'", function(resp) {
			var obj = JSON.parse(resp);
			
			if (obj.From=="Error")
			{
				$("#resultado").html("<h3>Tiempo de espera superado</h3>");
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