import * as L from "../../vendor/leaflet";

const LeafletHook = {
    mounted() { this.renderMap() },
    updated() { this.renderMap() },
    getIconUrl() { return this.el.dataset.markerIconUrl },
    getIconSize() { return this.el.dataset.markerIconSize },
    getIconLattitude() { return this.el.dataset.markerIconLattitude },
    getIconLongitude() { return this.el.dataset.markerIconLongitude },
    getMapLattitude() { return this.el.dataset.mapLattitude },
    getMapLongitude() { return this.el.dataset.mapLongitude },
    getMapZoom() { return this.el.dataset.mapZoom },

    renderMap() {
        const pointerUrl = this.getIconUrl();
        const iconCoordinates = [this.getIconLattitude(), this.getIconLongitude()];
        const mapCoordinates = [this.getMapLattitude(), this.getMapLongitude()]
        let map = L.map(this.el.id).setView(mapCoordinates, 12);

        const iconSize = this.getIconSize();
        const parsedIconSize = Array.isArray(iconSize) ? iconSize : [iconSize, iconSize];

        let Icon = L.icon({
            iconUrl: pointerUrl,
            iconSize: parsedIconSize,
            iconAnchor: [parsedIconSize[0] / 2, parsedIconSize[1] / 2], // Center horizontally, center vertically
        })

        let marker = L.marker(iconCoordinates, { icon: frixelIcon }).addTo(map);

        L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 19,
            attribution: '&copy; <a href="https://openstreetmap.org/copyright">OpenStreetMap</a>'
        }).addTo(map);
    }
};

export default LeafletHook;
