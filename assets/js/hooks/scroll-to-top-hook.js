const ScrollToTopHook = {
    anchorTargetId() { return this.el.dataset.targetId },
    mounted() { this.initAnchor() },
    updated() { this.initAnchor() },
    initAnchor() {
        window.addEventListener("scroll", _ => this.toggleAnchor());
        this.toggleAnchor();
    },
    toggleAnchor() {
        const target = document.getElementById(this.anchorTargetId());

        if (!target) return;
        if (window.scrollY > 100) {
            this.el.style.display = "block";
        } else {
            this.el.style.display = "none";
        }
    }
};

export default ScrollToTopHook;