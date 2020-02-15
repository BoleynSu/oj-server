package su.boleyn.oj.server;

public class Config {
	static String getOrElse(String name, String defaultValue) {
		return System.getProperty(name, defaultValue);
	}

	static String getOrFail(String name) {
		String ret = System.getProperty(name);
		if (ret == null) {
			throw new RuntimeException(name + " must be set");
		}
		return ret;
	}

	static final String ADDRESS = getOrElse("ADDRESS", "0.0.0.0");
	static final int PORT = Integer.parseInt(getOrElse("PORT", "8080"));
	static final String DB_HOST = getOrElse("DB_HOST", "localhost");
	static final String DB_NAME = getOrElse("DB_NAME", "online_judge");
	static final String DB_USER = getOrFail("DB_USER");
	static final String DB_PASSWD = getOrFail("DB_PASSWD");
	static final String DATA_PATH = getOrFail("DATA");
	static final String ADMIN_ACCOUNT = "boleynsu";
}
