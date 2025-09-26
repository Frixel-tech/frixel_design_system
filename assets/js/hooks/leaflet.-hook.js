import * as L from "../../vendor/leaflet";

const LeafletHook = {
    mounted() { this.renderMap() },
    updated() { this.renderMap() },
    getIconUrl() { return this.el.dataset.markerIconUrl },
    getLattitude() { return this.el.dataset.lattitude },
    getLongitude() { return this.el.dataset.longitude },
    getIconSize() {
        const size = this.el.dataset.markerIconSize;
        if (!size) return [30, 30]; // valeur par défaut
        try {
            return [size, size]; // ex: '[40, 40]' dans le dataset
        } catch {
            return [30, 30];
        }
    },
    renderMap() {
        const pointerUrl = this.getIconUrl();
        const coordinates = [this.getLattitude(), this.getLongitude()];
        let map = L.map(this.el.id).setView(coordinates, 15);

        let frixelIcon = L.icon({
            iconUrl: pointerUrl, iconSize: this.getIconSize()
        })

        L.marker(coordinates, { icon: frixelIcon }).addTo(map);

        L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 19,
            attribution: '&copy; <a href="https://openstreetmap.org/copyright">OpenStreetMap</a>'
        }).addTo(map);
    }
};

export default LeafletHook;
