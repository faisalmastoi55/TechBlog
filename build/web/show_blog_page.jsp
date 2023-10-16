<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="com.tech.blog.dao.UserDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Categories"%>
<%@page import="com.tech.blog.entities.Posts"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page errorPage="error_page.jsp" %>

<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login_page.jsp");
    }
%>

<%
    int postId = Integer.parseInt(request.getParameter("post_id"));

    PostDao d = new PostDao(ConnectionProvider.getConnection());

    Posts post = d.getPostByPostId(postId);
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> <%= post.getpTitle()%> </title>

        <!--bootstrap-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

        <!--css-->
        <link href="css/myStyle.css" rel="stylesheet" type="text/css"/>

        <!--icons-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <div id="fb-root"></div>
    <script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v16.0" nonce="AfL6klWw"></script>


    <style>
        .banner-background{
            clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 95%, 68% 93%, 30% 98%, 0 93%, 0 0);
        }

        .post-title{
            font-weight: 100;
            font-size: 30px;
        }

        .post-content{
            font-weight: 100;
            font-size: 25px;
        }

        .post-user-info{
            font-size: 20px;
        }

        .post-date{
            font-style: italic;
            font-weight: bold;
        }

        .row-user{
            border: 1px solid #e2e2e2;
            padding-top: 15px;
        }

        body{
            background: url(img/bg.jpg);
            background-size: cover;
            background-attachment: fixed;
        }

    </style>

</head>
<body>

    <!--navbar-->

    <nav class="navbar navbar-expand-lg navbar-dark primary-background ">
        <div class="container-fluid">
            <a class="navbar-brand" href="index.jsp"> <span class="fa fa-asterisk"></span> Tech Blog</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="profile_page.jsp"> <span class="fa fa-bell-o"></span> Learn with Faisal</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <span class="fa fa-check-square-o"></span> Categories
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <li><a class="dropdown-item" href="#">Programming Language</a></li>
                            <li><a class="dropdown-item" href="#">Project Implementation</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="#">Data Structure</a></li>
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"> <span class="fa fa-address-card-o"></span> Contact</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#post-model"> <span class="fa fa-asterisk"></span> Do Post</a>
                    </li>
                </ul>
                <ul class="navbar-nav me-right">
                    <li class="nav-item">
                        <a class="nav-link" href="#!" data-bs-toggle="modal" data-bs-target="#profile-model"> <span class="fa fa-user-circle"></span> <%= user.getName()%> </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="LogoutServlet"> <span class="fa fa-user-plus"></span> Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!--end navbar-->

    <!--main content of body-->

    <div class="container">
        <div class="row my-4">
            <div class="col-md-8 offset-md-2">
                <div class="card">
                    <div class="card-header primary-background text-white">
                        <h3 class="post-title"><%= post.getpTitle()%></h3>
                    </div>
                    <div class="card-body">
                        <img src="blog_pics/<%= post.getpPic()%>" class="mb-3 card-img-top" alt="...">
                        <div class="row my-3 row-user">
                            <div class="col-md-8">
                                <% UserDao ud = new UserDao(ConnectionProvider.getConnection());%>
                                <p class="post-user-info"><a href="#!" style="text-decoration: none;"> <%= ud.getUserByUserId(post.getUserId()).getName()%> </a> has posted: </p>
                            </div>
                            <div class="col-md-4">
                                <p class="post-date"><%= post.getpDate().toLocaleString()%></p>
                            </div>
                        </div>                            
                        <p class="post-content mb-3"><%= post.getpContent()%></p>
                        <div class="post-code">
                            <pre><%= post.getpCode()%></pre>
                        </div>
                    </div>
                    <div class="card-footer primary-background">

                        <%
                            LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
                        %>

                        <a href="#!" onclick="doLike(<%= post.getPid()%>,<%= user.getId()%>)" class="btn btn-outline-light btn-sm"><i class="bi bi-hand-thumbs-up"></i><span class="like-counter"><%= ld.countLikeOnPost(post.getPid())%></span></a>
                        <a href="#!" class="btn btn-outline-light btn-sm"><i class="bi bi-chat-dots"></i> <span>20</span></a>
                    </div>
                    <div class="card-footer primary-background">
                        <div class="fb-comments" data-href="http://localhost:2525/TechBlog/show_blog_page.jsp?post_id=<%= post.getPid()%>" data-width="" data-numposts="5"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <!--end of main content of body-->

    <!--start profile model-->

    <!-- Modal -->
    <div class="modal fade" id="profile-model" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header primary-background text-white">
                    <h5 class="modal-title" id="exampleModalLabel">Tech Soft</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="container text-center">
                        <img src="pics/<%= user.getProfile()%>" class="img-fluid mb-3" style="border-radius: 50%; max-width: 150px">
                        <h5 class="modal-title mb-3" id="exampleModalLabel"> <%= user.getName()%> </h5>

                        <!--Details-->
                        <div id="profile-details">
                            <table class="table">
                                <tbody>
                                    <tr>
                                        <th scope="row"> ID </th>
                                        <th> : </th>
                                        <td> <%= user.getId()%> </td>
                                    </tr>
                                    </tr>
                                <th scope="row"> Email </th>
                                <th> : </th>
                                <td> <%= user.getEmail()%> </td>
                                </tr>
                                <tr>
                                    <th scope="row"> Gender </th>
                                    <th> : </th>
                                    <td> <%= user.getGender()%> </td>
                                </tr>
                                <tr>
                                    <th scope="row"> Status </th>
                                    <th> : </th>
                                    <td> <%= user.getAbout()%> </td>
                                </tr>
                                <tr>
                                    <th scope="row"> Registered on </th>
                                    <th> : </th>
                                    <td> <%= user.getDateTime()%> </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>

                        <!--profile edit-->

                        <div id="profile-edit" style="display: none">
                            <h3>Please Edit Carefully</h3>
                            <form action="EditServlet" method="post" enctype="multipart/form-data">
                                <table class="table">
                                    <tr>
                                        <th> ID </th>
                                        <th> : </th>
                                        <th> <%= user.getId()%> </th>
                                    </tr>
                                    <tr>
                                        <th> Name </th>
                                        <th> : </th>
                                        <td> <input name="user_name" type="text" class="form-control" value="<%= user.getName()%>"></td>
                                    </tr>
                                    <tr>
                                        <th> Email </th>
                                        <th> : </th>
                                        <td> <input name="user_email" type="email" class="form-control" value="<%= user.getEmail()%>"></td>
                                    </tr>
                                    <tr>
                                        <th> Password </th>
                                        <th> : </th>
                                        <td> <input name="user_password" type="password" class="form-control" value="<%= user.getPassword()%>"></td>
                                    </tr>
                                    <tr>
                                        <th> About </th>
                                        <th> : </th>
                                        <td> <textarea name="user_about" class="form-control" rows="3"> <%= user.getAbout()%> </textarea> </td>
                                    </tr>
                                    <tr>
                                        <th> New Profile</th>
                                        <th> : </th>
                                        <td> <input type="file" class="form-control" name="image" ></td>
                                    </tr>
                                </table>
                                <div class="container">
                                    <button type="submit" class="btn btn-outline-primary">Save</button>
                                </div>
                            </form>
                        </div>

                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button id="edit-profile-button" type="button" class="btn btn-primary">Edit</button>
                </div>
            </div>
        </div>
    </div>

    <!--end profile model-->


    <!--start Post Model-->

    <!-- Modal -->
    <div class="modal fade" id="post-model" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Provide the post detail</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="add-post-form" action="AddPostServlet" method="post">
                        <div class="mb-2">
                            <select class="form-control" name="cid">
                                <option selected disabled>---Select Categories---</option>

                                <%
                                    PostDao postd = new PostDao(ConnectionProvider.getConnection());
                                    ArrayList<Categories> list = postd.getAllCategories();
                                    for (Categories c : list) {

                                %>

                                <option value="<%= c.getCid()%>"> <%= c.getName()%> </option>

                                <%                                        }
                                %>

                            </select>
                        </div>
                        <div class="mb-2">
                            <input name="pTitle" type="text" placeholder="Enter Post Title" class="form-control"/>
                        </div>
                        <div class="mb-2">
                            <textarea name="pContent" class="form-control" placeholder="Enter your content" style="height: 150px"></textarea>
                        </div>
                        <div class="mb-2">
                            <textarea name="pCode" class="form-control" placeholder="Enter your code (if any)" style="height: 150px"></textarea>
                        </div>
                        <div class="mb-2">
                            <label>Select your pic</label>
                            <br>
                            <input type="file" name="pic" class="form-control"/>
                        </div>
                        <div class="container text-center">
                            <button type="submit" class="btn btn-lg btn-outline-primary">Post</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!--end Post Model-->



    <!--JavaScript-->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js" integrity="sha256-oP6HI9z1XaZNBrJURtCoUT5SUnxFr8s3BzRl+cbzUq8=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script src="js/myJavaScript.js" type="text/javascript"></script>

    <script>
                            $(document).ready(function () {
                                let editStatus = false;
                                $('#edit-profile-button').click(function () {
                                    if (editStatus == false) {
                                        $("#profile-details").hide();
                                        $("#profile-edit").show();
                                        editStatus = true;
                                        $(this).text("Done");
                                    } else {
                                        $("#profile-details").show();
                                        $("#profile-edit").hide();
                                        editStatus = false;
                                        $(this).text("Edit");
                                    }
                                });
                            });
    </script>

    <!--add post-->

    <script>
        $(document).ready(function (e) {
            //
            $("#add-post-form").on("submit", function (event) {
                event.preventDefault();
                console.log("clicked")
                let form = new FormData(this);
                $.ajax({
                    url: "AddPostServlet",
                    type: 'POST',
                    data: form,
                    success: function (data, textStatus, jqXHR) {
                        console.log(data);
                        if (data.trim() == 'done') {
                            swal("Good job!", "Save Successfully", "success");
                        } else {
                            swal("Error!!", "Something went wrong try again...", "error");
                        }

                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        swal("Error!!", "Something went wrong try again...", "error");
                    },
                    processData: false,
                    contentType: false
                })
            })
        })
    </script>

</body>
</html>
