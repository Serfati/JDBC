import JDBC.DatabaseManager;
import JDBC.DatabaseManagerMSSQLServer;
import JDBC.ResultSetPrinter;

import java.sql.ResultSet;

public class Main {

    public static void main(String[] args) {
        String databaseName = "Northwind";
        DatabaseManager databaseManager = new DatabaseManagerMSSQLServer(databaseName);
        databaseManager.startConnection();
        ResultSet resultSet = databaseManager.executeQuerySelect("Select * From Orders");
        ResultSetPrinter.printResultSet(resultSet);
        databaseManager.closeConnection();
    }
}
