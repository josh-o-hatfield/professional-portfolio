package application;

import java.util.ArrayList;
import java.util.Date;

import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleStringProperty;

public class Order {
	// private variable parameters of the Order class
	private int orderID;

	// needed for the order information to ascertain the customer
	private int customerID;
	private String customerName;
	
	// three-dimensional ArrayList with 1) quantity 2) size 3) color
	private ArrayList<ArrayList<ArrayList<String>>> thneedOrders = new ArrayList<>();
	private SimpleStringProperty color;
	private SimpleStringProperty size;
	private SimpleIntegerProperty quantity;
	private Date orderDate;
	private Date orderFillDate;
	
	// used for the TableView on the main page
	private SimpleIntegerProperty tableOrderID;
	private SimpleStringProperty tableCustomerName;
	private SimpleStringProperty tableOrderDate;
	private SimpleStringProperty tableFilledDate;
	
	// alternative if ArrayList does not work for thneedOrders
	// private List<String> list;

	// no-arg constructor
	public Order() {
	}

	// constructor with variables initialized
	public Order(int orderID, int customerID, String customerName, ArrayList<ArrayList<ArrayList<String>>> thneedOrders, Date orderDate, Date orderFillDate) {
		this.orderID = orderID;
		this.customerID = customerID;
		this.customerName = customerName;
		this.thneedOrders = thneedOrders;
		this.orderDate = orderDate;
		this.orderFillDate = orderFillDate;
		
		// this.list = list;
	}
	
	// constructor with only color, size, and quantity variables initialized
	// (used with Thneed orders of varying Thneeds)
	public Order(String color, String size, int quantity) {
		this.color = new SimpleStringProperty(color);
		this.size = new SimpleStringProperty(size);
		this.quantity = new SimpleIntegerProperty(quantity);
	}
	
	// constructor with order number, customer name, order date, and filled date variables
	// initialized (used on the main window with table for unfilled and filled orders)
	public Order(int tableOrderID, String tableCustomerName, String tableOrderDate, String tableFilledDate) {
		this.tableOrderID = new SimpleIntegerProperty(tableOrderID);
		this.tableCustomerName = new SimpleStringProperty(tableCustomerName);
		this.tableOrderDate = new SimpleStringProperty(tableOrderDate);
		this.tableFilledDate = new SimpleStringProperty(tableFilledDate);
	}
	
	// getter method for order ID
	public int getOrderID() {
		return orderID;
	}
	
	// getter method for customer ID
	public int getCustomerID() {
		return customerID;
	}
	
	// getter method for customer ID
	public String getCustomerName() {
		return customerName;
	}
	
	// getter method for ArrayList containing the multiple Thneeds part of the same order
	public ArrayList<ArrayList<ArrayList<String>>> getThneeds() {
		// ArrayList of 1) quantity 2) size 3) color
		return thneedOrders;
	}
	
	// getter method for order number (MainOrderWindow.fxml TableView)
	public int getTableOrderID() {
		return tableOrderID.get();
	}
	
	// getter method for order number (MainOrderWindow.fxml TableView)
	public String getTableCustomerName() {
		return tableCustomerName.get();
	}
	
	// getter method for order number (MainOrderWindow.fxml TableView)
	public String getTableOrderDate() {
		return tableOrderDate.get();
	}
	
	// getter method for order number (MainOrderWindow.fxml TableView)
	public String getTableFilledDate() {
		return tableFilledDate.get();
	}
	
	// getter method for order color (PlaceOrder.fxml and MainOrderWindow.fxml TableView)
	public String getColor() {
		return color.get();
	}
	
	// getter method for order color (PlaceOrder.fxml and MainOrderWindow.fxml TableView)
	public String getSize() {
		return size.get();
	}
	
	// getter method for order color (PlaceOrder.fxml and MainOrderWindow.fxml TableView)
	public int getQuantity() {
		return quantity.get();
	}
	
	// alternative if ArrayList does not work for thneedOrders
	//	public List<String> getThneeds(){
	//		return list;
	//	}
	
	// getter method for order date
	public Date getOrderDate() {
		return orderDate;
	}
	
	// getter method for filled date
	public Date getOrderFillDate() {
		return orderFillDate;
	}
	
	// setter method for order ID
	public void setOrderID(int orderID) {
		this.orderID = orderID;
	}
	
	// setter method for customer ID
	public void setCustomerID(int customerID) {
		this.customerID = customerID;
	}
	
	// setter method for customer name
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	
	// setter method for ArrayList containing the multiple Thneeds part of the same order
	public void setThneeds(ArrayList<ArrayList<ArrayList<String>>> thneedOrders) {
		this.thneedOrders = thneedOrders;
	}
	
	// setter method for order date
	public void setOrderDate(Date orderDate) {
		this.orderDate = new java.util.Date();
	}
	
	// setter method for filled date
	public void setOrderFillDate(Date orderFillDate) {
		this.orderFillDate = new java.util.Date();
	}
	
	@Override
	public String toString() {
		// testing if an order correctly displays information using toString
		String order = "Order ID: " + this.getOrderID() + ", Thneeds Order: " + this.getThneeds() + ", Order Date: " + this.getOrderDate() + ", Filled Date: " + this.getOrderFillDate();
		return order;
	}
	
}
