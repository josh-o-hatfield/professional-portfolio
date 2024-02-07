package application;

import static org.junit.Assert.*;

import java.util.ArrayList;

import org.junit.Test;

public class OrderThneedOrdersListTest {
	
	
	@Test
	public void setOrderIDTest() {
		Order testOrder = new Order();
		
		
		
		ArrayList<Object> myArrayList = new ArrayList<Object>();
		myArrayList.add(23);
		myArrayList.add(777);
		Customer testCust = new Customer( 777,  "Dr. Seuss",  "123 A St.",  "1234567890",  "Lake City", "IN",  "43214");
		
		myArrayList.add(testCust.getName());

		ArrayList<ArrayList<String>> middleList = new ArrayList<>();
		ArrayList<String> innerList1 = new ArrayList<>();
		innerList1.add("Medium");
		innerList1.add("5");
		innerList1.add("Blue");
		ArrayList<String> innerList2 = new ArrayList<>();
		innerList2.add("Large");
		innerList2.add("10");
		innerList2.add("Red");
		middleList.add(innerList1);
		middleList.add(innerList2);
		myArrayList.add(middleList);

		myArrayList.add("03-03-2023");
		myArrayList.add("04-23-2023");

	

		
		//testOrder.setThneeds(thneedOrders);
		assertEquals("Order Update worked", 777, testOrder.getOrderID());
	}
	
	
	
	
	
	//Pass and Fail for Order ID
}
