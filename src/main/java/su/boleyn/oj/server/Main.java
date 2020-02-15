package su.boleyn.oj.server;

import java.io.File;

import org.apache.catalina.connector.Connector;
import org.apache.catalina.startup.Tomcat;

public class Main extends Config {
	public static void main(String[] args) throws Exception {
		String webappDirLocation = "./webapp/";
		Tomcat tomcat = new Tomcat();
		Connector connector = new Connector();
		connector.setProperty("address", ADDRESS);
		connector.setPort(PORT);
		tomcat.setConnector(connector);
		tomcat.addWebapp("", new File(webappDirLocation).getAbsolutePath());
		tomcat.start();
		tomcat.getServer().await();
	}
}