package su.boleyn.oj.server;

import java.io.File;

import org.apache.catalina.connector.Connector;
import org.apache.catalina.startup.Tomcat;

import su.boleyn.oj.core.Config;

public class Main extends Config {
	static final String ADDRESS = getOrElse("ADDRESS", "0.0.0.0");
	static final int PORT = Integer.parseInt(getOrElse("PORT", "8080"));

	public static void main(String[] args) throws Exception {
		Tomcat tomcat = new Tomcat();
		Connector connector = new Connector();
		connector.setProperty("address", ADDRESS);
		connector.setPort(PORT);
		tomcat.setConnector(connector);
		tomcat.addWebapp("", new File("./webapp").getAbsolutePath());
		tomcat.start();
		tomcat.getServer().await();
	}
}