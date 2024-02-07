package application;

import static org.junit.Assert.*;
import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class CustomerNameTest {
	
	@Test
	public void setNameTest() {
		Customer testCust = new Customer();
		testCust.setName("Dr. Seuss");
		assertEquals("Customer Update worked", "Dr. Seuss", testCust.getName());
		
	}
	@Test
	public void setNameTest2(){
		Customer testCust = new Customer( 1,  "Dr. Seuss",  "123 A St.",  "123",  "Lake City", "IN",  "43214");
		assertEquals("Customer Update worked", "Dr. Seuss", testCust.getName());
	}
	
	
	// should fail (no space in Dr. Seuss)
	@Test
	public void setNameTestUnequal(){
		Customer testCust = new Customer( 1,  "Dr.Seuss",  "123 A St.",  "123",  "Lake City", "IN",  "43214");
		assertEquals("Customer Update worked", "Dr. Seuss", testCust.getName());
		System.out.println("test");
	}
	
	
	
	
	
	
	
	
	
	//Pass and Fail for Customer["name"]
}
