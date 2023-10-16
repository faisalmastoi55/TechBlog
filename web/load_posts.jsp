<%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.entities.Posts"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<div class="row">

    <%
        
        User users = (User)session.getAttribute("currentUser");
        
        Thread.sleep(1000);
        PostDao d = new PostDao(ConnectionProvider.getConnection());

        int cid = Integer.parseInt(request.getParameter("cid"));
        List<Posts> posts = null;

        if (cid == 0) {
            posts = d.getAllPosts();
        }else{
            posts = d.getPostByCatId(cid);
        }
        
        if(posts.size()==0){
            out.println("<h3 class='display-2 text-center'>No Posts in this category.. </h3>");
            return;
        }

        for (Posts p : posts) {
    %>

    <div class="col-md-6 mt-3">
        <div class="card">
            <img src="blog_pics/<%= p.getpPic()%>" class="card-img-top" alt="...">
            <div class="card-body">
                <b> <%= p.getpTitle()%> </b>
                <p> <%= p.getpContent()%> </p>
            </div>
            <div class="card-footer primary-background text-center">
                
                <% 
                    LikeDao ldao = new LikeDao(ConnectionProvider.getConnection());
                %>
                
                <a href="#!" onclick="doLike(<%= p.getPid() %>,<%= users.getId() %>)" class="btn btn-outline-light btn-sm"><i class="bi bi-hand-thumbs-up"></i><span class="like-counter"><%= ldao.countLikeOnPost(p.getPid()) %></span></a>
                <a href="show_blog_page.jsp?post_id=<%= p.getPid() %>" class="btn btn-outline-light btn-sm">Read more...</a>
                <a href="#!" class="btn btn-outline-light btn-sm"><i class="bi bi-chat-dots"></i> <span>20</span></a>
            </div>
        </div>
    </div>


    <%
        }
    %>

</div>