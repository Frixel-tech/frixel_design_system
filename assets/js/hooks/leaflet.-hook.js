import * as L from "../../vendor/leaflet";

const LeafletHook = {
    mounted() { this.renderMap() },
    updated() { this.renderMap() },
    getIconUrl() { return this.el.dataset.markerIconUrl },
    getLattitude() { return this.el.dataset.lattitude },
    getLongitude() { return this.el.dataset.longitude },
    renderMap() {
        const pointerUrl = this.getIconUrl();
        const coordinates = [this.getLattitude(), this.getLongitude()];
        let map = L.map(this.el.id).setView(coordinates, 13);

        let frixelIcon = L.icon({
            iconUrl: pointerUrl, iconSize: [30, 30]
        })

        L.marker(coordinates, { icon: frixelIcon }).addTo(map);

        L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 19,
            attribution: '&copy; <a href="https://openstreetmap.org/copyright">OpenStreetMap</a>'
        }).addTo(map);
    }
};

export default LeafletHook;