import oracle.kv.*;

import java.sql.SQLException;
import java.util.Arrays;
import java.util.Map;
import java.util.Scanner;

/**
 * Created by kec32 on 5/11/2017.
 */
public class GetMovieActorRoles {
    public static void main(String[] args) throws SQLException {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        Scanner reader = new Scanner(System.in);
        System.out.print("Enter movie ID: ");
        Integer movieId = reader.nextInt();

        System.out.print("Enter actor ID: ");
        Integer actorId = reader.nextInt();

        System.out.println("\nMovie ID: " + movieId);
        System.out.println("Actor ID: " + actorId);

        Key majorKeyPathOnly = Key.createKey(Arrays.asList("role", movieId.toString()));
        Map<Key, ValueVersion> fields = store.multiGet(majorKeyPathOnly, null, null);
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            String roleName = field.getKey().getMinorPath().get(0);
            String actorIdValue = new String(field.getValue().getValue().getValue());
            if (actorIdValue.equals(actorId.toString())) {
                System.out.println("\t" + roleName);
            }
        }
        store.close();
    }
}
