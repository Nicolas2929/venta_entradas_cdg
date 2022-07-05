import org.json.JSONObject;

import ServerHttp.ServerHttp;
import Servisofts.SConfig;
import Servisofts.SPGConect;
import Servisofts.Servisofts;

public class App {
    public static void main(String[] args) throws Exception {

        Servisofts.Manejador = Manejador::onMessage;
        ServerHttp.Start(8080);
        SPGConect.setConexion(SConfig.getJSON("data_base"));
    }
}
