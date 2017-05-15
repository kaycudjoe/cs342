import oracle.kv.*;

import java.sql.SQLException;
import java.util.Arrays;
import java.util.Map;
import java.util.Scanner;

/**
 * Created by kec32 on 5/11/2017.
 * GetGraduateEmployer gets the graduate position and employer position when the user enters in a graduate ID and their employer ID.
 * This will be useful to the career center staff to get all the positions graduates have had - and the positions of their employers for any specific position
 */
public class GetGraduateEmployer {
    public static void main(String[] args) throws SQLException {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        Scanner reader = new Scanner(System.in);
        System.out.print("Enter graduate ID: ");
        Integer graduateId = reader.nextInt();

        System.out.print("Enter employer ID: ");
        Integer employerId = reader.nextInt();

        System.out.println("\nGraduate ID: " + graduateId);
        System.out.println("Employer ID: " + employerId);

        Key majorKeyPathOnly = Key.createKey(Arrays.asList("position", graduateId.toString()));
        Map<Key, ValueVersion> fields = store.multiGet(majorKeyPathOnly, null, null);
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            String position = field.getKey().getMinorPath().get(0);
            String employerIdValue = new String(field.getValue().getValue().getValue());
            if (employerIdValue.equals(employerId.toString())) {
                System.out.println("\t" + position);
            }
        }
        store.close();
    }
}