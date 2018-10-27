# SummaTRON-API
API de acceso al sistema de identificación creada por SummaTRON, tipo 2FA y basado en el Blockchain de TRON

Para incorporar el API debe incluir las instrucciones

En el  HEAD <br>

	<script src="qrcode.min.js" ></script> // es un desarrollo de https://github.com/davidshimjs/qrcodejs
	<script src="/api/js/apisummatron.js" ></script><br>

En en BODY en en el lugar donde quiera que aparezca los QR para realizar el control de entrada<br>

	<div id="PanelPago" style="display:block;"></div> //Con el css se controla cuando debe estar visible y cuando no.
  
  Al final del HTML se incorpora el código <br>
  
       <script>
       $("#PanelPago").load("/api/PanelPago.html", function() {
       sCuenta = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
       $("#Propietario").text(sCuenta);
       Verificar(sCuenta,"ES","FUNCION a EJECUTAR");
       });
       </script>
  <br>
  <p>
  Con este script se muestra el QR y se indica cual es la cuenta TRON de la empresa.
  "ES" o "EN", indica el idioma de los mensajes.
  En FUNCION a EJECUTAR de debe indicar el nombre de la funcion que se ejecutará cuando la identificación finalice, se devuelve como
  parámetro la cuenta TRON o un string vacio, si tras 60 segundos ha se ha producido la identificación.
  </p>
  <p>
  <b>MUY IMPORTANTE</b><br><br>
  Para poder utilizar SummaTRON-API debe registrar el nombre de la empresa que será usado como parte de la clave que se envía en el proceso de identificacion.
  Este proceso se realiza enviando 1 SummaTRON desde la cuenta de la empresa, la misma que luego se debe incluir en la llamada a la función Verificar(), a la cuenta del proyecto: <b>TFQwLDzUvEc99ktd3TvUc9g3uATGmX2fS7</b>, y es muy importante, indicar en la Descripcion el nombre de la empresa, sugerimos que sea el dominio sin www ni .com.
  <br>
  Puedes comprar el Summatron en https://tronscan.org/#/tokens/list?search=IdTronix, 1 TRX = 1 SummaTRON.
  Puedes comprar IdTronix en https://tronscan.org/#/tokens/list?search=IdTronix, 1 TRX = 1000 IdTronix.
  <p>
