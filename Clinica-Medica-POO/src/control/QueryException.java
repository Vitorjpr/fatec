package control;

public class QueryException extends Exception {
	public QueryException() {
	}

	public QueryException(String arg0) {
		super(arg0);
	}

	public QueryException(Throwable arg0) {
		super(arg0);
	}

	public QueryException(String arg0, Throwable arg1) {
		super(arg0, arg1);
	}

	public QueryException(String arg0, Throwable arg1, boolean arg2, boolean arg3) {
		super(arg0, arg1, arg2, arg3);
	}
}