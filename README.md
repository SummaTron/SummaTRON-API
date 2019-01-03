# SummaTRON-API
API for identification, personal data registration or signature of documents, the identification is like 2FA, and all is supported by TRON Blockchain.

For implementing the API, you must to insert following lines:

In the HEAD <br>

	<script src="jquery-qrcode-0.14.0.min.js" ></script> 
	<script src="/api/js/apisummatron.js" ></script><br>

In the BODY, in the place where you want to show the QR<br>

	<div id="PanelIRS" style="display:block;"></div> //With the css control when show or hide it.
  
  At the end of the HTML insert this code <br>
  
       <script>
       $("#PanelIRS").load("/api/PanelIRS.html", function() {
       sCuenta = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
       Verificar(sCuenta,"ES","FUNCTION to EXECUTE");
       });
       </script>
  <br>
  <p>
  This script show the QR who has the TRON account of the company.
  "ES" o "EN", select the languaje of the messages.
  "FUNCTION to EXECUTE" is the name of the function that the script will execute when the identification process finish. This process return the account of the sender or a string empty, if after 60 seconds there isn't identification.
  </p>
  <p>
  <b>VERY IMPORTANT</b><br><br>
  To be able to use SummaTRON-API you must register the name of the company that will be used as part of the key that is sent in the identification process.
   This process is done by sending 1 SummaTRON from the company's account, which must then be included in the call to the Verify () function, to the project account: <b> TFQwLDzUvEc99ktd3TvUc9g3uATGmX2fS7 </b>, and it is also very important, to indicate in the description the name of the company, we suggest that it be the domain name.
  <br>
You can get all the information abour SummaTRON-API proyect in our <a src="https://github.com/SummaTron/SummaTRON-API/blob/master/SummaTRON_API_WhitePaper_EN.pdf">whitepaper</a>.
