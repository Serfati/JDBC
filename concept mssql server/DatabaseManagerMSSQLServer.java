package JDBC;

public class DatabaseManagerMSSQLServer extends DatabaseManager {

    public DatabaseManagerMSSQLServer(String databaseName) {
        super("jdbc:sqlserver://localhost;Instance=SQLEXPRESS;integratedSecurity=true", databaseName, "", "");
        //super("jdbc:sqlserver://localhost;integratedSecurity=true", databaseName, "", "");
    }

    public DatabaseManagerMSSQLServer(String connectionString, String databaseName) {
        super(connectionString, databaseName, "", "");
    }

    public DatabaseManagerMSSQLServer(String connectionString, String databaseName, String username, String password) {
        super(connectionString, databaseName, username, password);
    }


    @Override
    public void startConnection() {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            super.startConnection();
        } catch (Exception e) {
            System.out.println(String.format("Error starting connection to database '%s'", databaseName));
            System.out.println(e.getMessage());
        }
    }

}
