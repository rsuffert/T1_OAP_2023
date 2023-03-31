import java.util.Scanner;

public class App {
    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        int m, n;

        System.out.print("Digite o valor de 'm': ");
        m = Integer.parseInt(in.nextLine());

        System.out.print("Digite o valor de 'n': ");
        n = Integer.parseInt(in.nextLine());

        System.out.printf("Resultado: %d\n", ackermann(m, n));

        in.close();
    }

    public static int ackermann(int m, int n) {
        if (m<0 || n<0) System.exit(1);
        
        if (m == 0) return n+1;
        else if (m>0 && n==0) return ackermann(m-1, 1);
        else return ackermann(m-1, ackermann(m, n-1));
    }
}
