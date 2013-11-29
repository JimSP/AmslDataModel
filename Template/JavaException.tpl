package ${PACKAGE};

public class ${CLASS_NAME} extends Exception {

	private static final long serialVersionUID = ${SERIAL_VERION_ID}L;

	public ${CLASS_NAME}() {
		super();
	}
	public ${CLASS_NAME}(String message, Throwable thr) {
		super(message, thr);
	}
	public ${CLASS_NAME}(String message) {
		super(message);
	}

	public ${CLASS_NAME}(Throwable thr) {
		super(thr);
	}
}