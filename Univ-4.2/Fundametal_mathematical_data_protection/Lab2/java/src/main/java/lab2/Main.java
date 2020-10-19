package lab2;

public class Main {

    static double[][] inputMatrix0 = new double[][]{new double[]{0.4, 0.1, 0.5}, new double[]{0.1, 0.6, 0.3}, new double[]{0.3, 0.5, 0.2}};
    static double[][] inputVector0 = new double[][]{new double[]{0.4,0.2,0.4}};

    static double[][] inputMatrix =
        new double[][] {
            new double[] {0.1, 0.4, 0.5},
            new double[] {0.2, 0.5, 0.3},
            new double[] {0.7, 0.2, 0.1}};

    static double[][] inputVector = new double[][]{new double[]{0.2,0.4,0.4}};

    public static void main(String[] args) {
        int runs = 1000000;
        Runners.setRuns(runs);
//        Runners.printResults();

        Runners.setInputs(inputMatrix, inputVector);

        System.out.println("\n---------------EJML---------------");
        Runners.EJML.run();

        System.out.println("\n---------------ApacheCommons---------------");
        Runners.ApacheCommons.run();

        System.out.println("\n---------------LA4J---------------");
        Runners.LA4J.run();

//        System.out.println("\n---------------ND4J---------------");
//        Runners.ND4J.run();

        System.out.println("\n---------------Colt---------------");
        Runners.Colt.run();

        System.out.println("\n---------------Self Made---------------");
        Runners.SelfMade.run();


    }
}
