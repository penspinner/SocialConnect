
<%-- 
    Document   : CourseDelete
    Created on : Oct 28, 2014, 11:27:08 PM
    Author     : Ahmad
--%>

<%@page import="DBWorks.DBConnection"%>
<%@page import="java.sql.SQLException"%>
<%@ page import="java.sql.ResultSet" %>

<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Student Registration System</title>

        <!-- Bootstrap Core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link href="css/sb-admin.css" rel="stylesheet">

        <!-- Custom Fonts -->
        <link href="font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
            <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->

    </head>

    <body>

        <div id="wrapper">

            <!-- Navigation -->
            <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="StudentInformation.jsp">Registration System </a>
                </div>
                <!-- Top Menu Items -->
                <ul class="nav navbar-right top-nav">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> <%out.print(session.getAttribute("login")); %> <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li>
                                <a href="#"><i class="fa fa-fw fa-user"></i> Profile</a>
                            </li>
                            <li>
                                <a href="#"><i class="fa fa-fw fa-envelope"></i> Inbox</a>
                            </li>
                            <li>
                                <a href="#"><i class="fa fa-fw fa-gear"></i> Settings</a>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <a href="logout.jsp"><i class="fa fa-fw fa-power-off"></i> Log Out</a>
                            </li>
                        </ul>
                    </li>
                </ul>
                <!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->
                <div class="collapse navbar-collapse navbar-ex1-collapse">
                    <ul class="nav navbar-nav side-nav">
                        <li>
                            <a href="StudentInformation.jsp"><i class="fa fa-fw fa-dashboard"></i> Dashboard</a>
                        </li>
                        <li>
                            <a href="CourseSearch.jsp"><i class="fa fa-fw fa-dashboard"></i> Course Search</a>
                        </li>
                    </ul>
                </div>
                <!-- /.navbar-collapse -->
            </nav>

            <div id="page-wrapper">

                <div class="container-fluid">

                    <!-- Page Heading -->
                    <div class="row">
                        <div class="col-lg-12">
                            <h1 class="page-header">
                                Dashboard
                                <small>Course List</small>
                            </h1>
                            <ol class="breadcrumb">
                                <li>
                                    <i class="fa fa-dashboard"></i>  <a href="StudentInformation.jsp">Dashboard</a>
                                </li>
                                <li class="active">
                                    <i class="fa fa-file"></i> 
                                </li>
                            </ol>
                        </div>
                    </div>
                    <!-- /.row -->

                    <div class="row">
                        <div class="col-lg-6">
                            <h2>Your Course List</h2>
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th> CrsCode </th>
                                            <th> CrsName </th>    
                                            <th>DeptID</th>
                                            <th>ProfName</th>
                                            <th>Grade</th>
                                            <th> Operation</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            String stuID = session.getAttribute("login").toString();
                                            String Query
                                                    = "select Course.CrsCode,Course.CrsName,"
                                                    + " Course.DeptID,Professor.Name,"
                                                    + " Transcript.Grade from Course,"
                                                    + " Professor,Transcript where"
                                                    + " Course.CrsCode=Transcript.CrsCode"
                                                    + " and Professor.Id=Course.InsNo"
                                                    + " and Transcript.StudId='" + stuID + "'";
                                            java.sql.ResultSet rs = DBConnection.ExecQuery(Query);
                                            String strGrade = null;
                                            while (rs.next()) {
                                                strGrade = rs.getString(5);
                                                if (rs.getString(5).trim().equals("-1")) {
                                                    strGrade = "N/A";
                                                }
                                        %>
                                        <tr>
                                            <td > <% out.print(rs.getString(1)); %> </td>
                                            <td > <% out.print(rs.getString(2)); %> </td>
                                            <td > <% out.print(rs.getString(3)); %> </td>
                                            <td > <% out.print(rs.getString(4)); %> </td>
                                            <td > <% out.print(strGrade); %> </td>
                                            <td>
                                                <% if (rs.getString(5).trim().equals("-1")) {%>
                                                <input type="button" onclick="javascript:if (confirm('Are you sure that you want to delete the course?') == true)
                                                        {
                                                            window.open('CourseDelete.jsp?userid=<%=stuID%>&crscode=<%=rs.getString(1)%>', '_self');
                                                        }
                                                        ;
                                                        return;" value="Delete">
                                                <%} else {

                                                        out.print("No Change");

                                                    }

                                                %>
                                            </td>
                                        </tr>
                                        <%                                       }
                                        %>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!-- /.container-fluid -->

                </div>
                <!-- /#page-wrapper -->

            </div>
            <!-- /#wrapper -->

            <!-- jQuery Version 1.11.0 -->
            <script src="js/jquery-1.11.0.js"></script>

            <!-- Bootstrap Core JavaScript -->
            <script src="js/bootstrap.min.js"></script>

    </body>

</html>
