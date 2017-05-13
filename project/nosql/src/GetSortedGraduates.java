import oracle.kv.*;

import java.sql.SQLException;
import java.util.*;

/**
 * Created by kec32 on 5/12/2017.
 *
 * GetSortedGraduates gets all Graduates and sorts them in alphabetical order
 * This is useful for the career center staff to see all the graduates currently involved in the program.
 *
 *  noSQL is not very appropriate for sorting, and therefore I needed to make a Graduate class.
 */
public class GetSortedGraduates {
    public static void main(String[] args) throws SQLException {
        GetSortedGraduates sg = new GetSortedGraduates();
        sg.run();
    }

    public void run() {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        ArrayList<Graduates> grads = new ArrayList<Graduates>();
        Key key = Key.createKey(Arrays.asList("graduate"));

        // iterate through all Graduates and store them in an ArrayList of Graduates
        Iterator<KeyValueVersion> iterator = store.storeIterator(Direction.UNORDERED, 0, key, null, null);
        while (iterator.hasNext()) {
            Key tempKey1 = iterator.next().getKey();
            String ID = new String(tempKey1.getMajorPath().get(1));
            String firstName = new String(store.get(tempKey1).getValue().getValue());
            Key tempKey2 = iterator.next().getKey();
            String email = new String(store.get(tempKey2).getValue().getValue());
            Key tempKey3 = iterator.next().getKey();
            String lastName = new String(store.get(tempKey3).getValue().getValue());

            // add current graduate to grads
            Graduates g = new Graduates();
            g.setID(ID);
            g.setFirstName(firstName);
            g.setLastName(lastName);
            g.setEmail(email);
            grads.add(g);

            System.out.println(g.getID() + " " + g.getFirstName() + " " + g.getLastName() + " " + g.getEmail());
        }

        // sort Graduates alphabetically, by last name
        Collections.sort(grads, new Comparator<Graduates>() {
            @Override
            public int compare(Graduates g1, Graduates g2) {
                return g1.getLastName().compareTo(g2.getLastName());
            }
        });

        // return results
        for (int i = 0; i < grads.size(); i++) {
            System.out.println(grads.get(i).getFirstName() + " " + grads.get(i).getLastName());
        }

        store.close();
    }
}