

<!--@page contentType="text/html" pageEncoding="UTF-8"-->
<%@page import="DBWorks.DBConnection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet" %>

<!DOCTYPE html>
<html lang="en">
    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Revenue by Item Type</title>

        <!-- Bootstrap Core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link href="css/manager.css" rel="stylesheet">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>

        <!-- Bootstrap Core JavaScript -->
        <script src="js/bootstrap.min.js"></script>

    </head>
    <body>
        <jsp:include page = "ManagerNav.jsp"/>
        
        <br><br><header>
            <h2>View Revenue Generated by Item Type</h2>
            <hr>
        </header>
        <a href="SumListOfRevenues.jsp" class = "right">Back</a>
        <TABLE BORDER="3" CELLSPACING="1" CELLPADDING="1">
            <TR> <TD ALIGN = "center">AdvertisementID</TD>
                <TD ALIGN = "center">Item Name</TD>
                <TD ALIGN = "center">Revenue</TD>
            </TR>
            <%
                String itemType = request.getParameter("ItemType");
                String query = "SELECT TS.AdvertisementId, TS.ItemName, TS.NumberSold * TS.UnitPrice "
                        + "AS Revenue FROM TotalSale TS, Advertisement A where TS.AdvertisementID = "
                        + "A.AdvertisementID AND A.Type = '" + itemType + "'";
                java.sql.ResultSet rs = DBConnection.ExecQuery(query);

                while (rs.next()) {
                    String advertisementID = rs.getString("AdvertisementID");
                    String itemName = rs.getString("ItemName");
                    String revenue = rs.getString("Revenue");
            %>



            <TR> <TD ALIGN = "center"><%out.println(advertisementID);%> </TD>
                <TD ALIGN = "center"><%out.println(itemName);%> </TD>
                <TD ALIGN = "center"><%out.println(revenue);%> </TD>

            <%
                }
            %>
        </TABLE>
        
    </body>

</html>