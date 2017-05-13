import oracle.kv.*;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;

/**
 * Created by Karen Cudjoe
 *
 * GetGraduateEmployer queries for and returns all graduates who have worked/work for Employer 10
 * This query is useful because it helps the career center staff to see what graduates work at what companies, in order to pair graduates with students who work at the same companies with them.
 * It also helps them see which companies are more interested in Calvin Students, so they know which companies need more marketing to students.
 *
 *  noSQL is appropriate for this query because the Iterator makes it very easy to iterate through each employer with a graduate
 */
public class GetEmployerGraduates {
    public static void main(String[] args) throws SQLException {
        GetEmployerGraduates pp = new GetEmployerGraduates();
        pp.run();
    }

    public void run() {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        // get graduates from employerID 10
        String employerID = "10";
        // create key to iterate through
        Key key = Key.createKey(Arrays.asList("GraduateEmployer", employerID));
        // store graduate Ids
        ArrayList<String> graduateIDs = new ArrayList<String>();
        Iterator<KeyValueVersion> iterator = store.storeIterator(Direction.UNORDERED, 0, key, null, null);
        while (iterator.hasNext()) {
            Key tempKey = iterator.next().getKey();
            String pid = tempKey.getMajorPath().get(2);
            graduateIDs.add(pid);
        }

        // print out graduate names
        System.out.println("Graduates for employer " + employerID);
        for (int i = 0; i < graduateIDs.size(); i++) {
            Key firstNameKey = Key.createKey(Arrays.asList("graduate", graduateIDs.get(i)), Arrays.asList("firstName"));
            Key lastNameKey = Key.createKey(Arrays.asList("graduate", graduateIDs.get(i)), Arrays.asList("lastName"));
            String firstNameResult = new String(store.get(firstNameKey).getValue().getValue());
            String lastNameResult = new String(store.get(lastNameKey).getValue().getValue());

            System.out.println(graduateIDs.get(i) + '\t' + firstNameResult + " " + lastNameResult);
        }

        store.close();
    }
}