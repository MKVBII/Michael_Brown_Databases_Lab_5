import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * handles connectins to the MealPlanning and ArcadeGames databases
 */
public class DatabaseConnectionManager {

    private static Connection mealPlanningConnection;
    private static Connection arcadeGamesConnection;

    private static final String HOST = "localhost";
    private static final String PORT = "3306";
    private static final String USER = "root";
    private static final String PASSWORD = "xyz";

    /**
     * takes a database name and returns a connection to that database
     * @param databaseName name of the database we're trying to connect to
     * @return connection to that database
     * @throws SQLException if the database doesn't exist or can't be connected to
     */
    private static Connection getConnection(String databaseName) throws SQLException {
        String url = "jdbc:mysql://" + HOST + ":" + PORT + "/" + databaseName;
        return DriverManager.getConnection(url, USER, PASSWORD);
    }

    /**
     * gets the connection for the MealPlanning database
     * @return a connection to the MealPlanning database
     * @throws SQLException if the database doesn't exist or can't be connected to
     */
    public static Connection getMealPlanningConnection() throws SQLException {
        if (mealPlanningConnection == null || mealPlanningConnection.isClosed()) {
            mealPlanningConnection = getConnection("MealPlanning");
        }
        return mealPlanningConnection;
    }

    /**
     * gets the connection to the ArcadeGames databse
     * @return a conection to the ArcadeGames database
     * @throws SQLException if the database doesn't exist or can't be connected to
     */
    public static Connection getArcadeGamesConnection() throws SQLException {
        if (arcadeGamesConnection == null || arcadeGamesConnection.isClosed()) {
            arcadeGamesConnection = getConnection("ArcadeGames");
        }
        return arcadeGamesConnection;
    }

    /**
     * cleanup, closes the connections
     */
    public static void closeConnections() {
        try {
            if (mealPlanningConnection != null && !mealPlanningConnection.isClosed()) {
                mealPlanningConnection.close();
            }
            if (arcadeGamesConnection != null && !arcadeGamesConnection.isClosed()) {
                arcadeGamesConnection.close();
            }
        } catch (SQLException e) {
            System.out.println("Error closing connections: " + e.getMessage());
        }
    }
}