import java.sql.*;
import java.util.Scanner;

/**
 * Presentation layer for the JDBC lab, provides a menu for the user to interact with the databases
 */
public class App {

    /**
     * entry point for the application, displays a menu and handles user input
     * @param args command line arguments
     */
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        boolean running = true;

        while (running) {
            System.out.println("\n===== Database Lab Menu =====");
            System.out.println("1. Query all cookbooks (Statement - MealPlanning)");
            System.out.println("2. Query all games (Statement - ArcadeGames)");
            System.out.println("3. Search recipes by cookbook (PreparedStatement - MealPlanning)");
            System.out.println("4. Search scores by game (PreparedStatement - ArcadeGames)");
            System.out.println("5. Get recipes via stored procedure (CallableStatement - MealPlanning)");
            System.out.println("6. Get player scores via stored procedure (CallableStatement - ArcadeGames)");
            System.out.println("7. Search cookbooks by format - SQL Injection Demo");
            System.out.println("8. Exit");
            System.out.print("Choose an option: ");

            String choice = scanner.nextLine().trim();

            try {
                switch (choice) {
                    case "1":
                        handleAllCookbooks();
                        break;
                    case "2":
                        handleAllGames();
                        break;
                    case "3":
                        handleRecipesByCookbook(scanner);
                        break;
                    case "4":
                        handleScoresByGame(scanner);
                        break;
                    case "5":
                        handleCallGetRecipes(scanner);
                        break;
                    case "6":
                        handleCallGetPlayerScores(scanner);
                        break;
                    case "7":
                        handleSqlInjection(scanner);
                        break;
                    case "8":
                        running = false;
                        break;
                    default:
                        System.out.println("Invalid option, try again.");
                }
            } catch (SQLException e) {
                System.out.println("Database error: " + e.getMessage());
            }
        }

        DatabaseConnectionManager.closeConnections();
        scanner.close();
        System.out.println("\nDoneskies");
    }

    /**
     * executes a statement that returns all cookbooks from the MealPlanning database
     * @throws SQLException if something goes wrong with the query
     */
    private static void handleAllCookbooks() throws SQLException {
        ResultSet rs = MealPlanningProvider.getAllCookbooks();
        System.out.println("\n-- All Cookbooks --");
        while (rs.next()) {
            System.out.println(rs.getString("CookbookName")
                + " | IsBook: " + rs.getBoolean("IsBook")
                + " | Website: " + rs.getString("Website"));
        }
        rs.close();
    }

    /**
     * executes a statement that returns all games from the ArcadeGames database
     * @throws SQLException if something goes wrong with the query
     */
    private static void handleAllGames() throws SQLException {
        ResultSet rs = ArcadeGamesProvider.getAllGames();
        System.out.println("\n-- All Games --");
        while (rs.next()) {
            System.out.println(rs.getString("GameName")
                + " | Developer: " + rs.getString("DeveloperName")
                + " | Released: " + rs.getDate("ReleaseDate"));
        }
        rs.close();
    }

    /**
     * prompts the user for a cookbook name and executes a prepared statement to get its recipes
     * @param scanner scanner for user input
     * @throws SQLException if something goes wrong with the query
     */
    private static void handleRecipesByCookbook(Scanner scanner) throws SQLException {
        System.out.print("Enter cookbook name: ");
        String cookbookName = scanner.nextLine().trim();
        ResultSet rs = MealPlanningProvider.getRecipesByCookbook(cookbookName);
        System.out.println("\n-- Recipes in " + cookbookName + " --");
        boolean found = false;
        while (rs.next()) {
            found = true;
            System.out.println(rs.getString("RecipeName")
                + " | Servings: " + rs.getInt("TotalServings"));
        }
        if (!found) System.out.println("No recipes found for that cookbook.");
        rs.close();
    }

    /**
     * prompts the user for a game name and executes a prepared statement to get its scores
     * @param scanner scanner for user input
     * @throws SQLException if something goes wrong with the query
     */
    private static void handleScoresByGame(Scanner scanner) throws SQLException {
        System.out.print("Enter game name: ");
        String gameName = scanner.nextLine().trim();
        ResultSet rs = ArcadeGamesProvider.getScoresByGame(gameName);
        System.out.println("\n-- Scores for " + gameName + " --");
        boolean found = false;
        while (rs.next()) {
            found = true;
            System.out.println(rs.getString("UserName")
                + " | Score: " + rs.getInt("Score")
                + " | Date: " + rs.getTimestamp("GameDate"));
        }
        if (!found) System.out.println("No scores found for that game.");
        rs.close();
    }

    /**
     * prompts the user for a cookbook name and calls the getRecipes stored procedure
     * @param scanner scanner for user input
     * @throws SQLException if something goes wrong with the query
     */
    private static void handleCallGetRecipes(Scanner scanner) throws SQLException {
        System.out.print("Enter cookbook name: ");
        String cookbookName = scanner.nextLine().trim();
        ResultSet rs = MealPlanningProvider.callGetRecipes(cookbookName);
        System.out.println("\n-- Recipes (via stored procedure) --");
        boolean found = false;
        while (rs.next()) {
            found = true;
            System.out.println(rs.getString("RecipeName"));
        }
        if (!found) System.out.println("No recipes found for that cookbook.");
        rs.close();
    }

    /**
     * prompts the user for a player username and calls the getPlayerScores stored procedure
     * @param scanner scanner for user input
     * @throws SQLException if something goes wrong with the query
     */
    private static void handleCallGetPlayerScores(Scanner scanner) throws SQLException {
        System.out.print("Enter player username: ");
        String username = scanner.nextLine().trim();
        ResultSet rs = ArcadeGamesProvider.callGetPlayerScores(username);
        System.out.println("\n-- Player Scores (via stored procedure) --");
        boolean found = false;
        while (rs.next()) {
            found = true;
            System.out.println(rs.getString("GameName")
                + " | Score: " + rs.getInt("Score"));
        }
        if (!found) System.out.println("No scores found for that player.");
        rs.close();
    }

    /**
     * demonstrates SQL injection by concatenating user input directly into a query string
     * @param scanner scanner for user input
     * @throws SQLException if something goes wrong with the query
     */
    private static void handleSqlInjection(Scanner scanner) throws SQLException {
        System.out.println("\nThis searches for cookbooks by format (IsBook).");
        System.out.println("Enter 1 for physical books, 0 for online.");
        System.out.print("Enter format: ");
        String userInput = scanner.nextLine().trim();
        ResultSet rs = MealPlanningProvider.getCookbooksByFormat(userInput);
        System.out.println("\n-- Results --");
        boolean found = false;
        while (rs.next()) {
            found = true;
            System.out.println(rs.getString("CookbookName")
                + " | IsBook: " + rs.getBoolean("IsBook")
                + " | Website: " + rs.getString("Website"));
        }
        if (!found) System.out.println("No cookbooks found.");
        rs.close();
    }
}