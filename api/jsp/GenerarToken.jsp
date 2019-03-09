<%@ page pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*" %>

<%@ page import="java.io.*,java.util.*, javax.servlet.*, java.util.regex.*" %>
<%@ page import="java.io.IOException" %>
<%@ page import= "java.net.*" %>
<%@ page import= "java.text.DateFormat" %>
<%@ page import= "java.text.SimpleDateFormat" %>
<%@ page import= "java.util.Date" %>

<%@ page import="org.jsoup.Jsoup" %>
<%@ page import="org.jsoup.Connection" %>
<%@ page import="org.json.*" %>
<%@ page import="java.util.Random" %>
<%@include file="variables.jsp" %>  
<%@include file="Utils.jsp" %> 

<%
String myVar = LeerPrivateKey ();

String sCuenta = request.getParameter("Cuenta").replaceAll("'","");
String sCuentaTRON = "TFQwLDzUvEc99ktd3TvUc9g3uATGmX2fS7"; // Esta la cuenta de SummaTRON donde se deben registrar las cuentas clientes
String sUrlTransacciones= "https://apilist.tronscan.org/api/transfer?sort=-timestamp&limit=50&token=SummaTRON&address="+sCuentaTRON;
String sUrlHash= "https://api.trongrid.io/wallet/gettransactionbyid?value=";

	Integer i=0, k=0;
	String sLista="{'Descripcion':'Cuenta no Registrada'}", sTransacciones = "";
	String sHash="", sData="", sAmount="", sFrom="";
	int intValueOfChar;
	String [] aZonas, aTransacciones;
	JSONObject oDatos;
	
	try 
	{
		sTransacciones="";
		InputStream input = new URL(sUrlTransacciones).openStream();
		Reader reader = new InputStreamReader(input, "UTF-8");
		while ((intValueOfChar = reader.read()) != -1) {
			sTransacciones += (char) intValueOfChar;
	}
	reader.close();
	
	JSONObject obj = new JSONObject(sTransacciones);
	JSONArray arr = obj.getJSONArray("data");
	for (i = 0; i < arr.length(); i++)
	{
		sHash = arr.getJSONObject(i).getString("transactionHash");
		sAmount = arr.getJSONObject(i).getString("amount");
		sFrom = arr.getJSONObject(i).getString("transferFromAddress");
		if ((sAmount.equals("1")) && sFrom.equals (sCuenta) )// Tiene que ser>=1
		{		
			sHash = sUrlHash+sHash;

			oDatos = Get_Datos(sHash);
			sData = oDatos.getString("Data");
			
			sLista = "{'Descripcion':'"+sData+"-"+ (int) (Math.random() * 100000)+"'}";
			i=arr.length();
		}
	}
	}
	catch(Exception e) {System.out.println(e);sLista = "{'Descripcion':'www.SummaTRON.com-AVA'}";
	
	}
	
	
System.out.println("Retorno:"+sLista);
out.println(sLista.replaceAll("'","\""));
%>
<%! 
private static String hexToAscii(String hexStr) {
    StringBuilder output = new StringBuilder("");
     
    for (int i = 0; i < hexStr.length(); i += 2) {
        String str = hexStr.substring(i, i + 2);
        output.append((char) Integer.parseInt(str, 16));
    }
     
    return output.toString();
}
%>
