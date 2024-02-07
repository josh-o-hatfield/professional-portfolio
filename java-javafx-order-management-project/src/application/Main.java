package application;
	
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.layout.AnchorPane;

public class Main extends Application {
	@Override
	public void start(Stage primaryStage) {
		try {		
			// get an FXML loader and read in the fxml code
			FXMLLoader loader = new FXMLLoader();
			loader.setLocation(Main.class.getResource("/MainOrderWindow.fxml"));
			
			// establish AnchorPane of main window
			AnchorPane mainPane;
			mainPane = (AnchorPane)loader.load();
			
			// create the scene with the layout in the fxml code, set the scene and show it
			Scene mainScene = new Scene(mainPane);
			Stage mainStage = new Stage();
			mainStage.setScene(mainScene);
			
			// set window title
			mainStage.setTitle("Thneed Order Management System");
			
			// show the stage
			mainStage.show();
		} 
		catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) {
		launch(args);
	}
}