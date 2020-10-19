import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class Ceeesaaaar {

    static List<String> abc =
        List.of("а", "б", "в", "г", "д", "е", "є", "ж", "з", "ї", "й", "к", "л", "м", "п", "р", "н", ";", "\"", "о",
                "и", "і", "с", "т", "у", "ф", "х", "ц", ".", "—", ",", "-", "(", "ч", "ш", "щ", "ь", "ю", "я", "_", ")",
                "'", ":");
    static String abcStr = abc.stream().collect(Collectors.joining());

    static String input = ",ейї;емїф—ще(їе;с,фгкї(—е\"щек—тїми.к.еїй.ечс—-ф.юет,ме:ї-";
    static String[] inputList = input.split("(?!^)");


    public static void main(String[] args) {
        for (int i = 0; i < abc.size()+1; i++) {
            String result="";
            for (int j = 0; j < input.length(); j++) {
                int I = i;
                result = Stream.of(inputList).map(x -> abc.get((abcStr.indexOf(x) + I) % abc.size())).collect(Collectors.joining());
            }
            System.out.println(i+": "+result);
        }
    }
}
