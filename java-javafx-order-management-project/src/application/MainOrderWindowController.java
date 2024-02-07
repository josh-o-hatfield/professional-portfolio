package application;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Collections;
import java.util.Comparator;
import java.util.Scanner;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.control.Button;

import javafx.scene.control.Label;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Stage;
import javafx.stage.WindowEvent;
import javafx.scene.control.DatePicker;

public class MainOrderWindowController {
	@FXML
	private AnchorPane mainPane;
	@FXML
	private TableView<Order> unfilledOrders;
	@FXML
	private TableColumn<Order, Integer> unfilledTableOrderID;
	@FXML
	private TableColumn<Order, String> unfilledTableCustomer;
	@FXML
	private TableColumn<Order, String> unfilledTableOrderDate;
	@FXML
	private TableColumn<Order, String> unfilledTableFilledDate;
	@FXML
	private Button addOrderButton;
	@FXML
	private TableView<Order> filledOrders;
	@FXML
	private TableColumn<Order, Integer> filledTableOrderID;
	@FXML
	private TableColumn<Order, String> filledTableCustomer;
	@FXML
	private TableColumn<Order, String> filledTableOrderDate;
	@FXML
	private TableColumn<Order, String> filledTableFilledDate;
	@FXML
	private Label orderNum;
	@FXML
	private Label customerName;
	@FXML
	private TableView<Order> orderDetails;
	@FXML
	private TableColumn<Order, String> tableColor;
	@FXML
	private TableColumn<Order, String> tableSize;
	@FXML
	private TableColumn<Order, String> tableQuantity;
	@FXML
	private Label orderDate;
	@FXML
	private DatePicker filledDate;
	@FXML
	private Button viewCustomerButton;
	@FXML
	private Button editFilledDateButton;

	// variables for the stage and controller of the PlaceOrder.fxml page
	private Stage placeOrderStage;
	private PlaceOrderController controller;
	
	// variables for the stage and controller of the CustomerDetails.fxml page
	private Stage customerDetailsStage;
	private CustomerDetailsController controller2;
	
	// used to store unfilled order information and populate the TableView
	private ObservableList<Order> unfilledOrdersList = FXCollections.observableArrayList();
	// used to store Thneed order information and populate the TableView
	private ObservableList<Order> filledOrdersList = FXCollections.observableArrayList();
	
	// Place new order entry button action
	@FXML
	private void addOrderNav(ActionEvent event) {		
		// create the PlaceOrder window if 'Add Order +' button is clicked for the first time
		if (placeOrderStage == null) {
			// get FXML loader and read in PlaceOrder.fxml code
			FXMLLoader loader = new FXMLLoader(getClass().getResource("/PlaceOrder.fxml"));
			AnchorPane placeOrderPane;
			
			try {
				// establish PlaceOrder.fmxl pane
				placeOrderPane = (AnchorPane)loader.load();
				// create new scene based on the pane
				Scene placeOrderScene = new Scene(placeOrderPane);
				// create new stage
				placeOrderStage = new Stage();
				// set the scene to placeOrderScene
				placeOrderStage.setScene(placeOrderScene);
				
				// set place order window title
				placeOrderStage.setTitle("Add New Order");
				
				// load controller
				controller = (PlaceOrderController) loader.getController();
				
				// set the color choices for the ChoiceBox on PlaceOrder.fxml
				controller.setColorSelection();
				// set the list of customers for the ChoiceBox on PlaceOrder.fxml
				controller.setCustomerSelection();
				
				// set controller
				controller.setController(this);
				
			}
			// catch any errors
			catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		// show stage of order summary window
		placeOrderStage.show();
		
		placeOrderStage.setOnCloseRequest(new EventHandler<WindowEvent>() {
			public void handle(WindowEvent we) {
				controller.closeWindow();
			}
		});
		
	}
	
	// Place new order entry button action
	@FXML
	private void viewCustomerDetails(ActionEvent event) {		
		// create the CustomerDetails window if 'View Customer' button is clicked for the first time
		if (customerDetailsStage == null) {
			// get FXML loader and read in CustomerDetails.fxml code
			FXMLLoader loader = new FXMLLoader(getClass().getResource("/CustomerDetails.fxml"));
			AnchorPane customerDetailsPane;
			
			try {
				// establish CustomerDetails.fmxl pane
				customerDetailsPane = (AnchorPane)loader.load();
				// create new scene based on the pane
				Scene customerDetailsScene = new Scene(customerDetailsPane);
				// create new stage
				customerDetailsStage = new Stage();
				// set the scene to customerDetailsScene
				customerDetailsStage.setScene(customerDetailsScene);
				
				// set CustomerDetails window title
				customerDetailsStage.setTitle("Customer Details");
				
				// load controller
				controller2 = (CustomerDetailsController) loader.getController();
				// set controller
				controller2.setController(this);
				
			}
			// catch any errors
			catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		// show stage of order summary window
		customerDetailsStage.show();
	}
	
	@FXML
	public void initialize() {
		// create a file object
		java.io.File file = new java.io.File("thneeds.csv");
		
		// create an input stream to the file using automatic closure
		try ( Scanner input = new Scanner(file)) {

			// read headers
			String[] headers = input.nextLine().split(",");
			for (int i = 0; i < headers.length; i++)
				System.out.print(headers[i] + ", ");
			System.out.println("\n");

			// read any additional lines with order information from CSV file
			while(input.hasNext()) {
				String[] line = input.nextLine().split(",");
				
				int orderIDConverted = Integer.parseInt(line[7]);
				String customerName = line[1];
				String orderDate = line[9];
				String filledDate = line[10];
				
				if (filledDate.equals("NULL")) {
					// adds information to the unfilled 
					unfilledOrdersList.add(new Order(orderIDConverted, customerName, orderDate, filledDate));
					
					// populates TableView with values
					unfilledTableOrderID.setCellValueFactory(new PropertyValueFactory<Order,Integer>("tableOrderID"));
					unfilledTableCustomer.setCellValueFactory(new PropertyValueFactory<Order,String>("tableCustomerName"));
					unfilledTableOrderDate.setCellValueFactory(new PropertyValueFactory<Order,String>("tableOrderDate"));
					unfilledTableFilledDate.setCellValueFactory(new PropertyValueFactory<Order,String>("tableFilledDate"));
				
					// sets the TableView items for order ID, customer name, order date, and filled date
					unfilledOrders.setItems(unfilledOrdersList);
				}
				else {
					filledOrdersList.add(new Order(orderIDConverted, customerName, orderDate, filledDate));
					
					// populates TableView with values
					filledTableOrderID.setCellValueFactory(new PropertyValueFactory<Order,Integer>("tableOrderID"));
					filledTableCustomer.setCellValueFactory(new PropertyValueFactory<Order,String>("tableCustomerName"));
					filledTableOrderDate.setCellValueFactory(new PropertyValueFactory<Order,String>("tableOrderDate"));
					filledTableFilledDate.setCellValueFactory(new PropertyValueFactory<Order,String>("tableFilledDate"));
					
					// sets the TableView items for order ID, customer name, order date, and filled date
					filledOrders.setItems(filledOrdersList);
				}
			}
			
		} 
		catch (FileNotFoundException e) {
			e.printStackTrace();
		} 
		catch (Exception ex) {
			System.out.println("File could not be opened or data did not match.");
			ex.printStackTrace();
		}
	}
	
}
