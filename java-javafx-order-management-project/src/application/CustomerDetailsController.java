package application;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;

import javafx.scene.control.Button;

import javafx.scene.control.Label;

import javafx.scene.layout.AnchorPane;

public class CustomerDetailsController {
	@FXML
	private AnchorPane viewCustomerPane;
	@FXML
	private Label viewCustomerNum;
	@FXML
	private Label viewCustomerName;
	@FXML
	private Label viewAddress;
	@FXML
	private Label viewCity;
	@FXML
	private Label viewZipCode;
	@FXML
	private Label viewState;
	@FXML
	private Label viewPhoneNumber;
	@FXML
	private Button backButton;

	// controller for place order window
	private MainOrderWindowController callingController;
	
	// accessor method for controller
	public void setController(MainOrderWindowController c) {
		callingController = c;
	}
	
	// hide the NewCustomer window and return control to the PlaceOrder window
	@FXML
	void closeCustomerDetails(ActionEvent event) {
		// hide additional window
		viewCustomerPane.getScene().getWindow().hide();
	}
}
