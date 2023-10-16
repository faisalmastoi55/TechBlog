<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isErrorPage="true" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sorry ! something went wrong</title>
        
        <!--bootstrap-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

        <!--css-->
        <link href="css/myStyle.css" rel="stylesheet" type="text/css"/>

        <!--icons-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    
        <style>
            .banner-background{
                clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 95%, 68% 93%, 30% 98%, 0 93%, 0 0);
            }
        </style>
        
    </head>
    <body>
        
        <div class="container text-center">
            <img src="img/computer.png" class="img-fluid mt-5">
            <h1 class="display-3">Sorry ! something went wrong</h1>
            <%= exception %>
            <br>
            <a href="index.jsp" class="btn btn-lg primary-background text-white mt-3">Home</a>
        </div>
        
    </body>
</html>
