import java.sql.*;

/**
 * Provides queries for the MealPlanningProvider database
 */
public class ArcadeGamesProvider {

    /**
     * creates and executes a query return everything from the Game table
     * @return the result of the query
     * @throws SQLException if something goes wrong with the query
     */
    public static ResultSet getAllGames() throws SQLException {
        Connection conn = DatabaseConnectionManager.getArcadeGamesConnection();
        Statement stmt = conn.createStatement();
        return stmt.executeQuery("SELECT * FROM Game");
    }

    /**
     * uses a prepared statement to search for all the scores associated with a specific game
     * @param gameName inputted game name
     * @return the result of the query 
     * @throws SQLException if something goes wrong with the query
     */
    public static ResultSet getScoresByGame(String gameName) throws SQLException {
        Connection conn = DatabaseConnectionManager.getArcadeGamesConnection();
        PreparedStatement ps = conn.prepareStatement(
            "SELECT p.UserName, s.Score, s.GameDate FROM Score s " +
            "JOIN Player p ON s.PlayerId = p.Id " +
            "JOIN Game g ON s.GameId = g.Id " +
            "WHERE g.GameName = ?"
        );
        ps.setString(1, gameName);
        return ps.executeQuery();
    }

    /**
     * executes the stored procedure that gets the scores for each game associated with a player name
     * @param username inputted username
     * @return the result of the query
     * @throws SQLException if something goes wrong with the query
     */
    public static ResultSet callGetPlayerScores(String username) throws SQLException {
        Connection conn = DatabaseConnectionManager.getArcadeGamesConnection();
        CallableStatement cs = conn.prepareCall("{CALL getPlayerScores(?)}");
        cs.setString(1, username);
        return cs.executeQuery();
    }
}