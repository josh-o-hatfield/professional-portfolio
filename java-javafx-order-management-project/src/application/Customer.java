package application;

public class Customer {
	// private variable parameters of the Customer class
    private int id;
    private String name;
    private String address;
    private String phoneNumber;
    // Added on top of address
    private String city;
    private String state;
    private String zip;
    
    // no-arg constructor
    public Customer() {
    }
    
    // constructor with variables initialized
    public Customer(int id, String name, String address, String phoneNumber, String city, String state, String zip) {
        this.id = id;
        this.name = name;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.city = city;
        this.state = state;
        this.zip = zip;
    }
    
    // getter method for customer ID
    public int getId() {
        return id;
    }
    
    // setter method for customer ID
    public void setId(int id) {
        this.id = id;
    }
    
    // getter method for customer name
    public String getName() {
        return name;
    }
    
    // setter method for customer name
    public void setName(String name) {
        this.name = name;
    }
    
    // getter method for customer address
    public String getAddress() {
        return address;
    }

    // setter method for customer address
    public void setAddress(String address) {
        this.address = address;
    }
    
    // getter method for customer city
    public String getCity() {
    	return city;
    }
    
    // setter method for customer city
    public void setCity(String city) {
    	this.city = city;
    }
    
    // getter method for customer state
    public String getState() {
    	return state;
    }
    
    // setter method for customer state
    public void setState(String state) {
    	this.state = state;
    }
    
    // getter method for customer zipcode
    public String getZip() {
    	return zip;
    }
    
    // setter method for customer zipcode
    public void setZip(String zip) {
    	this.zip = zip;
    }
    
    // getter method for customer phone number
    public String getPhoneNumber() {
        return phoneNumber;
    }
    
    // setter method for customer phone number
    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }
    
    @Override
	public String toString() {
		// testing if an order correctly displays information using toString
		String customer = "Customer ID: " + this.getId() + ", Name: " + this.getName() + ", Address: " + this.getAddress() + ", City: " + this.getCity() + ", State: " + this.getState() + ", Zip Code: " + this.getZip() + ", Phone Number: " + this.getPhoneNumber();
		return customer;
	}
	
}
