import javax.swing.Spring;
import java.util.Arrays;
import java.util.stream.IntStream;
import java.util.stream.Stream;

import static java.lang.Math.abs;

public class Main {
    static String abc = " єжзгоабвепрстуфхцчшдиіїйклмнщьюя.,?";
    static char[] abcCA = abc.toCharArray();

    static String text = "модифікування, поширювання або знищення інформації";

    public static int[][] init(){
        int[] ints = IntStream.rangeClosed(1, 36).toArray();
        int[][] table = new int[36][36];
        table[0]=ints;
        for (int row = 0; row < 6; row++) {
            for (int i = 0; i < 6; i++) {
                for (int j = 0; j < 6; j++) {
                    table[row+1][6*i+(j)] = table[row][6*i+((j+1) % 6)];
                }
            }
        }
        for (int step = 0; step < 5; step++) {
            for(int i = 0; i < 6; i++){
                for (int j = 0; j < 36; j++) {
                    table[((step+1)*6)+i][j] = table[(step*6)+i][(j+6) % 36];
                }
            }
        }
        return table;
    }

    public static void main(String[] args) {
        int[][] table = init();
        String res = encrypt("березень", table, abc, text);
        System.out.println(res);
        res = decrypt("березень", table, abc, res);
        System.out.println(res);

    }

    private static String encrypt(String key, int[][] table, String abc, String text) {
        key = key.repeat(Math.floorDiv(text.length(), key.length())+1);
        StringBuilder result = new StringBuilder();
        for (int i = 0; i < text.length(); i++) {
            int indexFromText = abc.indexOf(text.substring(i, i + 1));
            indexFromText = indexFromText == -1 ? 0: indexFromText;
            int i1 = table[indexFromText][abc.indexOf(key.substring(i, i + 1))];
            result.append(abc.substring(i1-1,i1));
        }
        return result.toString();

    }

    private static String decrypt(String key, int[][] table, String abc, String text) {
        key = key.repeat(Math.floorDiv(text.length(), key.length())+1);
        StringBuilder result = new StringBuilder();
        for (int i = 0; i < text.length(); i++) {
            int indexFromInput = abc.indexOf(text.substring(i, i + 1));
            int indexFromKey = abc.indexOf(key.substring(i, i + 1));
            int[] search = table[indexFromKey];
            int res=0;
            for (int j = 0; j < search.length; j++) {
                if (search[j]==indexFromInput+1){
                    res=j;
                    break;
                }
            }
            result.append(abc.substring(res,res+1));
        }
        return result.toString();

    }
}
