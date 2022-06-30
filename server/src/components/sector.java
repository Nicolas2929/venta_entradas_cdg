package components;

import java.sql.SQLException;

import org.json.JSONArray;
import org.json.JSONObject;

import Servisofts.SPGConect;
import Servisofts.SUtil;

public class sector {
    public static final String COMPONENT = "sector";

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
        data.put("key", SUtil.uuid());
        data.put("fecha_on", SUtil.now());
        data.put("estado", 1);
        SPGConect.insertObject(COMPONENT, data);
        obj.put("data", data);
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
                        "SELECT array_to_json(array_agg(" + COMPONENT + ".*)) as json FROM " + COMPONENT + "");
        obj.put("data", arr);
        obj.put("estado", "exito");
    }

    public static void getByKey(JSONObject obj) throws SQLException {
        JSONObject arr = SPGConect
                .ejecutarConsultaObject(
                        "SELECT to_json(" + COMPONENT + ".*) as json FROM " + COMPONENT + " WHERE key = '"
                                + obj.getString("key") + "'");
        obj.put("data", arr);
        obj.put("estado", "exito");
    }
}
