// @ts-check
import { defineConfig } from "astro/config";
import starlight from "@astrojs/starlight";
import tailwindcss from "@tailwindcss/vite";

export default defineConfig({
  site: "https://voxi0.github.io/",
  base: "/NixDots/",
	vite: {plugins: [tailwindcss()]},
  integrations: [
		starlight({
			favicon: "src/content/assets/logo.svg",
			title: "NixDots",
			logo: {src: "./src/content/assets/logo.svg", replacesTitle: false},
			customCss: ["./src/styles/global.css"],
			editLink: {baseUrl: "https://github.com/Voxi0/NixDots/tree/main/docs/"},
			credits: true,
			social: [
				{ icon: "github", label: "GitHub", href: "https://github.com/Voxi0/NixDots/" },
				{ icon: "discord", label: "Discord", href: "https://discord.com/users/1016332310741799054/" },
			],
			sidebar: [
				{
					label: "Getting Started",
					autogenerate: { directory: "getting-started", collapsed: true },
					collapsed: false,
				},
			],
		}),
	],
});
