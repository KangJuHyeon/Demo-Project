package info.example.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import info.example.dto.UserDto;

public class UserDao {

	public static final int USER_JOIN_SUCCESS = 1;
	public static final int USER_JOIN_FAIL = -1;
	
	public static final int USER_LOGIN_SUCCESS = 1;
	public static final int USER_PASSWORD_NOTEQUAL = -2;
	public static final int USER_CHECK_IDNOTFOUND = -1;
	
	public static final int USER_CONFIRM_SUCCESS = 1;
	public static final int USER_CONFIRM_FAIL = -1;
	
	public static final int USER_UPDATE_SUCCESS = 1;
	
	public static UserDao instance = new UserDao();
	
	private UserDao() {
		
	}
	public static UserDao getInstance() {
		return instance;
	}
	
	public int insertUser(UserDto dto) {
		int ri = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql =
				"insert into users VALUES(?,?,?,?,?)";
		
		System.out.println("password:"+ dto.getPassword());
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPassword());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getPhone());
			pstmt.setString(5, dto.getEmail());
			pstmt.executeUpdate();
			ri = UserDao.USER_JOIN_SUCCESS;
		} 
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				if(pstmt != null)pstmt.close();
				if(con != null)con.close();
			}
			catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return ri;				
	}
	
	
	public int confirmId(String id) {
		int ri = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet set = null;
		String query = "SELECT id FROM users WHERE id = ?";
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, id);
			set = pstmt.executeQuery();
			if(set.next()) {
				ri = UserDao.USER_CONFIRM_SUCCESS;
			} else {
				ri = UserDao.USER_CONFIRM_FAIL;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(set !=null)set.close();
				if(pstmt !=null)pstmt.close();
				if(con !=null)con.close();
			} catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return ri;		
	}
	
	
	public int checkUser(String id, String password) {
		int ri = 0;
		String dbPw;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet set = null;
		String query = "select password from users where id = ?";
		
		try { 
			con = getConnection();
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, id);
			set = pstmt.executeQuery();
			
			if(set.next()) {
				dbPw = set.getString("password");
				if(dbPw.equals(password)) {
					ri = UserDao.USER_LOGIN_SUCCESS;
				} else {
					ri = UserDao.USER_PASSWORD_NOTEQUAL;
				} } else {
					ri = UserDao.USER_CHECK_IDNOTFOUND;
				}
			
			} catch (Exception e){
				e.printStackTrace();
			} finally {
				try {
					if(set !=null)set.close();
					if(pstmt !=null)pstmt.close();
					if(con !=null)con.close();
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
		return ri;
		}
	
	
	public UserDto getUser(String id) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet set = null;
		String query = "select * from users where id = ?";
		UserDto dto = null;
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, id);
			set = pstmt.executeQuery();
			
			if(set.next()) {
				dto = new UserDto();
				dto.setId(set.getString("id"));
				dto.setPassword(set.getString("password"));
				dto.setName(set.getString("name"));
				dto.setPhone(set.getString("phone"));
				dto.setEmail(set.getString("email"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(set !=null)set.close();
				if(pstmt !=null)pstmt.close();
				if(con !=null)con.close();
			} catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return dto;
	}
	
	public int updateUser(UserDto dto) {
		int ri = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		String query = "update users set password=?, name=?, phone=?, email = ?"
				+ "where id = ?";
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,  dto.getPassword());
			pstmt.setString(2,  dto.getName());
			pstmt.setString(3,  dto.getPhone());
			pstmt.setString(4,  dto.getEmail());
			
			pstmt.executeUpdate();
			ri = UserDao.USER_UPDATE_SUCCESS;			
		}
		catch (Exception e) { 
			e.printStackTrace();
		}
		finally { 
			try {
				if(pstmt !=null)pstmt.close();
				if(con !=null)con.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return ri;
	}
	Connection getConnection() {
		Connection con = null;
		DataSource dataSource = null;
		Context context = null;
		try {
			context = new InitialContext();
			dataSource = (DataSource)context.lookup("java:comp/env/jdbc/Oracle11g");
			con = dataSource.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return con;
	}
}
