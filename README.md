# Michael Brown - Databases Lab 5

## overview
a JDBC lab that demonstrates three types of SQL statement execution in Java against two MySQL databases (MealPlanning and ArcadeGames). also includes a deliberate SQL injection demo to show why parameterized queries matter.

## project structure
```
src/
  App.java                        - presentation layer, menu-driven interface for interacting with the databases
  DatabaseConnectionManager.java  - centralizes and caches database connections for MealPlanning and ArcadeGames
  MealPlanningProvider.java       - data access layer for MealPlanning queries
  ArcadeGamesProvider.java        - data access layer for ArcadeGames queries
  test_script.bash                - automated test script that compiles and runs the app with pre-filled inputs
lib/
  mysql-connector-j-9.6.0.jar    - MySQL JDBC driver
CreateMealPlanning.sql            - creates and populates the MealPlanning database (cookbooks, recipes, ingredients)
CreateAndPopulateArcadeGame.sql   - creates and populates the ArcadeGames database (games, players, scores)
```

## what it demonstrates
- **Statement** - basic SQL execution for simple queries (menu options 1-2)
- **PreparedStatement** - parameterized queries that prevent SQL injection (menu options 3-4)
- **CallableStatement** - stored procedure invocation (menu options 5-6)
- **SQL injection** - intentionally vulnerable query to show the risk of string concatenation with user input (menu option 7)

## how to run
1. run the SQL scripts against a local MySQL instance to set up both databases
2. compile and run from the `src/` directory:
```bash
javac -cp "../lib/mysql-connector-j-9.6.0.jar" *.java
java -cp ".:../lib/mysql-connector-j-9.6.0.jar" App
```
3. or use the test script which compiles and runs with auto-inserted values:
```bash
bash test_script.bash
```

## prerequisites
- Java (JDK)
- MySQL with a local instance running on the default port
- the two databases created via the provided SQL scripts
