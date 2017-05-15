import oracle.kv.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Arrays;
import java.util.Map;

/**
 * Created by kec32 on 5/13/2017
 *
 * LoadDB loads data from the OracleXE calvinLW Graduate, Employer and GraduateEmployer tables
 * and loads them into the Oracle KVLite using a key-value structure.
 * It will be useful for my database developers to access the calvinLW database records and store them in a key-value database that doesn't have most of SQL relational database issues.
 */
public class LoadDB {
    private static KVStore store;
    private static Connection jdbcConnection;

    public static void main(String[] args) throws SQLException {
        // Instantiate the kvStore and connect to Oracle database
        store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        jdbcConnection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "calvinLW", "kec32password");

        loadGraduates();
        loadEmployers();
        loadGraduateEmployer();

        // Close the kvStore and jdbc Connection
        jdbcConnection.close();
        store.close();
    }

    /**
     * loadGraduates loads the data from Graduate using JDBC and then puts the data into KVLite
     * @param KVStore store, KVLite store to load data into
     * @param Connection jdbcConnection, connection to use when pulling data using JDBC
     * @throws SQLException
     */

    public static void loadGraduates() throws SQLException {
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet graduates = jdbcStatement.executeQuery("SELECT ID, firstName, lastName, email, graduationDate FROM Graduate");

        while(graduates.next()) {
            Integer ID = graduates.getInt(1);

            Key firstNameKey = Key.createKey(Arrays.asList("graduate", ID.toString()), Arrays.asList("firstName"));
            Value firstNameValue = Value.createValue(graduates.getString(2).getBytes());
            store.put(firstNameKey, firstNameValue);

            Key lastNameKey = Key.createKey(Arrays.asList("graduate", ID.toString()), Arrays.asList("lastName"));
            Value lastNameValue = Value.createValue(graduates.getString(3).getBytes());
            store.put(lastNameKey, lastNameValue);

            Key emailKey = Key.createKey(Arrays.asList("graduate", ID.toString()), Arrays.asList("email"));
            Value emailValue = Value.createValue(graduates.getString(4).getBytes());
            store.put(emailKey, emailValue);

            Key graduationDateKey = Key.createKey(Arrays.asList("graduate", ID.toString()), Arrays.asList("graduationDate"));
            Value graduationDateValue = Value.createValue(graduates.getString(5).getBytes());
            store.put(graduationDateKey, graduationDateValue);

        }
        graduates.close();
        jdbcStatement.close();
    }

    /**
     * loadEmployers loads the data from the Employer using JDBC and then puts the data into KVLite
     * @param KVStore store, KVLite store to load data into
     * @param Connection jdbcConnection, connection to use when pulling data using JDBC
     * @throws SQLException
     */
    public static void loadEmployers() throws SQLException {
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet employers = jdbcStatement.executeQuery("SELECT ID, firstName, lastName, email, CompanyName FROM Employer");

        while(employers.next()) {
            Integer ID = employers.getInt(1);

            Key firstName2Key = Key.createKey(Arrays.asList("employer", ID.toString()), Arrays.asList("firstName"));
            Value firstName2Value = Value.createValue(employers.getString(2).getBytes());
            store.put(firstName2Key, firstName2Value);

            Key lastName2Key = Key.createKey(Arrays.asList("employer", ID.toString()), Arrays.asList("lastName"));
            Value lastName2Value = Value.createValue(employers.getString(3).getBytes());
            store.put(lastName2Key, lastName2Value);

            Key email2Key = Key.createKey(Arrays.asList("employer", ID.toString()), Arrays.asList("email"));
            Value email2Value = Value.createValue(employers.getString(3).getBytes());
            store.put(email2Key, email2Value);

            Key CompanyName2Key = Key.createKey(Arrays.asList("employer", ID.toString()), Arrays.asList("CompanyName"));
            Value CompanyName2Value = Value.createValue(employers.getString(3).getBytes());
            store.put(CompanyName2Key, CompanyName2Value);
        }
        employers.close();
        jdbcStatement.close();
    }

    /**
     * loadGraduateEmployer loads the data from the GraduateEmployer using JDBC and then puts the data into KVLite
     * @param KVStore store, KVLite store to load data into
     * @param Connection jdbcConnection, connection to use when pulling data using JDBC
     * @throws SQLException
     */

    public static void loadGraduateEmployer() throws SQLException {
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet resultSet = jdbcStatement.executeQuery("SELECT graduateId, employerid, position FROM GraduateEmployer");

        while(resultSet.next()) {
            Key key = Key.createKey(Arrays.asList("position", resultSet.getString(2)), Arrays.asList(resultSet.getString(3)));
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