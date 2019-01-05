import javafx.util.Pair;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;



public class Assignment4 {

    private Assignment4() {
    }

    public static void executeFunc(Assignment4 ass, String[] args) {
        String funcName = args[0];
        switch (funcName) {
            case "loadNeighborhoodsFromCsv":
                ass.loadNeighborhoodsFromCsv(args[1]);
                break;
            case "dropDB":
                ass.dropDB();
                break;
            case "initDB":
                ass.initDB(args[1]);
                break;
            case "updateEmployeeSalaries":
                ass.updateEmployeeSalaries(Double.parseDouble(args[1]));
                break;
            case "getEmployeeTotalSalary":
                System.out.println(ass.getEmployeeTotalSalary());
                break;
            case "updateAllProjectsBudget":
                ass.updateAllProjectsBudget(Double.parseDouble(args[1]));
                break;
            case "getTotalProjectBudget":
                System.out.println(ass.getTotalProjectBudget());
                break;
            case "calculateIncomeFromParking":
                System.out.println(ass.calculateIncomeFromParking(Integer.parseInt(args[1])));
                break;
            case "getMostProfitableParkingAreas":
                System.out.println(ass.getMostProfitableParkingAreas());
                break;
            case "getNumberOfParkingByArea":
                System.out.println(ass.getNumberOfParkingByArea());
                break;
            case "getNumberOfDistinctCarsByArea":
                System.out.println(ass.getNumberOfDistinctCarsByArea());
                break;
            case "AddEmployee":
                SimpleDateFormat format = new SimpleDateFormat("dd-MM-yyyy");
                ass.AddEmployee(Integer.parseInt(args[1]), args[2], args[3], Date.valueOf(args[4]), args[5], Integer.parseInt(args[6]), Integer.parseInt(args[7]), args[8]);
                break;
            default:
                break;
        }
    }


    public static void main(String[] args) {

        File file = new File(".");
        String csvFile = args[0];
        String line = "";
        String cvsSplitBy = ",";
        Assignment4 ass = new Assignment4();
        try (BufferedReader br = new BufferedReader(new FileReader(csvFile))) {

            while ((line = br.readLine()) != null) {

                // use comma as separator
                String[] row = line.split(cvsSplitBy);

                executeFunc(ass, row);

            }

        } catch (IOException e) {
            e.printStackTrace();

        }
    }

    private void loadNeighborhoodsFromCsv(String csvPath) {
        try {
            BufferedReader br = new BufferedReader(new FileReader(csvPath));
            Connection con = getCon();
            String line;
            String[] row;
            PreparedStatement pst;
            int token;
            while ((line = br.readLine()) != null) {
                row = line.split(",");
                pst = con.prepareStatement("Insert into Neighborhood (NID,Name) values(?,?)");
                token = Integer.parseInt(row[0]);
                pst.setInt(1, token);
                pst.setString(2, row[1]);
                pst.execute();
                pst.close();
            }
            br.close();
            closeConnection(con);
        } catch (SQLException | IOException e) {
        }
    }

    private void updateEmployeeSalaries(double percentage) {
        // update salary for over fifty
        String sql = "UPDATE c set SalaryPerDay = SalaryPerDay +( SalaryPerDay * ?) FROM ConstructorEmployee AS c INNER JOIN Employee AS e on c.EID = e.EID WHERE BirthDate < '1968-12-23'";
        try (Connection conn = getCon();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setDouble(1, (percentage / 100));
            stmt.executeUpdate();
            closeConnection(conn);
        } catch (SQLException e) {
        }
    }

    public void updateAllProjectsBudget(double percentage) {
        // update salary for over fifty
        String sql = "update Project set Budget = Budget +( Budget * ?)";
        try (Connection conn = getCon();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setDouble(1, (percentage / 100));
            stmt.executeUpdate();
        } catch (SQLException e) {
        }
    }

    private double getEmployeeTotalSalary() {
        String sql = "SELECT sum(SalaryPerDay) FROM ConstructorEmployee";
        double totalBudget = 0;
        try {
            ResultSet rs = executeQuerySelect(sql);
            while (rs.next())
                totalBudget = rs.getDouble(1);
        } catch (SQLException e) {
        }
        return totalBudget;
    }

    private int getTotalProjectBudget() {
        String sql = "SELECT sum(Budget) as TotalBudget FROM Project";
        int totalBudget = 0;
        try {
            ResultSet rs = executeQuerySelect(sql);
            while (rs.next())
                totalBudget = rs.getInt(1);
        } catch (SQLException e) {
        }
        return totalBudget;
    }

    private void dropDB() {

        String databaseName = "DB2019_Ass2";
        Connection con;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;integratedSecurity=false;"); //TODO false;", "sa", "aVihai4");
            Statement st = con.createStatement();
            selectDatabase("master");
            String sql = "DROP DATABASE " + databaseName;
            st.executeUpdate(sql);
            closeConnection(con);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (ClassNotFoundException e) {
        }
    }

    private void initDB(String csvPath) {
        String s;
        StringBuffer sb = new StringBuffer();
        try {
            FileReader fr = new FileReader(new File(csvPath));
            // be sure to not have line starting with "--" or "/*" or any other non aplhabetical character
            BufferedReader br = new BufferedReader(fr);
            while ((s = br.readLine()) != null) sb.append(s);
            br.close();
            /*
            here is our splitter ! We use ";" as a delimiter for each request
            then we are sure to have well formed statements
            */
            String[] inst = sb.toString().split(";");

            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            Connection con;
            try (Connection connection = con =
                    DriverManager.getConnection("jdbc:sqlserver://localhost:1433;integratedSecurity=true;")) {
            }
            Statement st = con.createStatement();
            /*
            we ensure that there is no spaces before or after the request string
            in order to not execute empty statements
            */
            for (String s1 : inst)
                if (!s1.trim().equals("")) {
                    st.executeUpdate(s1);
                    //System.out.println(">>" + s1);
                }
            selectDatabase("DB2019_Ass2");
        } catch (Exception e) {
        }
    }

    private int calculateIncomeFromParking(int year) {
        String sql = "SELECT sum(cost) as TotalCostPerYear from CarParking where YEAR(EndTime)= " + year;
        int IncomeFromParking = 0;
        try {
            ResultSet rs = executeQuerySelect(sql);
            while (rs.next())
                IncomeFromParking =  rs.getInt("TotalCostPerYear");
        } catch (SQLException e) {
        }
        return IncomeFromParking;
    }

    private ArrayList<Pair<Integer, Integer>> getMostProfitableParkingAreas() {
        ArrayList<Pair<Integer, Integer>> res = new ArrayList<>();
        try {
            Connection con = getCon();
            String sql = "SELECT TOP(5) ParkingAreaID, sum(cost) as TotalProfit  FROM CarParking Group by ParkingAreaID order by TotalProfit DESC";
            ResultSet rs = executeQuerySelect(sql);
            while (rs.next()) {
                Pair<Integer, Integer> pair = new Pair<>(rs.getInt(1), rs.getInt(2));
                res.add(pair);
            }
            closeConnection(con);
            return res;
        } catch (SQLException e) {
        }
        return null;
    }

    private ArrayList<Pair<Integer, Integer>> getNumberOfParkingByArea() {
        ArrayList<Pair<Integer, Integer>> res = new ArrayList<>();
        try {
            Connection con = getCon();
            String sql = "SELECT ParkingAreaID, COUNT(CID) as CarParks  FROM CarParking Group by ParkingAreaID";
            ResultSet rs = executeQuerySelect(sql);
            Pair<Integer, Integer> pair;
            while (rs.next()) {
                pair = new Pair<>(rs.getInt(1), rs.getInt(2));
                res.add(pair);
            }
            closeConnection(con);
            return res;
        } catch (SQLException e) {
        }
        return null;
    }

    private ArrayList<Pair<Integer, Integer>> getNumberOfDistinctCarsByArea() {
        ArrayList<Pair<Integer, Integer>> res = new ArrayList<>();
        try {
            Connection con = getCon();
            String sql = "SELECT ParkingAreaID, COUNT(distinct CID) as DistinctCars  FROM CarParking Group by ParkingAreaID";
            ResultSet rs = executeQuerySelect(sql);
            while (rs.next()) {
                Pair<Integer, Integer> pair = new Pair<>(rs.getInt(1), rs.getInt(2));
                res.add(pair);
            }
            closeConnection(con);
            return res;
        } catch (SQLException e) {
        }
        return null;
    }

    private void AddEmployee(int EID, String LastName, String FirstName, Date BirthDate, String StreetName, int Number, int door, String City) {
        try {
            Connection con = getCon();
            String sql = "INSERT INTO Employee VALUES (?, ?, ?, ?,?, ?, ?, ?)";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setInt(1, EID);
            pst.setString(2, LastName);
            pst.setString(3, FirstName);
            pst.setDate(4, BirthDate);
            pst.setString(5, StreetName);
            pst.setInt(6, Number);
            pst.setInt(7, door);
            pst.setString(8, City);
            pst.executeUpdate(sql);
            closeConnection(con);
        } catch (SQLException se) {
        }
    }

    private static Connection getCon() {
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;databaseName=DB2019_Ass2;integratedSecurity=true;");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (ClassNotFoundException e) {
        }
        return con;
    }

    /**
     * @param query SQL query
     * @return ResultSet holds the query results
     */
    //Execute Queries
    public ResultSet executeQuerySelect(String query) {
        ResultSet resultSet = null;
        try {
            Connection conn = getCon();
            Statement sqlStatement = conn.createStatement();

            resultSet = sqlStatement.executeQuery(query);
        } catch (SQLException e) {
        }
        return resultSet;
    }

    /**
     * Close the connection
     *
     * @return true if the connection is closed properly
     */
    public void closeConnection(Connection conn) {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
        } catch (Exception e) {
        }
    }

    /**
     * Selects database to work on.
     *
     * @return true if the database exists and been selected.
     */
    private void selectDatabase(String databaseName) {
        Connection conn;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;integratedSecurity=true;");
            Statement stmt = conn.createStatement();
            stmt.execute("use " + databaseName);
            stmt.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (ClassNotFoundException e) {
        }
}
}