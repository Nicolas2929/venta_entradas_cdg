import Http from "../Http";

const Name = "report";

const getAll = (view, callback) => {
    Http.POST({
        "component": Name,
        "type": "getAll",
        "view": view,
    }, callback)
}
export default {
    getAll,
};