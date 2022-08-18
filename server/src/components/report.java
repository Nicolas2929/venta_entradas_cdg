package components;

import java.sql.SQLException;

import org.json.JSONArray;
import org.json.JSONObject;

import Servisofts.SPGConect;
import Servisofts.SUtil;

public class report {
    public static final String COMPONENT = "report";

    public static void onMessage(JSONObject obj) {
        try {
            switch (obj.getString("type")) {
                case "getAll":
                    getAll(obj);
                    break;
            }
        } catch (Exception e) {
            obj.put("estado", "error");
            obj.put("error", e.getMessage());
        }
    }

    public static void getAll(JSONObject obj) throws SQLException {
        JSONArray arr = SPGConect
                .ejecutarConsultaArray(
                        "SELECT array_to_json(array_agg(data.*)) as json FROM " + obj.getString("view") + " data");
        obj.put("data", arr);
        obj.put("estado", "exito");
    }

}
