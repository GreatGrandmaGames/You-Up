public class charCheck {
	public static void main(String[] args) {
		if (args[0].length() >= 30)
		{
			System.out.println("!****!");
			System.out.println("MORE THAN 30");
			System.out.println(args[0].length());

		}
		else
		{
			System.out.println("GOOD TO GO");
			System.out.println(args[0].length());
		}
	}
}