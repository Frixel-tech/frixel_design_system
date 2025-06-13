import * as L from "../../vendor/leaflet";

const LeafletHook = {
    mounted() { this.renderMap() },
    updated() { this.renderMap() },
    getLattitude() { return this.el.dataset.lattitude },
    getLongitude() { return this.el.dataset.longitude },
    renderMap() {
        const coordinates = [this.getLattitude(), this.getLongitude()];
        let map = L.map(this.el.id).setView(coordinates, 15);

        let frixelIcon = L.icon({
            iconUrl: "https://res.cloudinary.com/dekpcimmm/image/upload/v1745940105/frixel_logo_hfa7gn.svg", iconSize: [30, 30]
        })

        L.marker(coordinates, { icon: frixelIcon }).addTo(map);

        L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 19,
            attribution: '&copy; <a href="https://openstreetmap.org/copyright">OpenStreetMap</a>'
        }).addTo(map);
    }
};

export default LeafletHook;