package jakanis.io;

import java.util.List;
import static java.lang.Math.abs;

public class Main {
    static String abc = "єжзгдиіїйклмноабвепрстуфх(;\"цчш)':щьюя_.—,-";
    static String input = "ууюр'щ):ц,\"їнф((шю\"уід_цї'ур(ча):цх(гнп(:ш.'щйошк:шццсх\"р)";
    static List<String> keys = List.of("стратосфера","космос","водний","акваторія","океан","море","включає","віртуальний","вплив","особа","здатність");

    public static String decipher(String key, String text, String abc){
        String deciphering = key.repeat(Math.floorMod(text.length(), abc.length()));
        StringBuilder res = new StringBuilder();
        for (int i = 0; i < text.length(); i++)
            res=res.append(abc.charAt(abs((abc.indexOf(text.codePointAt(i)) - abc.indexOf(deciphering.codePointAt(i))) % abc.length())));
        return res.toString();
    }
    public static void main(String[] args) {
        for (String key:keys){
            System.out.println(key+": "+decipher(key, input, abc));
        }
    }
}
