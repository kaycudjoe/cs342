import oracle.kv.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Arrays;
import java.util.Map;

/**
 * Created by kec32 on 5/13/2017.
 */
public class LoadDB {
    private static KVStore store;
    private static Connection jdbcConnection;

    public static void main(String[] args) throws SQLException {
        store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        jdbcConnection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "calvinLW", "kec32password");

        loadGraduates();
        loadEmployers();
        loadGraduateEmployer();

        jdbcConnection.close();
        store.close();
    }

    public static void loadGraduates() throws SQLException {
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet graduates = jdbcStatement.executeQuery("SELECT id, firstName, lastName, email FROM Graduate");

        while(graduates.next()) {
            Integer graduateId = graduates.getInt(1);
            String email = graduates.getString(4);

            Key nameKey = Key.createKey(Arrays.asList("graduate", graduateId.toString()), Arrays.asList("firstName"));
            Value nameValue = Value.createValue(graduates.getString(2).getBytes());
            store.put(nameKey, nameValue);

            Key yearKey = Key.createKey(Arrays.asList("graduate", graduateId.toString()), Arrays.asList("lastName"));
            Value yearValue = Value.createValue(graduates.getString(3).getBytes());
            store.put(yearKey, yearValue);

            Key emailKey = Key.createKey(Arrays.asList("graduate", graduateId.toString()), Arrays.asList("email"));
            Value emailValue = Value.createValue("".getBytes());
            if (email != null) {
                emailValue = Value.createValue(email.getBytes());
            }
            store.put(emailKey, emailValue);
        }
        graduates.close();
        jdbcStatement.close();
    }


    public static void loadEmployers() throws SQLException {
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet employers = jdbcStatement.executeQuery("SELECT id, firstName, lastName, email, CompanyName FROM Employer");

        while(employers.next()) {
            Integer employerId = employers.getInt(1);

            Key firstNameKey = Key.createKey(Arrays.asList("employer", employerId.toString()), Arrays.asList("firstName"));
            Value firstNameValue = Value.createValue(employers.getString(2).getBytes());
            store.put(firstNameKey, firstNameValue);

            Key lastNameKey = Key.createKey(Arrays.asList("employer", employerId.toString()), Arrays.asList("lastName"));
            Value lastNameValue = Value.createValue(employers.getString(3).getBytes());
            store.put(lastNameKey, lastNameValue);

            Key emailKey = Key.createKey(Arrays.asList("employer", employerId.toString()), Arrays.asList("email"));
            Value emailValue = Value.createValue(employers.getString(3).getBytes());
            store.put(emailKey, emailValue);

            Key CompanyNameKey = Key.createKey(Arrays.asList("employer", employerId.toString()), Arrays.asList("CompanyName"));
            Value CompanyNameValue = Value.createValue(employers.getString(3).getBytes());
            store.put(CompanyNameKey, CompanyNameValue);
        }
        employers.close();
        jdbcStatement.close();
    }

    public static void loadGraduateEmployer() throws SQLException {
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet resultSet = jdbcStatement.executeQuery("SELECT employerid, graduateId, position FROM GraduateEmployer");

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