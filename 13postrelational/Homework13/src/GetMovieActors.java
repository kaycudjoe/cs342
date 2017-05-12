import oracle.kv.*;

import java.sql.SQLException;
import java.util.Arrays;
import java.util.Map;
import java.util.Scanner;

/**
 * Created by kec32 on 5/11/2017.
 */
public class GetMovieActors {
    public static void main(String[] args) throws SQLException {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        Scanner reader = new Scanner(System.in);
        System.out.print("Enter movie ID: ");
        Integer movieId = reader.nextInt();

        System.out.println("Movie ID: " + movieId);

        Key majorKeyPathOnly = Key.createKey(Arrays.asList("role", movieId.toString()));
        Map<Key, ValueVersion> fields = store.multiGet(majorKeyPathOnly, null, null);
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            String roleName = field.getKey().getMinorPath().get(0);
            String actorId = new String(field.getValue().getValue().getValue());
            System.out.println("\t" + actorId + " \t" + getNamesofActor(actorId, store) + "\t" + roleName);
            }
        store.close();
    }

    public static String getNamesofActor(String actorId, KVStore store) {
        String fullName = "";
        Key majorKeyPathOnly = Key.createKey(Arrays.asList("actor", actorId));
        Map<Key, ValueVersion> fields = store.multiGet(majorKeyPathOnly, null, null);
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            fullName += " " + new String(field.getValue().getValue().getValue());
        }
        return fullName;
    }
}
