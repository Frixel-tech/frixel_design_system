import * as L from "../../vendor/leaflet";

const LeafletHook = {
    mounted() { this.renderMap(); console.log(this.getLattitude()); console.log(this.getLongitude()) },
    updated() { this.renderMap(); console.log(this.getLattitude()); console.log(this.getLongitude()) },
    getIconUrl() { return this.el.dataset.markerIconUrl },
    getIconSize() { return this.el.dataset.markerIconSize },
    getLattitude() { return this.el.dataset.lattitude },
    getLongitude() { return this.el.dataset.longitude },
    renderMap() {
        const pointerUrl = this.getIconUrl();
        const coordinates = [this.getLattitude(), this.getLongitude()];
        let map = L.map(this.el.id).setView(coordinates, 15);

        const iconSize = this.getIconSize();
        const parsedIconSize = Array.isArray(iconSize) ? iconSize : [iconSize, iconSize];

        let frixelIcon = L.icon({
            iconUrl: pointerUrl,
            iconSize: parsedIconSize,
            iconAnchor: [parsedIconSize[0] / 2, parsedIconSize[1]], // Center horizontally, bottom vertically
            popupAnchor: [0, -parsedIconSize[1]] // Popup appears above the icon
        })

        let marker = L.marker(coordinates, { icon: frixelIcon }).addTo(map);

        L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 19,
            attribution: '&copy; <a href="https://openstreetmap.org/copyright">OpenStreetMap</a>'
        }).addTo(map);
    }
};

export default LeafletHook;
