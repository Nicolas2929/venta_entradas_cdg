import Http from "../Http";

const Name = "venta";

const getAll = () => {
    var str = sessionStorage.getItem("carrito");
    if (!str) return {};
    return JSON.parse(str);
}

const registro = (data) => {
    var carrito_data = getAll();
    carrito_data[data.key] = data;
    sessionStorage.setItem("carrito", JSON.stringify(carrito_data));
}
const eliminar = (key) => {
    var carrito_data = getAll();
    delete carrito_data[key];
    sessionStorage.setItem("carrito", JSON.stringify(carrito_data));
}


export default {
    getAll,
    registro,
    eliminar
};