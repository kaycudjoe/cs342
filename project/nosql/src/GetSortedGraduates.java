import oracle.kv.*;

import java.sql.SQLException;
import java.util.*;

/**
 * Created by kec32
 * */
public class GetSortedGraduates {

    public static void main(String[] args) throws SQLException {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        HashMap<String, List<List<String>>> graduateData = new HashMap<>();
        List<String> list_graduationDate = new ArrayList<>();

        Key key = Key.createKey(Arrays.asList("graduate"));
        Iterator<KeyValueVersion> it = store.storeIterator(Direction.UNORDERED, 0, key, null, null);

        while (it.hasNext()) {
            List<String> currentData = new ArrayList<>();
            KeyValueVersion kv = it.next();
            if (kv.getKey().getMinorPath().get(0).equals("graduationDate")) {
                String graduateId = kv.getKey().getMajorPath().get(1);
                String graduationDate = new String(kv.getValue().getValue());
                currentData.add(graduateId);
                currentData.add(getGraduatelastName(graduateId, store));
                if (!list_graduationDate.contains(graduationDate)) {
                    list_graduationDate.add(graduationDate);
                }
                if (graduateData.containsKey(graduationDate)) {
                    graduateData.get(graduationDate).add(currentData);
                } else {
                    List<List<String>> extra = new ArrayList<>();
                    extra.add(currentData);
                    graduateData.put(graduationDate, extra);
                }
            }
        }

        Collections.sort(list_graduationDate);

        for (String graduationDate : list_graduationDate) {
            for(List<String> graduateInfo : graduateData.get(graduationDate)) {
                System.out.print(graduationDate + "\t");
                for (String data : graduateInfo) {
                    System.out.print(data + "\t");
                }
                System.out.print("\n");
            }
        }

        store.close();
    }

    public static String getGraduatelastName(String graduateId, KVStore store) {
        String temp = "";
        Key majorKeyPath = Key.createKey(Arrays.asList("graduate", graduateId));
        Map<Key, ValueVersion> fields = store.multiGet(majorKeyPath, null, null);
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            if (field.getKey().getMinorPath().get(0).equals("lastName")) {
                temp = new String(field.getValue().getValue().getValue());
            }
        }
        return temp;
    }
}