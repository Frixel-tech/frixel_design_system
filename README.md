# Frixel Design System

**Frixel Design System** est une librairie Elixir/Phoenix qui fournit une collection de composants front-end réutilisables, conçue pour garantir une cohérence visuelle et une excellente expérience développeur.

Elle est pensée pour s’intégrer facilement à vos projets Phoenix LiveView.

## ✨ Fonctionnalités

- ✅ Composants prêts à l'emploi
  - `dropdown_menu`
  - `theme_switcher`
  - `branding`
  - `header`
  - `footer`
  - `scrollable_links`
  - `primary_button`
  - `secondary_button`
  - `primary_button`
  - `close_button`
  - ...et bien d’autres !

⚡️ Optimisé pour Phoenix LiveView

## 🚀 Installation

- Ajoutez la dépendance dans votre fichier `mix.exs` :

```elixir
def deps do
  [
    ...
    {:frixel_design_system, github: "Frixel-tech/frixel_design_system"}
  ]
end
```

**NB**: Si vous souhaitez installer la librairie depuis une branche spécifique :

```elixir
def deps do
  [
    ...
    {:frixel_design_system, github: "Frixel-tech/frixel_design_system", branch: "nom_de_la_branche"}
  ]
end
```

- Ensuite, il faudra mettre à jour vos dépendances :
```shell
$ mix deps.get
```

- Dans le fichier `config/runtime.exs`, la configuration suivante est nécessaire afin de pouvoir récupérer toutes les images stockées dans Cloudinary:
```elixir
config :frixel_design_system, :cloudinary,
  api_base_url: System.get_env("CLOUDINARY_API_BASE_URL"),
  cloud_name: System.get_env("CLOUDINARY_CLOUD_NAME"),
  api_key: System.get_env("CLOUDINARY_API_KEY"),
  api_secret: System.get_env("CLOUDINARY_API_SECRET")
```

- Pour que le CSS soit correctement compilé, il faut ajouter la ligne suivante sous les imports du fichier `assets/css/app.css` :
```diff
@source "../css";
@source "../js";
@source "../../lib/your_app_web";
+ @source "../../deps/frixel_design_system/**/*.ex*";
```

- De même pour le CSS de la dépendance Leaflet, ajouter dans les imports du même fichier :
```diff
+ @import "../../deps/frixel_design_system/assets/css/leaflet.css";
```

- Enfin, pour que les hooks JavaScript fonctionnent, il faut ajouter la ligne suivante dans les imports du fichier `assets/js/app.js` :
```diff
import hooks from "./hooks";
+ import FrixelHooks from "../../deps/frixel_design_system/assets/js/hooks";
```
Puis modifier l'attribut `hooks` dans les option de la LiveSocket générée par Phoenix:
```diff
- hooks: hooks,
+ hooks: Object.assign(hooks, FrixelHooks),
```

- Exemples d'utilisation :

```elixir
...
  <Button.close_button for={"modal-id"} />
...
```

```elixir
...
  <Project.project_modal
    id="modal-id"
    img_src="image/src/path"
    title="Titre de la modale"
    long_description=""
    tags={["tag-1", "tag-2", ...]}
    participants={[%{name: "name", link: "https://linkedin.fr/toto", img: "url_of_image"}, ...]}
    tools={[%{name: "name", website_link: "https://linkedin.fr/toto", logo_url: "url_of_image"}, ...]}
    link="https://www.linktotheProject.fr"
  />
...
```

## 🧑‍💻 Auteur

Développé et maintenu par l’équipe **Frixel**.


## 🤝 Contribuer

Les contributions sont les bienvenues ! N’hésitez pas à ouvrir une issue ou une pull request.

## Learn more

* Official website: https://www.frixel.fr/
* Our Github: https://github.com/Frixel-tech
