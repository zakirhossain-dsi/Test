package literatePrimes;

public class PrimePrinter {
    public static void main(String[] args) {
        final int NUMBER_OF_PRIMES = 1000;
        int[] primes = PrimeGenerator.generate(NUMBER_OF_PRIMES);

        String header = "The First " + NUMBER_OF_PRIMES + " Prime Numbers";
        final int ROWS_PER_PAGE = 50;
        final int COLUMNS_PER_PAGE = 4;
        TablePrinter tablePrinter = new TablePrinter(ROWS_PER_PAGE, COLUMNS_PER_PAGE, header);
        tablePrinter.print(primes);
    }
}
