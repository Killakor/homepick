package com.teamproject.teamproject;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

public class MySQLConnectionTest {

	private static final String DRIVER = "com.mysql.jdbc.Driver";
	private static final String URL = "jdbc:log4jdbc:mysql://127.0.0.1:3306/team4?allowPublicKeyRetrieval=true&amp;useSSL=false&amp;serverTimezone=UTC";
	private static final String USER = "root";
	private static final String PW = "m1234";

	@Test
	public void testConnection() throws Exception {

		Class.forName(DRIVER);

		try (Connection con = DriverManager.getConnection(URL, USER, PW)) {
			System.out.println(con);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}