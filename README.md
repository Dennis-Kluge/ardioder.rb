# Ardioder.rb
Give your [IKEA Dioder](http://www.ikea.com/us/en/catalog/products/20119418/) an API and small web fronted. The project uses an Arduino Uno which talks to Dioder via Serial. The protocol definition and implementation is located in a separated [repository] (https://github.com/HorstMumpitz/ardioder). Detailed Schematics for the Hardware can be found at [Nerd++] (http://ikennd.ac/blog/2011/09/arduino-dioder-part-one/)

## Getting Started
Just clone the repository rename config.yml.smpl to config.yml and adapt it to your configuration. Run the project with `ruby ardioder.rb`. That's it. 

## API 
The API is pretty simple and assumes that two strips are connected. 

### Turn light on and off
To turn both strips on / off. Call the following URIs via POST:
`/light/on`
`/light/off`

### Turn a single strip on and off
Same procedure just add the id 0 or 1:
`/light/:id/on`
`/light/:id/off`

### Choose random colors 
Just POST to:
`/light/random`

### Define colors for each strip 
Send a JSON request defining the RGB values `{ "r": 100, "g": 50, "b": 25}` via POST to:
`/light/:id/color`
Partial updates are also possible.

## Contributions
Of course. Fork the repo and send me a pull request or report an issue. 