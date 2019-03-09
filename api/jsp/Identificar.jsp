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
<%@include file="Utils.jsp" %> 

<%

String sCuenta= request.getParameter("Cuenta").replaceAll("'","");
String sDescripcion = request.getParameter("Descripcion").replaceAll("'","");
String sUrlTransacciones= "https://apilist.tronscan.org/api/transaction?sort=-timestamp&limit=3&token=IdTronix&address="+sCuenta;
String sUrlHash= "https://api.trongrid.io/wallet/gettransactionbyid?value=";
	Integer i=0, k=0, nTope=0, nIni=0, nFin=0, nVeces=0;
	String sRespuesta="", sLista="", sTransacciones = "", sStatus="", sT="", sAccount="", sSaldo="", sName="", sTokenName="", sToken="";
	String sBalance="", sHash="", sData="", sTo="", sFrom="", sAmount="", sTimestamp="";
	int intValueOfChar;
	String [] aZonas, aTransacciones;
	sLista = "{'From':'Error','Amount':'Error','Token':'Error','Data':'Error'}";
	InputStream input;
	Reader reader;
	JSONObject oDatos, obj, obj1;
	JSONArray arr;
	System.out.print("Entro en Identificar:" + sCuenta + " " + sDescripcion);
	// Localiza la última transaccion
	System.out.println("URL: "+sUrlTransacciones);
	// Localiza la última transaccion
	while (k<60)	
	{
		try
		{
			sTransacciones="";
			input = new URL(sUrlTransacciones).openStream();
			reader = new InputStreamReader(input, "UTF-8");
			while ((intValueOfChar = reader.read()) != -1) {
				sTransacciones += (char) intValueOfChar;
			}
			reader.close();
			//System.out.println("Apilist: "+sTransacciones);
			obj = new JSONObject(sTransacciones);
			arr = obj.getJSONArray("data");
			i=0;
			nTope=arr.length();
			if (nTope>3){nTope=3;}
			while (i < nTope)
			{	
				try
				{
					sHash = sUrlHash+arr.getJSONObject(i).getString("hash");
					sTimestamp =arr.getJSONObject(i).getString("timestamp");
					oDatos = Get_Datos(sHash);
					sData = oDatos.getString("Data");
					sFrom = oDatos.getString("From");
					
					//System.out.println("Data: "+sData);
					Long nDif=System.currentTimeMillis()-Long.valueOf(sTimestamp);

					if (nDif<60000)
					{
						if (sData.equals(sDescripcion))
						{
							sLista = "{'From':'"+sFrom + "','Amount':'1','Token':'IdTronix','Data':'"+ sData +"'}";
							k=100;
							i=100;
							break;
						}
						else
						{i++;}
					}
					else
						{i++;}
				}
				catch (Exception e) {i++;}
			}
			if (k<61)
			{Thread.sleep(2000); k++;}
			//System.out.println("Data:" + sLista);
		}
		catch (Exception e)
		{
		   // Error en algun momento.
		   System.out.println("Excepcion "+e);
		   e.printStackTrace();
		}
	}
System.out.println("Retorno:" + sLista);
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
