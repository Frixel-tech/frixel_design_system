const GetAndStoreThemeHook = {
    storageKey: "theme-preference",
    systemDarkTheme: window.matchMedia('(prefers-color-scheme: dark)'),
    getSunIcon() { return this.el.querySelector("#sun-icon") },
    getMoonIcon() { return this.el.querySelector("#moon-icon") },
    getThemeSelector() { return this.el.querySelector("input.theme-controller[type='checkbox']") },
    mounted() { this.getAndSetTheme() },
    updated() { this.getAndSetTheme() },
    getAndSetTheme() {
        let selectedTheme = this.getSelectedTheme();
        document.documentElement.setAttribute("data-theme", selectedTheme);

        const themeSelector = this.getThemeSelector();
        this.buildThemeInput(themeSelector, selectedTheme);

        // if the user changes its system preferences 
        // (only if no theme is yet selected)
        this.systemDarkTheme.addEventListener("change", _ => {
            if (!localStorage.getItem(this.storageKey)) {
                selectedTheme = this.getSelectedTheme();
                document.documentElement.setAttribute("data-theme", selectedTheme);
            }
        });

        themeSelector.addEventListener("set-theme-locally", e => {
            // on click we change the value of the root tag `data-theme` attribute
            // then store it into local storage ;
            // the value still depends on the selected theme
            const value = selectedTheme === "dark" ?
                (e.target.checked ? "light" : "dark") :
                (e.target.checked ? "dark" : "light");

            document.documentElement.setAttribute("data-theme", value);

            localStorage.setItem(this.storageKey, value);
        });
    },
    getSelectedTheme() {
        // If a theme exists inside local storage we use it, 
        // if not we use system preference (prefers-color-scheme)
        return localStorage.getItem(this.storageKey) ||
            (this.systemDarkTheme.matches ? "dark" : "light");
    },
    buildThemeInput(themeSelector, selectedTheme) {
        // this function is used to dynamically set the checkbox input value 
        // depending on the selected theme (or system preference) ;
        // it also sets the starting icon for the swaping input
        const sunIcon = this.getSunIcon();
        const moonIcon = this.getMoonIcon();

        if (selectedTheme === "dark") {
            themeSelector.value = "light";

            sunIcon.classList.remove("swap-on");
            moonIcon.classList.remove("swap-off");
            sunIcon.classList.add("swap-off");
            moonIcon.classList.add("swap-on");
        } else {
            themeSelector.value = "dark";

            sunIcon.classList.remove("swap-off");
            moonIcon.classList.remove("swap-on");
            sunIcon.classList.add("swap-on");
            moonIcon.classList.add("swap-off");
        }
    }
}

export default GetAndStoreThemeHook;