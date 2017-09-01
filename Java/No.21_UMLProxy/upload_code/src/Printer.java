public class Printer implements Printable {
	private String name;

	public Printer() {
		heavyJob("Creating Printer's instance ");
	}

	public Printer(String name) {
		this.name = name;
		heavyJob("Creating Printer's instance (" + name + ") ");
	}

	public void setPrinterName(String name) {
		this.name = name;
	}

	public String getPrinterName() {
		return name;
	}

	public void print(String string) {
		System.out.println("===" + name + "===");
		System.out.println(string);
	}

	private void heavyJob(String msg) {
		System.out.print(msg);
		for (int i = 0; i < 5; i++) {
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
			}
			System.out.print(".");
		}
		System.out.println(" End.");
	}
}
