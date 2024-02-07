package application;

import static org.junit.Assert.*;

import org.junit.Test;

public class OrderIDTest {
	
	
	@Test
	public void setOrderIDTest() {
		Order testOrder = new Order();
		testOrder.setOrderID(777);
		assertEquals("Order Update worked", 777, testOrder.getOrderID());
	}
	
	
	
	
	
	//Pass and Fail for Order ID
}
