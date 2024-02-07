package application;

import static org.junit.Assert.*;
import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class CustomerTest {
	
	//Complete Customer Testing
	
	@Test
	public void setIDTest(){
		Customer testCust = new Customer( 777,  "Dr. Seuss",  "123 A St.",  "1234567890",  "Lake City", "IN",  "43214");
		assertEquals("Customer ID Update worked", 777, testCust.getId());
	}
	
	@Test
	public void setNameTest(){
		Customer testCust = new Customer( 777,  "Dr. Seuss",  "123 A St.",  "1234567890",  "Lake City", "IN",  "43214");
		assertEquals("Customer Name Update worked", "Dr. Seuss", testCust.getName());
	}
	
	@Test
	public void setAddressTest(){
		Customer testCust = new Customer( 777,  "Dr. Seuss",  "123 A St.",  "1234567890",  "Lake City", "IN",  "43214");
		assertEquals("Customer Address Update worked", "123 A St.", testCust.getAddress());
	}
	
	@Test
	public void setPhoneNumTest(){
		Customer testCust = new Customer( 777,  "Dr. Seuss",  "123 A St.",  "1234567890",  "Lake City", "IN",  "43214");
		assertEquals("Customer Phone # Update worked", "1234567890", testCust.getPhoneNumber());
	}
	
	@Test
	public void setCityTest(){
		Customer testCust = new Customer( 777,  "Dr. Seuss",  "123 A St.",  "1234567890",  "Lake City", "IN",  "43214");
		assertEquals("Customer City Update worked", "Lake City", testCust.getCity());
	}
	
	
	@Test
	public void setStateTest(){
		Customer testCust = new Customer( 777,  "Dr. Seuss",  "123 A St.",  "1234567890",  "Lake City", "IN",  "43214");
		assertEquals("Customer State Update worked", "IN", testCust.getState());
	}
	@Test
	public void setZipTest(){
		Customer testCust = new Customer( 777,  "Dr. Seuss",  "123 A St.",  "1234567890",  "Lake City", "IN",  "43214");
		assertEquals("Customer Zip Update worked", "43214", testCust.getZip());
	}
	
	
	
	//Complete Customer Testing
}
