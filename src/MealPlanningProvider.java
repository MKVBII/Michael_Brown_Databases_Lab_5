import java.sql.*;

/**
 * Provides queries for the MealPlanningProvider database
 */
public class MealPlanningProvider {

    /**
     * creates and executes a statement to select all values from the Cookbook table
     * @return thre result of the query
     * @throws SQLException if something goes wrong with the query
     */
    public static ResultSet getAllCookbooks() throws SQLException {
        Connection conn = DatabaseConnectionManager.getMealPlanningConnection();
        Statement stmt = conn.createStatement();
        return stmt.executeQuery("SELECT * FROM Cookbook");
    }

    /**
     * uses a prepared statement to make a database query with properly processed user input
     * @param cookbookName inputted cookbook name
     * @return result of the query
     * @throws SQLException if something goes wrong with the query
     */
    public static ResultSet getRecipesByCookbook(String cookbookName) throws SQLException {
        Connection conn = DatabaseConnectionManager.getMealPlanningConnection();
        PreparedStatement ps = conn.prepareStatement("SELECT RecipeName, TotalServings FROM Recipe WHERE CookbookName = ?");
        ps.setString(1, cookbookName);
        return ps.executeQuery();
    }

    /**
     * example of calling our stored procedure with a properly processed inputted value
     * @param cookbookName inputted cookbook name
     * @return result of the query
     * @throws SQLException if something goes wrong with the query
     */
    public static ResultSet callGetRecipes(String cookbookName) throws SQLException {
        Connection conn = DatabaseConnectionManager.getMealPlanningConnection();
        CallableStatement cs = conn.prepareCall("{CALL getRecipes(?)}");
        cs.setString(1, cookbookName);
        return cs.executeQuery();
    }

    /**
     * SQL injection method, direct user input that isn't processed into proper processing
     * @param userInput user inputted value
     * @return the result of the statement
     * @throws SQLException if something goes wrong with the query
     */
    public static ResultSet getCookbooksByFormat(String userInput) throws SQLException {
        Connection conn = DatabaseConnectionManager.getMealPlanningConnection();
        Statement stmt = conn.createStatement();
        String query = "SELECT * FROM Cookbook WHERE IsBook = " + userInput;
        System.out.println("Executing query: " + query);
        return stmt.executeQuery(query);
    }
}