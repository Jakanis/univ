package lab2;

import cern.colt.matrix.DoubleFactory2D;
import cern.colt.matrix.DoubleMatrix2D;
import cern.colt.matrix.linalg.Algebra;
import org.apache.commons.math3.linear.Array2DRowRealMatrix;
import org.apache.commons.math3.linear.RealMatrix;
import org.ejml.simple.SimpleMatrix;
import org.la4j.Matrix;
import org.la4j.matrix.dense.Basic2DMatrix;
import org.nd4j.linalg.api.ndarray.INDArray;
import org.nd4j.linalg.factory.Nd4j;
import org.slf4j.Logger;

import java.util.Arrays;

public class Runners {
    static double[][] inputMatrix;

    static double[][] inputVector;

    private static boolean results = false;

    private static int runs = 1;

    public static void printResults() {
        results = true;
    }

    public static void setRuns(int n) {
        runs = n;
    }

    public static void setInputs(double[][] matrix, double[][] vector) {
        inputMatrix = matrix;
        inputVector = vector;
    }


    public static class EJML {
        public static void run() {
            long startTime = System.nanoTime();
            for (int i = runs; --i >= 0; ) {
                SimpleMatrix p0 = new SimpleMatrix(inputVector);
                SimpleMatrix p = new SimpleMatrix(inputMatrix);

                SimpleMatrix p2 = p.mult(p);
                SimpleMatrix p3 = p2.mult(p);
                SimpleMatrix p4 = p3.mult(p);
                SimpleMatrix p0p3 = p0.mult(p3);
                SimpleMatrix p0p4 = p0.mult(p4);
                if (results) {
                    System.out.println("p2:\n" + p2);
                    System.out.println("p3:\n" + p3);
                    System.out.println("p4:\n" + p4);
                    System.out.println("p0p3:\n" + p0p3);
                    System.out.println("p0p4:\n" + p0p4);
                }
            }
            long endTime = System.nanoTime();
            long res = (endTime - startTime);
            System.out.println(runs + " runs in " + res + " ns");
            System.out.println("Average run = " + res / runs + " ns");
        }
    }


    public static class ND4J {
        private static final Logger log = org.slf4j.LoggerFactory.getLogger(ND4J.class);

        public static void run() {
            long startTime = System.nanoTime();
            for (int i = runs; --i >= 0; ) {
                INDArray p0 = Nd4j.create(inputVector);
                INDArray p = Nd4j.create(inputMatrix);

                INDArray p2 = p.mmul(p);
                INDArray p3 = p2.mmul(p);
                INDArray p4 = p3.mmul(p);
                INDArray p0p3 = p0.mmul(p3);
                INDArray p0p4 = p0.mmul(p4);
                if (results) {
                    System.out.println("p2:\n" + p2);
                    System.out.println("p3:\n" + p3);
                    System.out.println("p4:\n" + p4);
                    System.out.println("p0p3:\n" + p0p3);
                    System.out.println("p0p4:\n" + p0p4);
                }
            }
            long endTime = System.nanoTime();
            long res = (endTime - startTime);
            System.out.println(runs + " runs in " + res + " ns");
            System.out.println("Average run = " + res / runs + " ns");
        }
    }


    public static class ApacheCommons {
        public static void run() {
            long startTime = System.nanoTime();
            for (int i = runs; --i >= 0; ) {
                RealMatrix p0 = new Array2DRowRealMatrix(inputVector);
                RealMatrix p = new Array2DRowRealMatrix(inputMatrix);

                RealMatrix p2 = p.multiply(p);
                RealMatrix p3 = p2.multiply(p);
                RealMatrix p4 = p3.multiply(p);
                RealMatrix p0p3 = p0.multiply(p3);
                RealMatrix p0p4 = p0.multiply(p4);
                if (results) {
                    System.out.println("p2:\n" + p2);
                    System.out.println("p3:\n" + p3);
                    System.out.println("p4:\n" + p4);
                    System.out.println("p0p3:\n" + p0p3);
                    System.out.println("p0p4:\n" + p0p4);
                }
            }
            long endTime = System.nanoTime();
            long res = (endTime - startTime);
            System.out.println(runs + " runs in " + res + " ns");
            System.out.println("Average run = " + res / runs + " ns");
        }
    }


    public static class LA4J {
        public static void run() {
            long startTime = System.nanoTime();
            for (int i = runs; --i >= 0; ) {
                Matrix p0 = new Basic2DMatrix(inputVector);
                Matrix p = new Basic2DMatrix(inputMatrix);

                Matrix p2 = p.multiply(p);
                Matrix p3 = p2.multiply(p);
                Matrix p4 = p3.multiply(p);
                Matrix p0p3 = p0.multiply(p3);
                Matrix p0p4 = p0.multiply(p4);
                if (results) {
                    System.out.println("p2:\n" + p2);
                    System.out.println("p3:\n" + p3);
                    System.out.println("p4:\n" + p4);
                    System.out.println("p0p3:\n" + p0p3);
                    System.out.println("p0p4:\n" + p0p4);
                }
            }
            long endTime = System.nanoTime();
            long res = (endTime - startTime);
            System.out.println(runs + " runs in " + res + " ns");
            System.out.println("Average run = " + res / runs + " ns");
        }
    }


    public static class Colt {
        public static void run() {
            DoubleFactory2D dense = DoubleFactory2D.dense;
            Algebra algebra = new Algebra();
            long startTime = System.nanoTime();
            for (int i = runs; --i >= 0; ) {
                DoubleMatrix2D p0 = dense.make(inputVector);
                DoubleMatrix2D p = dense.make(inputMatrix);

                DoubleMatrix2D p2 = algebra.mult(p, p);
                DoubleMatrix2D p3 = algebra.mult(p2, p);
                DoubleMatrix2D p4 = algebra.mult(p3, p);
                DoubleMatrix2D p0p3 = algebra.mult(p0, p3);
                DoubleMatrix2D p0p4 = algebra.mult(p0, p4);
                if (results) {
                    System.out.println("p2:\n" + p2);
                    System.out.println("p3:\n" + p3);
                    System.out.println("p4:\n" + p4);
                    System.out.println("p0p3:\n" + p0p3);
                    System.out.println("p0p4:\n" + p0p4);
                }
            }
            long endTime = System.nanoTime();
            long res = (endTime - startTime);
            System.out.println(runs + " runs in " + res + " ns");
            System.out.println("Average run = " + res / runs + " ns");
        }
    }


    public static class SelfMade {
        static double multCell(double[][] firstMatrix, double[][] secondMatrix, int row, int col) {
            double cell = 0;
            for (int i = 0; i < secondMatrix.length; i++) {
                cell += firstMatrix[row][i] * secondMatrix[i][col];
            }
            return cell;
        }

        static double[][] mmult(double[][] firstMatrix, double[][] secondMatrix) {
            double[][] result = new double[firstMatrix.length][secondMatrix[0].length];

            for (int row = 0; row < result.length; row++) {
                for (int col = 0; col < result[row].length; col++) {
                    result[row][col] = multCell(firstMatrix, secondMatrix, row, col);
                }
            }

            return result;
        }

        public static void run() {
            long startTime = System.nanoTime();
            for (int i = runs; --i >= 0; ) {

                double[][] p0 = inputVector;
                double[][] p = inputMatrix;

                double[][] p2 = mmult(p, p);
                double[][] p3 = mmult(p2, p);
                double[][] p4 = mmult(p3, p);
                double[][] p0p3 = mmult(p0, p3);
                double[][] p0p4 = mmult(p0, p4);
                if (results) {
                    System.out.println("p2:\n" + Arrays.deepToString(p2));
                    System.out.println("p3:\n" + Arrays.deepToString(p3));
                    System.out.println("p4:\n" + Arrays.deepToString(p4));
                    System.out.println("p0p3:\n" + Arrays.deepToString(p0p3));
                    System.out.println("p0p4:\n" + Arrays.deepToString(p0p4));
                }
            }
            long endTime = System.nanoTime();
            long res = (endTime - startTime);
            System.out.println(runs + " runs in " + res + " ns");
            System.out.println("Average run = " + res / runs + " ns");
        }
    }
}
