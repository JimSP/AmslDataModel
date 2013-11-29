package ${PACKAGE_EXCEPTION};

import java.sql.SQLException;

public class DaoException extends SQLException {

	private static final long serialVersionUID = 1383840353189L;

	public DaoException() {
		super();
	}
	public DaoException(String message, Throwable thr) {
		super(message);
        super.initCause(thr);
	}
	public DaoException(String message) {
		super(message);
	}

	public DaoException(Throwable thr) {
		super();
        super.initCause(thr);
	}
}