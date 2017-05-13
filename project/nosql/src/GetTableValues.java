import oracle.kv.*;

import java.sql.SQLException;
import java.util.Arrays;
import java.util.Map;
import java.util.Scanner;


/**
 * Created by Karen Cudjoe
 * Gets the values in a certain table
 */
public class GetTableValues {
    public static void main(String[] args) throws SQLException {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        Scanner reader = new Scanner(System.in);
        System.out.print("Enter table name: ");
        String gettable = reader.nextLine();

        System.out.print("Enter graduate ID: ");
        Integer id = reader.nextInt();

        System.out.println("\nTable: " + gettable);
        System.out.println("ID: " + id.toString());

        Key majorKeyPathOnly = Key.createKey(Arrays.asList(gettable, id.toString()));
        Map<Key, ValueVersion> fields = store.multiGet(majorKeyPathOnly, null, null);
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            String fieldValue = new String(field.getValue().getValue().getValue());
            System.out.println(fieldValue);
        }
        store.close();
    }
}