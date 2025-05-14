package com.controller;

public class Testing {
    public static void main(String[] args) throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        java.sql.Connection con = java.sql.DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/emp?useSSL=false&serverTimezone=UTC",
            "root",
            "root"
        );
        System.out.println("Connected: " + con);
        con.close();
    }
}
