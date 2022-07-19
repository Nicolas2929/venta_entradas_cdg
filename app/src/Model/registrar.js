import Http from "../Http";

const Name = "registro";

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

export default {
    getAll,
    getByKey,
    registro,
    editar
};