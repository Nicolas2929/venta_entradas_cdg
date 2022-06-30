import org.json.JSONObject;

import Server.SSSAbstract.SSSessionAbstract;
import components.evento;
import components.orden_pago;
import components.sector;
import components.ticket;
import components.usuario;
import components.venta;

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
            case ticket.COMPONENT:
                 ticket.onMessage(obj);
                 break;
            case venta.COMPONENT:
                 venta.onMessage(obj);
                 break;
            case orden_pago.COMPONENT:
                 orden_pago.onMessage(obj);
                 break;


            default:

                obj.put("estado", "error");
                obj.put("error", "componente no declarado");
        }
    }
}
