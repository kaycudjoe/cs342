import oracle.kv.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Arrays;
import java.util.Map;

/**
 * Created by kec32 on 5/11/2017.
 */
public class LoadDB {
    private static KVStore store;
    private static Connection jdbcConnection;

    public static void main(String[] args) throws SQLException {
        store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        jdbcConnection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "imdb", "bjarne");

        loadMovies();
        loadActors();
        loadRoles();

        jdbcConnection.close();
        store.close();
    }

    public static void loadMovies() throws SQLException {
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet movies = jdbcStatement.executeQuery("SELECT id, name, year, rank FROM Movie");

        while(movies.next()) {
            Integer movieId = movies.getInt(1);
            String rank = movies.getString(4);

            Key nameKey = Key.createKey(Arrays.asList("movie", movieId.toString()), Arrays.asList("name"));
            Value nameValue = Value.createValue(movies.getString(2).getBytes());
            store.put(nameKey, nameValue);

            Key yearKey = Key.createKey(Arrays.asList("movie", movieId.toString()), Arrays.asList("year"));
            Value yearValue = Value.createValue(movies.getString(3).getBytes());
            store.put(yearKey, yearValue);

            Key rankKey = Key.createKey(Arrays.asList("movie", movieId.toString()), Arrays.asList("rank"));
            Value rankValue = Value.createValue("".getBytes());
            if (rank != null) {
                rankValue = Value.createValue(rank.getBytes());
            }
            store.put(rankKey, rankValue);
        }
        movies.close();
        jdbcStatement.close();
    }


    public static void loadActors() throws SQLException {
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet actors = jdbcStatement.executeQuery("SELECT id, firstName, lastName FROM Actor");

        while(actors.next()) {
            Integer actorId = actors.getInt(1);

            Key firstNameKey = Key.createKey(Arrays.asList("actor", actorId.toString()), Arrays.asList("firstName"));
            Value firstNameValue = Value.createValue(actors.getString(2).getBytes());
            store.put(firstNameKey, firstNameValue);

            Key lastNameKey = Key.createKey(Arrays.asList("actor", actorId.toString()), Arrays.asList("lastName"));
            Value lastNameValue = Value.createValue(actors.getString(3).getBytes());
            store.put(lastNameKey, lastNameValue);
        }
        actors.close();
        jdbcStatement.close();
    }

    public static void loadRoles() throws SQLException {
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet resultSet = jdbcStatement.executeQuery("SELECT actorid, movieId, role FROM Role");

        while(resultSet.next()) {
            Key key = Key.createKey(Arrays.asList("role", resultSet.getString(2)), Arrays.asList(resultSet.getString(3)));
            Value value = Value.createValue(resultSet.getString(1).getBytes());
            store.put(key, value);

            Map<Key, ValueVersion> fields = store.multiGet(key, null, null);
            for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
                String fieldName = field.getKey().getMinorPath().get(0);
                String fieldValue = new String(field.getValue().getValue().getValue());
                System.out.println("\t" + fieldName + "\t" + fieldValue);
            }
        }
        resultSet.close();
        jdbcStatement.close();
    }
}