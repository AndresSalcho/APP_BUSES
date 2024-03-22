import 'package:mssql_connection/mssql_connection.dart';
import 'dart:async';

class DB {
  String server = "";
  String port = "";
  String db = "";
  String user = "";
  String pass = "";
  MssqlConnection sql = MssqlConnection.getInstance();

  DB(String ip, String p, String d, String u, String ps) {
    server = ip;
    port = p;
    db = d;
    user = u;
    pass = ps;
  }

  conect() async {
    try {
      bool conected = await sql.connect(
          ip: server,
          port: port,
          databaseName: db,
          username: user,
          password: pass,
          timeoutInSeconds: 15);
      query();
      return conected;
    } catch (exeption) {
      return 0;
    }
  }

  disconect() async {
    bool isDisconected = await sql.disconnect();
    return isDisconected;
  }

  query() async {
    String res = await sql.writeData("exec dbo.insertion 'jsadasd', 'jose'");
    return res;
  }
}
