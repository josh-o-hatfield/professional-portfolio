package application;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;

import javafx.scene.control.Button;

import javafx.scene.control.TextField;

import javafx.scene.control.Label;
import javafx.scene.control.Labeled;
import javafx.scene.layout.AnchorPane;

import javafx.scene.control.ChoiceBox;

public class NewCustomerController {
	@FXML
	private AnchorPane newCustomerPane;
	@FXML
	private Label customerNum;
	@FXML
	private TextField fullName;
	@FXML
	private TextField address;
	@FXML
	private TextField city;
	@FXML
	private ChoiceBox<String> state;
	@FXML
	private TextField zipCode;
	@FXML
	private TextField phoneNum;
	@FXML
	private Button addNewCustomerButton;
	@FXML
	private Button clearCustomerButton;
	@FXML
	private Button cancelNewCustomerButton;

	// controller for place order window
	private PlaceOrderController callingController;
	
	// accessor method for controller
	public void setController(PlaceOrderController c) {
		callingController = c;
	}
	
	// hide the NewCustomer window and return control to the PlaceOrder window
	@FXML
	private void cancelNewCustomer(ActionEvent event) {
		fullName.clear();
		
		address.clear();
		city.clear();
		state.setValue(null);
		zipCode.clear();
		
		phoneNum.clear();
		
		// hide additional window
		newCustomerPane.getScene().getWindow().hide();
	}
	
	// Clear the main order fields with both the Thneed parameters and customer selection
	@FXML
	private void clearCustomerFields(ActionEvent event) {		
		fullName.clear();
		
		address.clear();
		city.clear();
		state.setValue(null);
		zipCode.clear();
		
		phoneNum.clear();
	}
	
	public void setStateSelection() {
		// create an ObservableList containing state options and add to ChoiceBox	
		final ObservableList<String> states = FXCollections.observableArrayList("AL", "AK", "AZ", "AR", "CA", "CO", 
																				"CT", "DE", "FL", "GA", "HI", "ID", 
																				"IL", "IN", "IA", "KS", "KY", "LA", 
																				"MA", "MD", "ME", "MI", "MN", "MS", 
																				"MO", "MT", "NC", "ND", "NE", "NH", 
																				"NJ", "NM", "NV", "NY", "OH", "OK", 
																				"OR", "PA", "RI", "SC", "SD", "TN", 
																				"TX", "UT", "VA", "VT", "WA", "WV", 
																				"WI", "WY");
		// set the states in the ChoiceBox
		state.setItems(states);
		state.getSelectionModel().select(0);
	}
	
	
	
	@FXML
	private void addCustomer(ActionEvent event) {		
		//create a new instance of customer with related parameters
		//use the action event with the add customer button
		System.out.println("Submit clicked for add new cust. Here is the Customer.");
		
		Customer testCust = new Customer();
				
		String custName = fullName.getText().toString();
		testCust.setName(custName);
		
		String custAddy = address.getText().toString();
		testCust.setAddress(custAddy);
		
		String custCity = city.getText().toString();
		testCust.setCity(custCity);
		
		String custSt = state.getSelectionModel().getSelectedItem();
		testCust.setState(custSt);
		
		String custZip = zipCode.getText().toString();
		testCust.setZip(custZip);
		
		String custPhone = phoneNum.getText();
		testCust.setPhoneNumber(custPhone);
		
		System.out.println(testCust);
		
		
				
	}
	
}
