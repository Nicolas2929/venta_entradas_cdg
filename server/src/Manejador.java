import org.json.JSONObject;

import Server.SSSAbstract.SSSessionAbstract;
import components.evento;
import components.sector;
import components.usuario;

public class Manejador {
    public static void onMessage(JSONObject obj, SSSessionAbstract session) {
        switch (obj.getString("component")) {
            case usuario.COMPONENT:
                usuario.onMessage(obj);
                break;
            case evento.COMPONENT:
                evento.onMessage(obj);
                break;
            case sector.COMPONENT:
                sector.onMessage(obj);
                break;
            default:
                obj.put("estado", "error");
                obj.put("error", "componente no declarado");
        }
    }
}
