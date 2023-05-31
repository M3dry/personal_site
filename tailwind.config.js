/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [ "./templates/**/*.{jingoo, html}" ],
  theme: {
    fontFamily: {
      "ubuntu": [ "Ubuntu Nerd Font"]
    },
    extend: {
      colors: {
        "my-black": "#0f111b",
        "my-purple": "#c792ea",
        "my-red": "#ff5370",
        "my-blue": "#72a4ff",
        "my-white": "#eeffff",
      },
      spacing: {
        "5px": "5px",
      }
    },
  },
  plugins: [],
}
