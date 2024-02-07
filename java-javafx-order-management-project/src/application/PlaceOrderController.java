package application;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.ToggleGroup;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Stage;
import javafx.scene.control.Slider;
import javafx.scene.control.TableView;
import javafx.scene.control.TableColumn;
import javafx.scene.control.Label;
import javafx.scene.control.RadioButton;
import javafx.scene.control.DatePicker;
import javafx.scene.control.ChoiceBox;

public class PlaceOrderController {
	@FXML
	private AnchorPane orderPane;
	
	@FXML
	private Label defineOrderNum;
	
	@FXML
	private ChoiceBox<String> colorSelection;
	
	@FXML
	private RadioButton smallSize;
	@FXML
	private ToggleGroup sizeSelection;
	@FXML
	private RadioButton mediumSize;
	@FXML
	private RadioButton largeSize;
	
	@FXML
	private Slider quantitySelection;
	
	@FXML
	private ChoiceBox<String> customerSelection;
	
	
	@FXML
	private Button newCustomerButton;
	
	@FXML
	private DatePicker newOrderDate;
	@FXML
	private DatePicker newFilledDate;
	
	@FXML
	private Label notification;
	
	@FXML
	private Button addToOrderButton;
	@FXML
	private Button clearEntryButton;
	
	@FXML
	private ChoiceBox<String> colorSelectionOptional;
	
	
	@FXML
	private RadioButton smallSizeOptional;
	@FXML
	private ToggleGroup sizeSelectionOptional;
	@FXML
	private RadioButton mediumSizeOptional;
	@FXML
	private RadioButton largeSizeOptional;
	
	@FXML
	private Slider quantitySelectionOptional;
	
	@FXML
	private Button addToOrderButtonOptional;
	@FXML
	private Button clearEntryOptional;
	
	@FXML
	private TableView<Order> displayOrderDetails;
	@FXML
	private TableColumn<Order, String> tableColor;
	@FXML
	private TableColumn<Order, String> tableSize;
	@FXML
	private TableColumn<Order, Integer> tableQuantity;
	@FXML
	private Label displayOrderNum;
	@FXML
	private Label displayCustomerName;
	@FXML
	private Label displayOrderDate;
	@FXML
	private Label displayFilledDate;
	
	@FXML
	private Button finishOrderButton;
	@FXML
	private Button cancelOrderButton;

	// controller for main order window
	private MainOrderWindowController callingController;
	
	// accessor method for controller
	public void setController(MainOrderWindowController c) {
		callingController = c;
	}
	
	// variable for the stage of the PlaceOrder.fxml page
	private Stage newCustomerStage;
	private NewCustomerController controller;
	
	// used to store Thneed order information and populate the TableView
	private ObservableList<Order> thneedOrder = FXCollections.observableArrayList();
	
	@FXML
	public void defineOrderNum() {
		
	}
	
	// Add new customer entry button action
	@FXML
	private void addNewCustomer(ActionEvent event) {		
		// create the NewCustomer window if 'New Customer' button is clicked for the first time
		if (newCustomerStage == null) {
			// get FXML loader and read in NewCustomer.fxml code
			FXMLLoader loader = new FXMLLoader(getClass().getResource("/NewCustomer.fxml"));
			AnchorPane newCustomerPane;
			
			try {
				// establish NewCustomer.fmxl pane
				newCustomerPane = (AnchorPane)loader.load();
				// create new scene based on the pane
				Scene newCustomerScene = new Scene(newCustomerPane);
				// create new stage
				newCustomerStage = new Stage();
				// set the scene to newCustomerScene
				newCustomerStage.setScene(newCustomerScene);
				
				// set place order window title
				newCustomerStage.setTitle("Add New Customer");
				
				// load controller
				controller = (NewCustomerController) loader.getController();
				
				// set the state choices for the ChoiceBox on NewCustomer.fxml
				controller.setStateSelection();
				
				// set controller
				controller.setController(this);
				
			}
			// catch any errors
			catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		// show stage of order summary window
		newCustomerStage.show();
	}
	
	public void setColorSelection() {
		// create an ObservableList containing color options and add to ChoiceBox	
		final ObservableList<String> colors = FXCollections.observableArrayList("Green", "Red", "Blue", "Orange", "Purple", "Black", "White", "Grey");
		colorSelection.setItems(colors);
		colorSelection.getSelectionModel().select(0);
		
		// set the states in the ChoiceBox
		colorSelectionOptional.setItems(colors);
		colorSelectionOptional.getSelectionModel().select(0);
	}
	
	public void setCustomerSelection() {
		// create an ObservableList containing color options and add to ChoiceBox	
		// final ObservableList<String> colors = FXCollections.observableArrayList("Green", "Red", "Blue", "Orange", "Purple", "Black", "White", "Grey");
		// colorSelection.setItems(colors);
		// colorSelection.getSelectionModel().select(0);
		
		Customer testCust1 = new Customer( 777,  "Dr. Seuss",  "123 A St.",  "1234567890",  "Lake City", "IN",  "43214");
		Customer testCust2 = new Customer( 234,  "John",  "123 A St.",  "0987654321",  "Lake City", "IN",  "43214");
		Customer testCust3 = new Customer( 373,  "Aden",  "123 A St.",  "1092837465",  "Lake City", "IN",  "43214");
		
		String cust1name = testCust1.getName();
		String cust2name = testCust2.getName();
		String cust3name = testCust3.getName();
		
		final ObservableList<String> customers = FXCollections.observableArrayList(cust1name, cust2name, cust3name);
		//final ObservableList<String> customers = FXCollections.observableArrayList(testCust1.getName().toString(),testCust2.getName().toString(),testCust3.getName().toString());
		customerSelection.setItems(customers);
		customerSelection.getSelectionModel().select(0);
		
	
		
	}
	
	// ArrayList for order information to store and append to the predetermined CSV file
	ArrayList<Order> order = new ArrayList<>();
	
	// Add the main parameters of the Thneed order, which should populate in the right
	// box under order information
	@SuppressWarnings("unchecked")
	@FXML
	private void addToOrder(ActionEvent event) {
		try {
			// grabs the color item in the ChoiceBox selected by the user
			String color = colorSelection.getSelectionModel().getSelectedItem();
			
			// grabs the Thneed size from the ToggleGroup of radio buttons selected by the user
			String size = ((RadioButton) sizeSelection.getSelectedToggle()).getText();
			
			// grabs the quantity integer from the slider selected by the user
			double quantitySelect = quantitySelection.getValue();
			int quantity = (int) quantitySelect;
			
			// grabs the customer item in the ChoiceBox selected by the user
			String customer = customerSelection.getSelectionModel().getSelectedItem();
			
			// grabs the order date selected by the user
			LocalDate orderDateSelect = newOrderDate.getValue();
			// needed for reformatting and converting to String in relation to the corresponding
			// label
			final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/dd/yyyy");
			// orderDate converted to String with the specified format
			String orderDate = formatter.format(orderDateSelect);
			
			// grabs the order date selected by the user
			LocalDate filledDateSelect = newFilledDate.getValue();
			// filledDate converted to String with the specified format
			String filledDate = formatter.format(filledDateSelect);
			
			// -----------------------------------------------------------------------
			// sets the order information on the right box to the information selected
			// by the user; will not display if user has not filled out all of the information
			
			displayOrderNum.setText(defineOrderNum.getText());
			
			// resets main order information with new information updated by user
			if (thneedOrder.size() >= 1) {
				thneedOrder.set(0, new Order(color, size, quantity));
			}
			// else, add the main order information
			else {
				thneedOrder.add(new Order(color, size, quantity));
			}
			
			// populates TableView with values
			tableColor.setCellValueFactory(new PropertyValueFactory<Order,String>("color"));
			tableSize.setCellValueFactory(new PropertyValueFactory<Order,String>("size"));
			tableQuantity.setCellValueFactory(new PropertyValueFactory<Order, Integer>("quantity"));
			
			// sets the TableView items and other order information labels' text
			displayOrderDetails.setItems(thneedOrder);
			displayCustomerName.setText(customer);
			displayOrderDate.setText(orderDate);
			displayFilledDate.setText(filledDate);
		}
		// conditions if all the input fields have not yet been filled
		catch (NullPointerException i) {
			// prints to the console if some mandatory information has not yet been filled
			System.out.println("You must fill in all the input fields.");
			
			// sets a red label below the order information indicating that the
			// order information has not yet been completely filled
			notification.setText("You must fill out all mandatory order information before adding to the order.");
		}
	}
	
	// Add the optional parameters of the Thneed order, which should add in the right
	// box under order information; should not overwrite main order information
	@FXML
	private void addToOrderOptional(ActionEvent event) {
		try {
			// grabs the color item in the ChoiceBox selected by the user
			String color = colorSelectionOptional.getSelectionModel().getSelectedItem();
			
			// grabs the Thneed size from the ToggleGroup of radio buttons selected by the user
			String size = ((RadioButton) sizeSelectionOptional.getSelectedToggle()).getText();
			
			// grabs the quantity integer from the slider selected by the user
			double quantitySelect = quantitySelectionOptional.getValue();
			int quantity = (int) quantitySelect;
			
			// sets the order information on the right box to the information selected
			// by the user; will not display if user has not filled out all of the information
			if (thneedOrder.size() == 0) {
				notification.setText("Set the initial Thneed color, size, and quantity first before adding additional Thneeds to the order.");
			}
			else {
				thneedOrder.add(new Order(color, size, quantity));
				notification.setText("");
			}
			
			// populates TableView with additional values
			tableColor.setCellValueFactory(new PropertyValueFactory<Order,String>("color"));
			tableSize.setCellValueFactory(new PropertyValueFactory<Order,String>("size"));
			tableQuantity.setCellValueFactory(new PropertyValueFactory<Order, Integer>("quantity"));
			
			// sets the TableView items and other order information labels' text
			displayOrderDetails.setItems(thneedOrder);
		}
		// conditions if all the input fields have not yet been filled
		catch (NullPointerException e) {
			// prints to the console if some mandatory information has not yet been filled
			System.out.println("You must fill in all the input fields.");
			
			// sets a red label below the order information indicating that the
			// order information has not yet been completely filled
			notification.setText("You must specify the color, size, and quantity for adding additional Thneeds.");
		}
		// resets optional fields
		finally {
			// set this back to the first list item rather than null
			colorSelectionOptional.getSelectionModel().select(0);
			
			smallSizeOptional.setSelected(true);
			mediumSizeOptional.setSelected(false);
			largeSizeOptional.setSelected(false);
			
			quantitySelectionOptional.setValue(1);
		}
	}
	
	// Clear the main order fields with both the Thneed parameters and customer selection
	@FXML
	private void clearMainOrderFields(ActionEvent event) {		
		// set this back to the first list item rather than null
		colorSelection.getSelectionModel().select(0);
		
		smallSize.setSelected(true);
		mediumSize.setSelected(false);
		largeSize.setSelected(false);
		
		customerSelection.setValue(null);
		
		quantitySelection.setValue(1);
		
		newOrderDate.setValue(null);
		newFilledDate.setValue(null);
	}
	
	// Clear the optional order fields with the Thneed parameters at the bottom
	@FXML
	private void clearOptionalOrderFields(ActionEvent event) {
		// set this back to the first list item rather than null
		colorSelectionOptional.getSelectionModel().select(0);
		
		smallSizeOptional.setSelected(true);
		mediumSizeOptional.setSelected(false);
		largeSizeOptional.setSelected(false);
		
		quantitySelectionOptional.setValue(1);
	}
	
	// Clear the entire PlaceOrder.fxml page, including order information
	@FXML
	private void clearOrder(ActionEvent event) {
		// set this back to the first list item rather than null
		colorSelection.getSelectionModel().select(0);
		
		smallSize.setSelected(true);
		mediumSize.setSelected(false);
		largeSize.setSelected(false);
		
		//customerSelection.setValue(null);
		
		quantitySelection.setValue(1);
		
		newOrderDate.setValue(null);
		newFilledDate.setValue(null);
		
		// set this back to the first list item rather than null
		colorSelectionOptional.getSelectionModel().select(0);
		
		smallSizeOptional.setSelected(false);
		mediumSizeOptional.setSelected(false);
		largeSizeOptional.setSelected(false);
		
		quantitySelectionOptional.setValue(1);
		
		// clears table and associated ObservableList entirely
		displayOrderDetails.getItems().clear();
		thneedOrder.clear();
		
		// clears labels
		displayCustomerName.setText("");
		displayOrderDate.setText("");
		displayFilledDate.setText("");
	}
	
	// Clear the entire PlaceOrder.fxml page, including order information;
	// append to the CSV file if all the order information exists
	@FXML
	private void confirmOrder(ActionEvent event) {
		try {
			// code for appending new order to CSV file here
			
		}
		catch (Exception e) {
			System.out.println("The application could not save the order information due to empty input fields.");
		}
		finally {
			// set this back to the first list item rather than null
			colorSelection.getSelectionModel().select(0);
			
			smallSize.setSelected(true);
			mediumSize.setSelected(false);
			largeSize.setSelected(false);
			
			customerSelection.setValue(null);
			
			quantitySelection.setValue(1);
			
			newOrderDate.setValue(null);
			newFilledDate.setValue(null);
			
			// set this back to the first list item rather than null
			colorSelectionOptional.getSelectionModel().select(0);
			
			smallSizeOptional.setSelected(false);
			mediumSizeOptional.setSelected(false);
			largeSizeOptional.setSelected(false);
			
			quantitySelectionOptional.setValue(1);
			
			// clears table and associated ObservableList entirely
			displayOrderDetails.getItems().clear();
			thneedOrder.clear();
			
			// clears labels
			displayCustomerName.setText("");
			displayOrderDate.setText("");
			displayFilledDate.setText("");
			
			// hides window after confirmation
			orderPane.getScene().getWindow().hide();
		}
	}
	
	// Clear the entire PlaceOrder.fxml page, including order information;
	// append to the CSV file if all the order information exists
	@FXML
	public void closeWindow() {
		try {
			// code for appending new order to CSV file here
			
		}
		catch (Exception e) {
			System.out.println("The application could not save the order information due to empty input fields.");
		}
		finally {
			// set this back to the first list item rather than null
			colorSelection.getSelectionModel().select(0);
			
			smallSize.setSelected(true);
			mediumSize.setSelected(false);
			largeSize.setSelected(false);
			
			customerSelection.setValue(null);
			
			quantitySelection.setValue(1);
			
			newOrderDate.setValue(null);
			newFilledDate.setValue(null);
			
			// set this back to the first list item rather than null
			colorSelectionOptional.getSelectionModel().select(0);
			
			smallSizeOptional.setSelected(false);
			mediumSizeOptional.setSelected(false);
			largeSizeOptional.setSelected(false);
			
			quantitySelectionOptional.setValue(1);
			
			// clears table and associated ObservableList entirely
			displayOrderDetails.getItems().clear();
			thneedOrder.clear();
			
			// clears labels
			displayCustomerName.setText("");
			displayOrderDate.setText("");
			displayFilledDate.setText("");
		}
	}
	
}
