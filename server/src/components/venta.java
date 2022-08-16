package components;

import java.sql.SQLException;

import org.json.JSONArray;
import org.json.JSONObject;

import Servisofts.SPGConect;
import Servisofts.SUtil;

public class venta {
    public static final String COMPONENT = "venta";

    public static void onMessage(JSONObject obj) {
        try {
            switch (obj.getString("type")) {
                case "registro":
                    registro(obj);
                    break;
                case "editar":
                    editar(obj);
                    break;
                case "getAll":
                    getAll(obj);
                    break;
                case "getByKey":
                    getByKey(obj);
                    break;
            }
        } catch (Exception e) {
            obj.put("estado", "error");
            obj.put("error", e.getMessage());
        }
    }

    public static void registro(JSONObject obj) throws SQLException {
        JSONObject data = obj.getJSONObject("data");
        JSONObject detalle = data.getJSONObject("detalle");
        data.remove("detalle");
        data.put("key", SUtil.uuid());
        data.put("fecha_on", SUtil.now());
        data.put("estado", 1);
        SPGConect.insertObject(COMPONENT, data);

        detalle.keys().forEachRemaining(key -> {
            JSONObject item = detalle.getJSONObject(key);
            for (int i = 0; i < item.getInt("cantidad"); i++) {
                JSONObject ticket = new JSONObject();
                ticket.put("key_sector", item.getString("key"));
                ticket.put("descripcion", item.getString("detalle"));
                ticket.put("key_venta", data.getString("key"));
                ticket.put("key_usuario", data.getString("key_usuario"));
                ticket.put("key", SUtil.uuid());
                ticket.put("fecha_on", SUtil.now());
                ticket.put("estado", 1);
                try {
                    SPGConect.insertObject("ticket", ticket);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }

        });
        obj.put("key", data.getString("key"));
        getByKey(obj);
        obj.put("estado", "exito");
    }

    public static void editar(JSONObject obj) throws SQLException {
        JSONObject data = obj.getJSONObject("data");
        SPGConect.editObject(COMPONENT, data);
        obj.put("data", data);
        obj.put("estado", "exito");
    }

    public static void getAll(JSONObject obj) throws SQLException {
        JSONArray arr = SPGConect
                .ejecutarConsultaArray(
                        "SELECT array_to_json(array_agg(" + "view_venta_detalle" + ".*)) as json FROM "
                                + "view_venta_detalle" + "");
        obj.put("data", arr);
        obj.put("estado", "exito");
    }

    public static void getByKey(JSONObject obj) throws SQLException {
        JSONObject arr = SPGConect
                .ejecutarConsultaObject(
                        "SELECT to_json(" + "view_venta_detalle" + ".*) as json FROM " + "view_venta_detalle"
                                + " WHERE key = '"
                                + obj.getString("key") + "'");
        obj.put("data", arr);
        obj.put("estado", "exito");
    }
}
