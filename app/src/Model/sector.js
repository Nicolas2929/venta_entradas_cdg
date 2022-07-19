import Http from "../Http";

const Name = "sector";

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

const getByKeyEvento = (key_evento, callback) => {
    Http.POST({
        "component": Name,
        "type": "getAll"
    }, (resp) => {
        var data = resp.data;
        resp.data = data.filter(obj => obj.key_evento == key_evento)
        callback(resp);
    })
}
export default {
    getAll,
    getByKey,
    registro,
    editar,
    getByKeyEvento
};