package control;

public class PacienteException extends Exception {
	public PacienteException() {
	}

	public PacienteException(String arg0) {
		super(arg0);
	}

	public PacienteException(Throwable arg0) {
		super(arg0);
	}

	public PacienteException(String arg0, Throwable arg1) {
		super(arg0, arg1);
	}

	public PacienteException(String arg0, Throwable arg1, boolean arg2, boolean arg3) {
		super(arg0, arg1, arg2, arg3);
	}
}