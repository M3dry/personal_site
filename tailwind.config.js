/** @type {import('tailwindcss').Config} */
module.exports = {
    content: ["./templates/**/*.{jingoo, html}"],
    darkMode: 'class',
    theme: {
        fontFamily: {
            ubuntu: ["Ubuntu Nerd Font"],
        },
        extend: {
            colors: {
                "my-purple": "#c792ea",
                "my-purple-ish": "#a8b5f7",
                "my-red": "#ff5370",
                "my-orange": "#f78c6c",
                "my-blue": "#72a4ff",
                "my-yellow": "#ffcb6b",
                "my-light-blue": "#89ddff",
                "my-green": "#c3e88d",
                "my-gray": "#292d3e",
                "my-light-gray": "#3c435e",
                "my-white": "#eeffff",
                "my-black": "#0f111b",
            },
            spacing: {
                "5px": "5px",
            },
        },
    },
    plugins: [],
};
