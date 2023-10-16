package com.tech.blog.dao;

import com.tech.blog.entities.Categories;
import com.tech.blog.entities.Posts;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.Part;

public class PostDao {

    Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }

    public ArrayList<Categories> getAllCategories() {

        ArrayList<Categories> list = new ArrayList<>();

        try {

            String query = "select * from categories ";
            Statement state = this.con.createStatement();
            ResultSet result = state.executeQuery(query);

            while (result.next()) {
                int cid = result.getInt("cid");
                String name = result.getString("name");
                String description = result.getString("description");

                Categories c = new Categories(cid, name, description);
                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;

    }

    public boolean savePost(Posts p) {
        boolean f = false;

        try {

            String query = "insert into posts(pTitle, pContent, pCode, pPic, cid, userId) values(?,?,?,?,?,?)";
            PreparedStatement pstmst = con.prepareStatement(query);
            
            pstmst.setString(1, p.getpTitle());
            pstmst.setString(2, p.getpContent());
            pstmst.setString(3, p.getpCode());
            pstmst.setString(4, p.getpPic());
            pstmst.setInt(5, p.getCid());
            pstmst.setInt(6, p.getUserId());
            
            pstmst.executeUpdate();
            
            f = true;
            
        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }
    
//    get All the Posts
    
    public List<Posts> getAllPosts(){
        
        List<Posts> list = new ArrayList<>();
//        fetch all the post

        try {
            
            PreparedStatement p = con.prepareStatement("select * from posts order by pid desc");
            ResultSet rs = p.executeQuery();
            
            while (rs.next()) {
                int pid = rs.getInt("pid");
                String pTitle = rs.getString("pTitle");
                String pContent = rs.getString("pContent");
                String pCode = rs.getString("pCode");
                String pPic = rs.getString("pPic");
                Timestamp date = rs.getTimestamp("pDate");
                int cid = rs.getInt("cid");
                int userId = rs.getInt("userId");
                
                Posts post = new Posts(pid, pTitle, pContent, pCode, pPic, date, cid, userId);
                list.add(post);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }


        return list;
    }
    
    public List<Posts> getPostByCatId(int cid){
        List<Posts> list = new ArrayList<>();
//        fetch all posts by id
        
         try {
            
            PreparedStatement p = con.prepareStatement("select * from posts where cid = ?");
            p.setInt(1, cid);
            ResultSet rs = p.executeQuery();
            
            while (rs.next()) {
                int pid = rs.getInt("pid");
                String pTitle = rs.getString("pTitle");
                String pContent = rs.getString("pContent");
                String pCode = rs.getString("pCode");
                String pPic = rs.getString("pPic");
                Timestamp date = rs.getTimestamp("pDate");
                int userId = rs.getInt("userId");
                
                Posts post = new Posts(pid, pTitle, pContent, pCode, pPic, date, cid, userId);
                list.add(post);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public Posts getPostByPostId(int postId){
        
        Posts post = null;
        
        String query = "select * from posts where pid=?";
        
        try {
            
            PreparedStatement p = con.prepareStatement(query);
            p.setInt(1, postId);
            
            ResultSet set = p.executeQuery();
            
            if(set.next()){
                int pid = set.getInt("pid");
                String pTitle = set.getString("pTitle");
                String pContent = set.getString("pContent");
                String pCode = set.getString("pCode");
                String pPic = set.getString("pPic");
                Timestamp date = set.getTimestamp("pDate");
                int cid = set.getInt("cid");
                int userId = set.getInt("userId");
                
                post = new Posts(pid, pTitle, pContent, pCode, pPic, date, cid, userId);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return post;
    }
}
