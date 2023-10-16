package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LikeDao {

    Connection con;

    public LikeDao(Connection con) {
        this.con = con;
    }

    public boolean insertLike(int pid, int uid) {
        boolean f = false;
        try {
            String query = "insert into likes (pid,uid) values(?,?)";
            PreparedStatement pstmt = this.con.prepareStatement(query);

//            values set
            pstmt.setInt(1, pid);
            pstmt.setInt(2, uid);
            pstmt.executeUpdate();

            f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }

    public int countLikeOnPost(int pid) {
        int count = 0;

        String query = "select count(*) from likes where pid=?";

        try {
            PreparedStatement pst = this.con.prepareStatement(query);
            pst.setInt(1, pid);

            ResultSet set = pst.executeQuery();

            if (set.next()) {
                count = set.getInt("count(*)");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    public boolean isLikesByUser(int pid, int uid) {
        boolean f = false;

        try {

            PreparedStatement pst = this.con.prepareStatement("select * from likes where pid=? and uid=?");

            pst.setInt(1, pid);
            pst.setInt(2, uid);

            ResultSet set = pst.executeQuery();

            if (set.next()) {
                f = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }
    
    public boolean deleteLike(int pid, int uid){
        boolean f= false;
        
        try {
            
            PreparedStatement pst = this.con.prepareStatement("delete from likes where pid=? and uid=?");
            
            pst.setInt(1, pid);
            pst.setInt(2, uid);
            
            pst.executeUpdate();
            
            f=true;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return f;
    }

}
