// @ts-check
import { defineConfig } from "astro/config";
import starlight from "@astrojs/starlight";

// https://astro.build/config
export default defineConfig({
	site: "https://voxi0.github.io",
  base: "/NixDots/",
	integrations: [
		starlight({
			title: "NixDots",
			social: [
				{ icon: "github", label: "GitHub", href: "https://github.com/Voxi0/NixDots/" }
			],
			sidebar: [
				{
					label: "Getting Started",
					autogenerate: { directory: "guides/getting-started", collapsed: true },
					collapsed: false,
				},
			],
		}),
	],
});
