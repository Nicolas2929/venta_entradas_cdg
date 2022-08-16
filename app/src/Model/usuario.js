import Http from "../Http";

const Name = "usuario";
const getAll = (callback) => {
    Http.POST({
        "component": Name,
        "type": "getAll"
    }, callback)
}
const getByKey = (key, callback) => {
    Http.POST({
        "component": Name,
        "type": "getByKey",
        "key": key
    }, callback)
}
const registro = (data, callback) => {
    Http.POST({
        "component": Name,
        "type": "registro",
        "data": data
    }, callback)
}

const editar = (data, callback) => {
    Http.POST({
        "component": Name,
        "type": "editar",
        "data": data
    }, callback)
}
const login = ({ correo, password }, callback) => {
    Http.POST({
        "component": Name,
        "type": "login",
        "data": {
            correo,
            password
        }
    }, (resp) => {
        if (resp.estado == "exito") {
            localStorage.setItem("usuario_log", JSON.stringify(resp.data));
        }
        if (callback) callback(resp)
    })
}
const cerrarSession = () => {
    localStorage.removeItem("usuario_log");
    localStorage.removeItem("carrito");
    
    window.location.href = "/login"
}
const getSession = () => {
    var usr = localStorage.getItem("usuario_log");
    if (!usr) return null;
    var obj = JSON.parse(usr);
    return obj;
}

export default {
    getAll,
    getByKey,
    registro,
    editar,
    login,
    getSession,
    cerrarSession
};