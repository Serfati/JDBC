package JDBC;

import java.sql.*;
import java.util.Arrays;
import java.util.stream.Collectors;

public class DatabaseManager {

    protected String connectionString;
    protected String databaseName;
    protected String username;
    protected String password;
    protected Connection conn;

    //<editor-fold desc="Constructors">
    public DatabaseManager(String connectionString, String databaseName, String username, String password) {
        this.connectionString = connectionString;
        this.databaseName = databaseName;
        this.username = username;
        this.password = password;
    }

    public DatabaseManager(String connectionString, String databaseName) {
        this.connectionString = connectionString;
        this.databaseName = databaseName;
        this.username = "";
        this.password = "";
    }

    public DatabaseManager(String connectionString) {
        this.connectionString = connectionString;
        this.databaseName = "";
        this.username = "";
        this.password = "";
    }
    //</editor-fold>

    //<editor-fold desc="Getters">
    public String getConnectionString() {
        return connectionString;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public String getDatabaseName() {
        return databaseName;
    }
    //</editor-fold>

    //<editor-fold desc="Connection Methods">
    public void startConnection() {
        try {
            conn = DriverManager.getConnection(connectionString, username, password);
            System.out.println(String.format("Connection established to: '%s'", connectionString));
            selectDatabase(this.databaseName);
        } catch (Exception e) {
            System.out.println(String.format("Cannot start connection to: %s", connectionString));
            System.out.println(e.getMessage());
        }
    }

    /**
     * Selects database to work on.
     *
     * @return true if the database exists and been selected.
     */
    private void selectDatabase(String databaseName) {
        try {
            Statement stmt = conn.createStatement();
            stmt.execute("use " + databaseName);
            stmt.close();
            System.out.println(String.format("Database selected: '%s'", databaseName));
        } catch (Exception e) {
            System.out.println(String.format("Database '%s' not found at: %s", databaseName, connectionString));
            System.out.println(e.getMessage());
        }
    }

    /**
     * Close the connection
     *
     * @return true if the connection is closed properly
     */
    public void closeConnection() {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
                conn = null;
                System.out.println(String.format("Database connection closed!", connectionString));
            }
        } catch (Exception e) {
            System.out.println(String.format("Error closing connection to: %s", connectionString));
            System.out.println(e.getMessage());
        }
    }
    //</editor-fold>

    //<editor-fold desc="Execute Queries">

    /**
     * @param query SQL query
     * @return ResultSet holds the query results
     */
    //Execute Queries
    public ResultSet executeQuerySelect(String query) {
        ResultSet resultSet = null;
        if (conn != null) {
            try {
                Statement sqlStatement = conn.createStatement();
                resultSet = sqlStatement.executeQuery(query);
                System.out.println(String.format("Query executed: '%s'", query));
            } catch (SQLException e) {
                System.out.println(String.format("Error executing query: '%s'", query));
                System.out.println(e.getMessage());
            }
        }
        return resultSet;
    }
    //</editor-fold>
}
