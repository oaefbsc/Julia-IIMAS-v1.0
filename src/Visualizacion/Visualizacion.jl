### A Pluto.jl notebook ###
# v0.15.1

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ c89df96d-b0f3-40f0-948f-7c5be153bd09
using PlutoUI

# ╔═╡ 4db20192-4f4a-4202-886a-407c44b43960
begin
	using Colors
	@bind rojo Slider(0 : 0.1 : 1, show_value=true, default=0)
end

# ╔═╡ aa0963d0-95f2-45ce-b735-3df64174540f
using Plots

# ╔═╡ cc1ad821-1093-4376-a14e-906a25ebeb36
using LaTeXStrings

# ╔═╡ 5c60e077-2ef3-448d-a4d3-bb4a2d4c0138
using Distributions, StatsPlots

# ╔═╡ c77e9b70-7b3b-4ebf-a793-400ff61b774c
begin
	#using Pkg; Pkg.add("CSV")
	using CSV
	using DataFrames
	
	# reference: https://plot.ly/r/dumbbell-plots/
	# read Data into dataframe
	nm = tempname()
	url = "https://raw.githubusercontent.com/plotly/datasets/master/school_earnings.csv"
	download(url, nm)
	df = CSV.read(nm, DataFrame)
	rm(nm)
	
	# sort dataframe by male earnings
	df = sort(df, :Men, rev=false)
	
	men = scatter(df[!,:Men], df[!,:School], name="Men", color=:blue, marker_size=12, size = (800,800))
	yticks!(0.5:1:20.5, df[!,:School])
	women = scatter!(df[!,:Women], df[!,:School], name="Women",color=:pink, marker_size=12)
end

# ╔═╡ 67245814-54f5-4aae-84c5-3bee84d553f3
md"""# Notebok sobre Visualización

	- Oscar Alejando Esquivel Flores
	- Óscar Anuar Alvarado Morán
	- Mario Horacio Garrido Czacki
"""

# ╔═╡ b1e5cf34-0e79-4068-b0b1-737ecdb9c627
PlutoUI.TableOfContents(aside=true, title="👀 Visualización🔮")

# ╔═╡ 4a306fe9-7609-4702-ab87-6de99a759108
md"# Interactividad
Fuentes:
- [Github](https://github.com/fonsp/PlutoUI.jl)

- [JuliaHub](https://juliahub.com/docs/PlutoUI/abXFp/0.7.9/)

¡Aquí es donde pluto sacará a relucir sus habilidades! Cualquier cosa que pueda salir mal, será culpa nuestra."

# ╔═╡ 28534928-5027-4a1a-bf40-62cb420b93d2
varinfo(PlutoUI)

# ╔═╡ 73152cfe-bfb3-494f-922f-fd3b6ad77a37
md"## Sliders"

# ╔═╡ 041cd8b3-f392-4d08-a8ce-7bee92de4733
md"Ya sabemos vimos un poquito de sliders, juguemos un poco más."

# ╔═╡ be3afea7-02db-4466-a784-5c2eadf446d0
@bind slider1 Slider(0:5, show_value=true, default=0)

# ╔═╡ f9aeca95-86d6-41e7-8749-c6bb551a494f
begin
	cuadrado(x) = x^2
	intervalo = -5:0.1:5
	plot(intervalo, cuadrado.(intervalo), label = false)
	plot!([slider1 -slider1], [cuadrado(slider1) cuadrado(slider1)], marker=7, label = ["naranja" "verde"])
end

# ╔═╡ 3c653f10-0ec9-4112-9ed8-6697f8fdbbf0
map(x -> RGB(x, 0., 0.), rojo)

# ╔═╡ d0d56761-922f-4ee6-8009-61fa9cd261e2
begin
	md"""
	Ahora hagamos varios sliders
	
	🔴: $(@bind slider_🔴 Slider(0 : 0.1 : 1, show_value=true, default=0))
	
	💚: $(@bind slider_💚 Slider(0 : 0.1 : 1, show_value=true, default=0))
	
	💙: $(@bind slider_💙 Slider(0 : 0.1 : 1, show_value=true, default=0))"""
end

# ╔═╡ ce420aae-4680-4326-a3ec-c1c2a2e8e700
color = map((x, y, z) -> RGB(x, y, z), slider_🔴, slider_💚, slider_💙)

# ╔═╡ 991cc221-2324-4a87-b1d7-750ccd7f2250
md"## CheckBox"

# ╔═╡ d2bd9518-b846-4ea5-afec-610f2d6717ae
md"Te gusta Julia? $(@bind julia_is_fun CheckBox(default=true))"

# ╔═╡ 3181238a-e280-4957-a31b-450c8c5d3d4f
a = julia_is_fun ? "Excelente!" : "Fantoche"

# ╔═╡ 176f7203-7aad-49b7-91fc-864c429d5bec
md"## Botones
Esta cosa tiene una función medio extraña, pero que se complementa bien con la programación reactiva."

# ╔═╡ a4529396-c123-48ab-af5c-15de8d014c83
@bind baloon Button("🎈")

# ╔═╡ a02f5965-5404-473e-8479-127627664ad3
begin
	baloon
	rand(2,3)
end

# ╔═╡ ceec4764-d92e-489a-863e-8338486b74a8
md"## Select"

# ╔═╡ b1b94509-e4fa-4d6d-ae3d-051b71ccec5b
@bind vegetal1 Select(["papa", "zanahoria","jitomate"])

# ╔═╡ 44512228-2984-410e-bc81-8bbfefbd630e
vegetal1

# ╔═╡ 24db5165-8d5f-4b77-be3d-1a6d0583416b
@bind fruta Select(["manzana" => "🍎", "sandía" => "🍉", "pera" => "🍐"])

# ╔═╡ 90f4ef96-b623-48dd-a6b8-0ac5d0fd01d3
fruta

# ╔═╡ 329fa0ad-babf-4527-89ba-f901eae9f0b5
md"## RadioBox"

# ╔═╡ 6aec3798-960f-4ecb-a36f-5e95e1e87678
@bind veg Radio(["papa" => "🥔", "zanahoria" => "🥕", "jitomate" => "🍅"])

# ╔═╡ a11bee10-ed50-46fd-8fa2-65a71fe4b26c
veg

# ╔═╡ f9530e85-de10-4e34-aefb-05730752bfbc
md"## Cajas de texto"

# ╔═╡ 27e8324a-2969-4cef-a8be-5416e39246fc
@bind título TextField()

# ╔═╡ c9cf61f0-00f4-4ca6-b50d-f1e2da50946f
md"Hola $título"

# ╔═╡ 56f20095-b58a-48ac-8917-d306f7270f9e
md"## Seleccionador de color"

# ╔═╡ c93144b4-02dc-498a-bff5-bd38887d1227
@bind color_escogido ColorStringPicker()

# ╔═╡ b05ab8aa-e621-4b12-b1ba-71d4c912a1c9
color_escogido

# ╔═╡ c1a8b072-a6dd-45f9-b153-e3df918d4327
md"## Fecha"

# ╔═╡ 6c1f60fa-07ec-4c89-9f55-e1282ea62fbd
@bind nacimiento DateField()

# ╔═╡ 35fa4472-f1a9-40b0-ac83-385de5e72cbf
nacimiento

# ╔═╡ f879bf9b-b684-4dfe-8e39-a633c1c80c22
md"## Caja de números"

# ╔═╡ e83448e5-78fb-46e4-9746-055aed843167
@bind numero NumberField(0.00 : 0.01 : 0.30; default=0.)

# ╔═╡ 14443b0e-1c32-4f24-8bed-a913711819ae
numero

# ╔═╡ 50abbb37-2552-46f1-ab00-3f56cbbe2ea5
md"## Caja de contraseña"

# ╔═╡ 6323d028-dd43-4aa2-93bf-9f9860f2ffe1
@bind contraseña PasswordField()

# ╔═╡ 3c11c625-7652-4d73-a837-4f4f2d1ebdc4
contraseña

# ╔═╡ f9ea2917-d5f3-41dc-b82d-e7de15400f1a
md"## Campo de tiempo"

# ╔═╡ dbf3f367-8659-4db8-9ba0-052913faa1e5
@bind lanzamiento TimeField()

# ╔═╡ 8dea4b6a-4473-445b-b13f-6efd17f18b9f
md"## Reloj"

# ╔═╡ 8eec5c23-e12c-4cf0-afb0-f1f492c6c565
@bind reloj Clock(interval = 0.1)

# ╔═╡ b765d0da-280b-449a-acd2-f16bd05ead43
reloj

# ╔═╡ 36796cf3-c5e3-46a1-8d70-d77de780434e
100000 + reloj

# ╔═╡ 75a3c8a8-e936-4c4c-802b-b99c86dde52d
md"# Ejercicio
Este es un ejercicio libre, usa algún widget que interactúe con otro widget. ¡Sé ingenioso!"

# ╔═╡ 7a740f12-f387-11eb-0f95-198dcf9498ef
md"# Graficación
En este notebook checaremos lo básico de graficación con la paquetría _Plots_, algo de animaciones y más interactividad con Pluto."

# ╔═╡ 3be85f4f-fb8e-466b-99ce-5631e665d889
md"## Plots
Inicializamos los paquetes que necesitamos"

# ╔═╡ 9f53b02c-c945-4e54-bdaf-7f1fb7d0dd58
md"## Backends: 
Son el alma de **Plots**. Su diversidad en cuanto a características, fortalezas/debilidades, y sus enfoques son una de las ventajas que ponen a **Plots** sobre las demás API's de graficación. Los backends disponibles actualmente y en qué casos se usan son las siguientes: "

# ╔═╡ 7e7e7dd5-29aa-414b-83e5-1f0d648929c3
md"Modificar imagen: $(@bind x Slider(15:20))"

# ╔═╡ fc11f081-ec2f-42d0-9bd6-1403f16f0df4
Resource("https://www.math.purdue.edu/~allen450/backend%20uses.png", :width => x * x)

# ╔═╡ 8f38431d-ab8b-4daa-9227-101d473a4edc
md"
Existen otros _backends_ que ya están descontinuados, pero podrían encontrárselos por ahí, sus nombres son: 

	- PGFPlots
	- Gadfly
	- Immerse
	- Qwt
	- Bokeh
	- Winston
	
Aquí utilizaremos **GR** y **Plotly**.
"

# ╔═╡ d6cbd41e-e2f4-489c-a05a-81aedb54e50d
backend()

# ╔═╡ 6e1fc96a-3927-4c9f-adb2-696879b91904
@bind backend_var Select(["gr", "plotly"])

# ╔═╡ afc262e6-54a4-4cc8-81fd-355ff8a50a35
eval(Meta.parse("$(backend_var)()"))

# ╔═╡ 85523352-d006-4470-aec9-5f5177acd5ec
md"## Gráficas básicas"

# ╔═╡ f6cad4f2-0dc9-481a-bf76-c96c463097a0
md"Una graficación rápida"

# ╔═╡ 1317db33-ded1-4880-be60-aa93e91d5f18
@bind botón_random Button("🔴")

# ╔═╡ 0a1e13c4-9d87-4718-9383-15a6be6eef61
begin
	botón_random
	x_plot = 1:0.1:10
	y_plot = rand(length(x_plot))
	plot(x_plot, y_plot)
end

# ╔═╡ 45ee1911-5863-453f-941c-dda44002c2a7
md"Graficando dos (o más) cosas al mismo tiempo. Una x para dos y's"

# ╔═╡ 02bdc833-abbb-4482-a5b6-c68c51c0140f
md"Quiero dos gráficas $(@bind uno_o_dos CheckBox())"

# ╔═╡ a9d997bc-5099-4d68-b11d-eca32fcc24b2
begin
	x_plot1 = 1:10
	y_plot1 = uno_o_dos ? rand(10, 2) : rand(10,1)
	plot(x_plot1, y_plot1)
end

# ╔═╡ c9d7b733-465a-4d27-808a-127787a023de
md"Podemos nombrar una gráfica y así invocarla en otro lugar!"

# ╔═╡ 8adb5c36-a878-4883-a0e2-04379a9431f6
@bind num_graficas NumberField(1:10; default=2)

# ╔═╡ 50494dac-e234-43f3-9a71-ff03fad98a38
begin
	x_plot2 = 1:10
	y_plot2 = rand(10, num_graficas)
	plot2 = plot(x_plot2, y_plot2)
end

# ╔═╡ 3f9cbcb4-47f9-4a44-885b-262d51bb2c23
plot2

# ╔═╡ 0929878b-45d2-4ccf-859b-3ddf136c44a8
md"Como ya se ha visto, podemos modificar objetos _in-situ_ con las funciones que terminan con un signo de admiración (!), sin embargo `plot!()` no es algo recomendado en Pluto, ya que en programación reactiva no se recomienda cambiar una variable definida en ora celda. Se recomienda usar `plot!()` únicamente para alterar gráficas inicializadas en las mismas celdas. OJO, se puede hacer uso de este tipo de funciones, pero hay que acostumbrarnos a no hacerlo en Pluto."

# ╔═╡ 108a83bc-2ca0-4d85-941a-cfb9500b062a
@bind marker Select(["cross", "xcross", "utriangle", "dtriangle"])

# ╔═╡ 00bf1cb8-432b-4048-bb02-ea0664e31504
begin
	md"Mostremos una gráfica sencilla"
	x_plot3= 1:10
	y_plot3 = rand(10, 1)
	plot(x_plot3, y_plot3, marker = Symbol(marker), ms = 10)
end

# ╔═╡ 52fe2fad-4d4d-458c-b2bd-c48bc25ed90b
md"Agregamos una gráfica"

# ╔═╡ 833414c9-7905-4d2b-9377-3e1a2ce7eb8c
@bind color_grafica ColorStringPicker()

# ╔═╡ b3c1fa94-1234-4699-9c88-999907e1b2b4
plot!(x_plot3, rand(10,1), c = color_grafica)

# ╔═╡ 9c332ac9-826f-48c0-8c98-bebc23f1664f
md"Agregamos una gráfica a una gráfica asignada a una variable:"

# ╔═╡ 2bf34da3-5892-44bd-9df3-5662a695deee
plot!(plot2, rand(10,1))

# ╔═╡ 898c4112-b22b-45f9-9a00-6cba26401c72
md"Ojo en que ya andamos usando el despacho múltiple como si lo supiéramos de toda la vida"

# ╔═╡ 290abf61-943b-46ce-8197-5a8173701c0b
@which plot(x_plot3, rand(10,1))

# ╔═╡ b125a2a8-1ba3-47e9-bebe-691923ff82fa
@which plot!(plot2, rand(10,1))

# ╔═╡ f1434571-169d-4252-b6ed-2e0d25b7c529
md"### Tuneando las gráficas"

# ╔═╡ 223bc6c5-d642-4efb-ad40-d6b0f392ebe4
@bind caja_titulo TextField()

# ╔═╡ 1ce7d8a0-1e56-44a1-a513-46a6de76ef87
@bind slider_width Slider(1:20, show_value = true)

# ╔═╡ ab465a1e-2f1c-413f-a7b5-667974befafe
@bind color_grafica2 ColorStringPicker()

# ╔═╡ 1c27f580-2749-4b20-b558-10efaf0eb61b
y_plot4 = rand(10, 2);

# ╔═╡ 6e97b9f6-8a97-4533-ab05-97d10a6b5377
begin
x_plot4 = 1:10
plot(x_plot4, y_plot4, title = caja_titulo, label = ["Linea 1" "Linea 2"],
		lw = [1 slider_width], c = [:blue color_grafica2])
end

# ╔═╡ 8930984a-75e1-4672-be9f-900300ff4bbe
with_terminal(plotattr, :Plot)

# ╔═╡ ae5500bb-a5b4-486e-8cd2-46600e30ec31
md"Los atributos se pasan como _keywords_"

# ╔═╡ 3e0c0798-4639-44d4-bfd8-6b97c01a36da
begin
	x_plot5 = 1:10
	y_plot5 = rand(10, 2)
	plot(x_plot5, y_plot5, title = "Dos lineas", label = ["Linea 1" "Linea 2"], lw = 3, c = ["green" "purple"], alpha = [0.8 0.9])
	title!("Gráfica actualizada")
end

# ╔═╡ 7cf4d832-2696-450b-9925-4a570496b02f
md"Guardamos una figura"

# ╔═╡ 16599ebf-5a0a-4aec-b294-fc6557810fec
savefig("/home/pilares/Escritorio/myplot.png")

# ╔═╡ 41cf8342-01c8-4754-b2e9-a8a744848061
md"Cambiando el tipo de gráfica"

# ╔═╡ 7707af83-f951-4340-8f03-dff10ad8d4b8
plot(x_plot5, y_plot5, seriestype = :scatter, title = "Gráfica de dispersión")

# ╔═╡ 3bb1756f-d976-4821-bc72-6bdcc3e96e72
scatter(x_plot5, y_plot5, title = "Gráfica de dispersión")

# ╔═╡ f4b61973-7cdd-4461-ba89-6e8990cea4ee
md"## Subplots
Ahora lo que haremos será construir varias gráficas en una misma figura"

# ╔═╡ 0835d3a8-ee0c-4dd6-ae17-7c1ab9c707b2
@bind orientacion Radio(["vertical", "horizontal"])

# ╔═╡ 4f63dc46-8bfc-4963-9fde-3c3018240c59
begin
	x_plot6 = 1:10
	y_plot6 = rand(10, 4)
	if orientacion == "vertical"
		plot(x_plot6, y_plot6, layout = (4, 1), c = ["blue" "red" "green" "purple"])
	else
		plot(x_plot6, y_plot6, layout = (1, 4), c = ["blue" "red" "green" "purple"])
	end
end

# ╔═╡ df8d2ccb-e4a7-49ec-a5e1-22cb8f49aa55
begin
	x_plot7 = 1:10
	y_plot7 = rand(10, 4)
	p1 = plot(x_plot7, y_plot7)
	p2 = scatter(x_plot7, y_plot7, shape = :cross)
	p3 = plot(x_plot7, y_plot7, xlabel = "¡Esta está tuneada!", lw = [4 3 2 1], title = "Subtítulo", line = :dash)
	p4 = histogram(x_plot7, y_plot7)
	plot(p1, p2, p3, p4, layout = (2, 2), legend = false)
end

# ╔═╡ 6280213f-147c-4559-8a80-d244745929ac
md"## Ploteando unas funciones"

# ╔═╡ e1e91cfd-7c5f-452d-bb1a-16057ee6724e
md"Amortiguación: $(@bind amortiguacion NumberField(0:0.1:1; default=1))"

# ╔═╡ 114e6a11-974e-46c3-9fc9-59befeb9f037
md"Amplitud: $(@bind A Slider(1:20, show_value = true))"

# ╔═╡ c78b6af7-daf7-47e1-b4ac-86e3d5d9a814
md"Frecuencia: $(@bind ω Slider(1:20, show_value = true))"

# ╔═╡ e38db4b3-b577-4a3c-b0ed-36ae9d1d3059
md"Fase: $(@bind ϕ Slider(0:0.1:2π, show_value = true))"

# ╔═╡ a2429530-2457-4d0f-b094-2205f6e6cdbb
begin
	x_plot8 = 1:0.1:20
	f(x) = A*ℯ^(-amortiguacion*x)*cos(ω*x + ϕ)
	plot(x_plot8, f.(x_plot8), c = "pink", lw = 4, title = "Oscilador amortiguado", xlabel = L"x", ylabel = L"f(x)", label = L"Ae^{(-amortiguacion*x)}cos(\omega x + \phi)")
end

# ╔═╡ c76b9356-3488-4417-93eb-8bb4d3c3596f
md"Nos podemos poner más ingeniosos"

# ╔═╡ da908b2f-b7d7-475e-8f61-f0224af84ac5
@bind nombre TextField(default = "<Inserte nombre>")

# ╔═╡ 25a1e5ac-55fd-484b-a382-4004f55672d9
begin
	n = 400
	t_plot9 = range(0, 2π, length = n)
	x_plot9 = 16sin.(t_plot9).^3
	y_plot9 = 13cos.(t_plot9) .- 5cos.(2t_plot9) .- 2cos.(3t_plot9) .- cos.(4t_plot9)
	plot([x_plot9 1.02x_plot9], [y_plot9 1.02y_plot9], c = ["blue" :red], lw = 4, title = "Corazón", xlabel = "x", ylabel = "f(x)",
		background_color = :pink, legend = false, fill = (1, :red)) # Vemos que el color también puede ser un símbolo
	annotate!(0, 0, nombre)
end

# ╔═╡ 1e9361c6-d140-49e7-aa74-bd5c665c9fb9
md"Ahora una en 3d"

# ╔═╡ 203fb251-3b5d-4351-b4e8-b9824beff593
@bind reloj_1 Clock(interval = 1, fixed = true)

# ╔═╡ 55e9dfdf-e2f1-4580-8af8-1262d13f3d81
begin
	x_plot10 = 1:0.1:20
	y_plot10 = sin.(x_plot10)
	z_plot10 = cos.(x_plot10)
	plot(x_plot10,y_plot10,z_plot10)
	plot!(reloj_1*x_plot10,reloj_1*y_plot10,reloj_1*z_plot10)
end

# ╔═╡ a1c3947b-be3b-4cdb-9fa9-ba636aac3b37
md"Vamos a hacer nuestras propias figuras"

# ╔═╡ 593b28d2-c700-488d-9fd0-a0c00c68f763
md"""
🔴: $(@bind slider_🔴_1 Slider(0 : 0.1 : 1, show_value=true, default=0))
	
💚: $(@bind slider_💚_1 Slider(0 : 0.1 : 1, show_value=true, default=0))
	
💙: $(@bind slider_💙_1 Slider(0 : 0.1 : 1, show_value=true, default=0))

α: $(@bind α Slider(0 : 0.1 : 1, show_value=true, default=0))
"""

# ╔═╡ c17fe419-a8cd-4d8c-b713-2291c07e9029
begin
	y_plot11 = 0.7 * rand(5) .+ 0.15
	verts = [(-1.0, 1.0), (-1.28, 0.6), (-0.2, -1.4), (0.2, -1.4), (1.28, 0.6), (1.0, 1.0), (-1.0, 1.0), (-0.2, -0.6), (0.0, -0.2), (-0.4, 0.6), (1.28, 0.6), (0.2, -1.4), (-0.2, -1.4), (0.6, 0.2), (-0.2, 0.2), (0.0, -0.2), (0.2, 0.2), (-0.2, -0.6)]
		x_plot11 = 0.1:0.2:0.9
end

# ╔═╡ c1407c04-1254-403b-b413-3adce4295f35
begin
	plot(x_plot11, y_plot11, line = (3, :dash, :lightblue), marker = (Shape(verts), 30, RGBA(slider_🔴_1, slider_💚_1, slider_💙_1, α)), legend = false, grid = 10)
end

# ╔═╡ 8c8e8706-3ee1-408e-a307-1d4c81876969
md"# Ejercicio:

Haz un círculo de radio r con una función (de la manera que quieras) luego grafícalo y rellénalo."

# ╔═╡ f4ee314a-0b62-4a1f-86cf-1ae64f89ca63
begin
	function circulo(r)
	    θ = -π:0.01:π
	    x_circ = @. r*cos(θ)
	    y_circ = @. r*sin(θ)
	    return x_circ, y_circ
	end
	x_circ,y_circ = circulo(5)
	plot(x_circ, y_circ,  aspect_ratio = 1, leg = false, fill = true, c = :green, alpha = 0.4)
end

# ╔═╡ 78697e6e-6a7e-4192-96a5-5c05067c01bf
md"## Animaciones
Hagamos algunos gifs"

# ╔═╡ bc1205c9-80e6-420b-b954-e83572cbeb97
function rotar_2D(θ, M)
    R = [cos(θ) -sin(θ);
        sin(θ) cos(θ)]
    M′ = R * M
    return M′
end

# ╔═╡ 9920e43b-c202-4d99-87db-77b0bcf3d419
begin
	x_anim = [i[1] for i ∈ verts]
	y_anim = [j[2] for j ∈ verts]
	vertices = [x_anim, y_anim]
	anim = @animate for θ in 0:0.1:2π
	    rot = rotar_2D(θ, vertices)
	    plot(rot[1,:], rot[2,:], key = false, show = false, xlim = [-2,2], ylims = [-2,2], c = :green)
	    end
	gif(anim,"anim.gif")
end

# ╔═╡ e0ad48dc-cf12-41bd-9a4e-611284fff24d
md"## StatsPlots

`StatsPlots.jl` es una biblioteca de recipes (o recetas), tiene entonces muchas recetas de cómo interpretar comandos de graficación, por ejemplo, nos dirá cómo usar las Distribuciones.
"

# ╔═╡ eb75f174-aff7-499e-b1d1-08932c3ca288
begin
	μ = 0
	σ = 1
	plot(Normal(μ, σ), lw = 3)
end

# ╔═╡ d6da6908-3117-47fb-a24d-7113b1b171ef
begin
	x_plot12 = randn(1024)
	y_plot12 = randn(1024)
	marginalkde(x_plot12, x_plot12+y_plot12)
end

# ╔═╡ 0022254c-bd64-439e-ab42-3b14c252131a
begin
	dist = Gamma(2)
	scatter(dist, leg=false)
	bar!(dist, alpha=0.3)
end

# ╔═╡ 29693460-f01a-4911-af4a-5bd9b9076414
groupedbar(rand(10,3), bar_position = :stack, bar_width=0.7, c = [RGB(0.1,1,0.5) "#CB3234" :red], alpha = [0.5 0.5 0.1])

# ╔═╡ e136f4a4-04f6-410c-8a2d-b3b17cd92ca0
groupedbar(rand(10,3), bar_width=0.7, alpha = [0.5 0.5 0.3])

# ╔═╡ 597bc4d4-8b71-4dc1-9a21-6d6734fbb6b0
md"## Plotly"

# ╔═╡ 5ebfb1e6-b90e-4f85-a06c-6725f26381b3
plotly(size = (650, 500))

# ╔═╡ d11af250-db23-4c99-9fc0-bc1cf2063580
md"Gráfica sencilla"

# ╔═╡ 62a8d4d7-d112-4679-9958-e08111a92e37
begin
	x_plotly1 = [1, 2, 3]
	y_plotly1 = [3, 4, 8]
	plot(x_plotly1, y_plotly1, title="Gráfica básica Plotly", marker = 5, lw = 3)
end

# ╔═╡ be012f99-f8b4-4400-a29b-082ae409f348
begin
	trace1 = plot([1, 2, 3, 4], [10, 15, 13, 17], marker = 3)
	trace2 = plot!([1, 2, 3, 4], [16, 5, 11, 9], marker = 5)
end

# ╔═╡ ecc67ca2-6ddc-4ff3-91f1-9974df3bc76e
begin
	x_plotly2 = [1, 2, 3, 4, 5]
	y_plotly2 = [1, 6, 3, 6, 1]
	t1 = scatter(x_plotly2, y_plotly2, 
	    series_annotation=[Plots.text("A-1",:left, :top), Plots.text("A-2",:left, :top), 
	        Plots.text("A-3", :right, :bottom), Plots.text("A-4", 10,:left, :top), 
	        Plots.text("A-5", 5,:left, :top)], marker = [5,10,20,30,40], 
	    c = [:blue,:green,:yellow,:orange,:red], alpha = [0.5,0.5,0.5,0.5,0.5])
end

# ╔═╡ 3d18f4c0-c0d7-4feb-a8ea-467bb5c05827
begin
	plot(1:4, [0, 2, 3, 5], marker=5, fillrange = 0, fillalpha = 0.5, alpha = 0.5)#fill="tozeroy")
	plot!(1:4, [3, 5, 1, 7], marker=5, fillrange = [0, 2, 3, 5], fillalpha = 0.5, color = :green)#fill="tonexty")
end

# ╔═╡ 21bef124-5657-4a63-9695-7a2737a544f3
begin
	n_plotly = 400
	rw() = cumsum(randn(n_plotly))
	plot(rw(),rw(),rw(), lw = 3, color="#1f77b4")
	plot!(rw(),rw(),rw(), lw = 3, color="#9467bd")
	plot!(rw(),rw(),rw(), lw = 3, color="#bcbd22")
end

# ╔═╡ 2f270372-c3a0-4e78-8e3d-6395b82d8f21
begin
	p1_plotly = plot([1, 2, 3],[4, 5, 6],marker=10, label="y1")
	p2_plotly = plot([20, 30, 40],[50, 60, 70], c = :red, marker = 5, label="y2")
	plot(p1_plotly,p2_plotly, layout = 2)
end

# ╔═╡ cc0b0931-5be3-444c-a75d-0abc3f51b365
@bind gparam Slider(1:9, show_value=true, default=1)

# ╔═╡ 34146626-c30a-4326-a808-673f632a85dc
begin
	using ImageFiltering
	kernel = Kernel.gaussian(gparam)
end

# ╔═╡ 9b64338d-878d-4a42-ac6f-69324505b41f
surface([kernel;])

# ╔═╡ 450423a5-e994-4f55-9d0e-0a90f66c087c
md"""# Actividades:
## Graficación
- Haz una gráfica de cualquier curva que quieras (sin, cos, exp, etc...) que tenga una parte positiva y otra negativa. Rellena con un color la parte positiva y con otro la parte negativa.

- Utiliza la misma función y la figura que quieras (tiene que ser otra, no se vale copiar) para hacer una animación pero ahora haz que la figura, además de girar, se estire sobre uno o dos ejes.
"""

# ╔═╡ 961884ef-e691-4d6b-b0c7-fb2c1297caa5
begin
	function Rellenar(f)
	    x = 0:0.01:4π
	    y = f.(x)
	    positivos_x = []
	    negativos_x = []
	    for i ∈ x
	        f(i) > 0 ? push!(positivos_x, i) : push!(negativos_x, i)
	    end
	    #Para quitar las discontinuidades cuando se cortan los intervalos
	    trim(f; val=0.01) = x -> abs(f(x)) < val ? NaN : f(x)
	    plot(trim(f),[positivos_x, negativos_x],fill = true, leg = false, alpha = 0.5)
	    #plot(f,[positivos_x, negativos_x],fill = true, leg = false, alpha = 0.5)
	end
	f_rellenar(x) = sin(x)
	Rellenar(f_rellenar)
end

# ╔═╡ c1d6ba6b-4ce1-4e41-82f6-3752f9304e91
gr()

# ╔═╡ 45154675-0f0c-411d-8126-b507c2e5cb81
begin
	function estirar2D(x,y,M)
	    E_x = [x 0;
	            0 1]
	    E_y = [1 0;
	            0 y]
	    M′ = (E_x*E_y)*M
	end
	
	x_est = [i[1] for i ∈ verts]
	y_est = [j[2] for j ∈ verts]
	vertices_est = [x_est, y_est]
	anim_est = @animate for θ_est in -2π:0.1:2π
	    rot_est = rotar_2D(θ_est, vertices_est)
	    rot1_est = estirar2D(abs(θ_est)/6, abs(θ_est)/6, rot_est)
	    plot(rot1_est[1,:], rot1_est[2,:], label = false, xlim = [-2,2], ylims = [-2,2], c = :green)
	    end
	gif(anim_est,"Taller-Julia2021/imgs/anim2.gif")
end

# ╔═╡ e3c39898-a528-4fce-a304-a5577a0c8c99
begin
	function estirar_3D(x,y,z,M)
	    E_x = [x 0 0;
	            0 1 0;
	            0 0 1]
	    E_y = [1 0 0;
	            0 y 0;
	            0 0 1]
	    E_z = [1 0 0;
	            0 1 0;
	            0 0 z]
	    
	    M′ = (E_z*E_y*E_x)*M
	end
	
	function rotar_3D(α, β, γ, M)
	    R_x = [1 0 0;
	        0 cos(α) -sin(α);
	        0 sin(α) cos(α)]
	    R_y = [cos(β) 0 sin(β);
	        0 1 0;
	        -sin(β) 0 cos(β)]
	    R_z = [cos(γ) -sin(γ) 0;
	        sin(γ) cos(γ) 0;
	        0 0 1]
	    M′ = (R_z*R_y*R_x) * M
	    
	    return M′
	end
	
	vertices_cubo = [1 -1 -1 1 1 1 1 -1 -1 1 -1 -1 -1 -1 -1 1 1;
	                -1 -1 1 1 -1 -1 1 1 -1 -1 -1 -1 -1 1 1 1 1;
	                1 1 1 1 1 -1 -1 -1 -1 -1 -1 1 1 1 -1 -1 1]
	
	lim = 3
	Cubo = @animate for θ ∈ -2π:0.1:2π
	    Cubo_anim3D = rotar_3D(0, 0, θ,  vertices_cubo)
	    Cubo_anim3D_1 = estirar_3D(θ/4, θ/4, 1, Cubo_anim3D)
	    plot(Cubo_anim3D_1[1,:], Cubo_anim3D_1[2,:], Cubo_anim3D_1[3,:], 
	        xlim = [-2,2], ylim = [-2,2], zlim = [-lim-1,lim+1], c = :green, label = false)
	end
	
	gif(Cubo,"Taller-Julia2021/imgs/Cubo.gif")
end

# ╔═╡ c29324cc-672d-4bbf-b8e4-d812a20c112b
md"""
## Péndulo simple
La ecuación del péndulo simple viene dada por:

$\frac{d^{2}\theta}{dt^{2}}+\frac{g}{L}\theta = 0$

Y su solución es

$\theta (t) = \theta_{0}cos(\omega t)$

donde $\omega = \sqrt{\frac{g}{L}}$

la tarea consta de graficar un punto y una recta que avancen con el tiempo y con interactividad cambiemos la masa del objeto, su longitud, el ángulo inicial y algunas características de la gráfica. **Usar todos los objetos interactivos posibles pero sin que la gráfica se vea saturada**.
"""

# ╔═╡ 6ecf6b84-6e73-4a59-b65e-e838fb10f181
#methodswith(Float64)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CSV = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
Colors = "5ae59095-9a9b-59fe-a467-6f913c188581"
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
Distributions = "31c24e10-a181-5473-b8eb-7969acd0382f"
ImageFiltering = "6a3955dd-da59-5b1f-98d4-e7296123deb5"
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
StatsPlots = "f3b207a7-027a-5e70-b257-86293d7955fd"

[compat]
CSV = "~0.8.5"
Colors = "~0.12.8"
DataFrames = "~1.2.2"
Distributions = "~0.25.11"
ImageFiltering = "~0.6.22"
LaTeXStrings = "~1.2.1"
Plots = "~1.19.4"
PlutoUI = "~0.7.9"
StatsPlots = "~0.14.26"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[AbstractFFTs]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "485ee0867925449198280d4af84bdb46a2a404d0"
uuid = "621f4979-c628-5d54-868e-fcf4e3e8185c"
version = "1.0.1"

[[Adapt]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "84918055d15b3114ede17ac6a7182f68870c16f7"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.3.1"

[[ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[Arpack]]
deps = ["Arpack_jll", "Libdl", "LinearAlgebra"]
git-tree-sha1 = "2ff92b71ba1747c5fdd541f8fc87736d82f40ec9"
uuid = "7d9fca2a-8960-54d3-9f78-7d1dccf2cb97"
version = "0.4.0"

[[Arpack_jll]]
deps = ["Libdl", "OpenBLAS_jll", "Pkg"]
git-tree-sha1 = "e214a9b9bd1b4e1b4f15b22c0994862b66af7ff7"
uuid = "68821587-b530-5797-8361-c406ea357684"
version = "3.5.0+3"

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[AxisAlgorithms]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "WoodburyMatrices"]
git-tree-sha1 = "a4d07a1c313392a77042855df46c5f534076fab9"
uuid = "13072b0f-2c55-5437-9ae7-d433b7a33950"
version = "1.0.0"

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c3598e525718abcc440f69cc6d5f60dda0a1b61e"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.6+5"

[[CSV]]
deps = ["Dates", "Mmap", "Parsers", "PooledArrays", "SentinelArrays", "Tables", "Unicode"]
git-tree-sha1 = "b83aa3f513be680454437a0eee21001607e5d983"
uuid = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
version = "0.8.5"

[[Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "e2f47f6d8337369411569fd45ae5753ca10394c6"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.0+6"

[[CatIndices]]
deps = ["CustomUnitRanges", "OffsetArrays"]
git-tree-sha1 = "a0f80a09780eed9b1d106a1bf62041c2efc995bc"
uuid = "aafaddc9-749c-510e-ac4f-586e18779b91"
version = "0.2.2"

[[ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "ad613c934ec3a3aa0ff19b91f15a16d56ed404b5"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.0.2"

[[Clustering]]
deps = ["Distances", "LinearAlgebra", "NearestNeighbors", "Printf", "SparseArrays", "Statistics", "StatsBase"]
git-tree-sha1 = "75479b7df4167267d75294d14b58244695beb2ac"
uuid = "aaaa29a8-35af-508c-8bc3-b662a17a0fe5"
version = "0.14.2"

[[ColorSchemes]]
deps = ["ColorTypes", "Colors", "FixedPointNumbers", "Random", "StaticArrays"]
git-tree-sha1 = "ed268efe58512df8c7e224d2e170afd76dd6a417"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.13.0"

[[ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "SpecialFunctions", "Statistics", "TensorCore"]
git-tree-sha1 = "42a9b08d3f2f951c9b283ea427d96ed9f1f30343"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.9.5"

[[Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "417b0ed7b8b838aa6ca0a87aadf1bb9eb111ce40"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.8"

[[Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "344f143fa0ec67e47917848795ab19c6a455f32c"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.32.0"

[[CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[ComputationalResources]]
git-tree-sha1 = "52cb3ec90e8a8bea0e62e275ba577ad0f74821f7"
uuid = "ed09eef8-17a6-5b46-8889-db040fac31e3"
version = "0.3.2"

[[Contour]]
deps = ["StaticArrays"]
git-tree-sha1 = "9f02045d934dc030edad45944ea80dbd1f0ebea7"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.5.7"

[[Crayons]]
git-tree-sha1 = "3f71217b538d7aaee0b69ab47d9b7724ca8afa0d"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.0.4"

[[CustomUnitRanges]]
git-tree-sha1 = "537c988076d001469093945f3bd0b300b8d3a7f3"
uuid = "dc8bdbbb-1ca9-579f-8c36-e416f6a65cce"
version = "1.0.1"

[[DataAPI]]
git-tree-sha1 = "ee400abb2298bd13bfc3df1c412ed228061a2385"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.7.0"

[[DataFrames]]
deps = ["Compat", "DataAPI", "Future", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrettyTables", "Printf", "REPL", "Reexport", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "d785f42445b63fc86caa08bb9a9351008be9b765"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.2.2"

[[DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "4437b64df1e0adccc3e5d1adbc3ac741095e4677"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.9"

[[DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[DataValues]]
deps = ["DataValueInterfaces", "Dates"]
git-tree-sha1 = "d88a19299eba280a6d062e135a43f00323ae70bf"
uuid = "e7dc6d0d-1eca-5fa6-8ad6-5aecde8b7ea5"
version = "0.4.13"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[Distances]]
deps = ["LinearAlgebra", "Statistics", "StatsAPI"]
git-tree-sha1 = "abe4ad222b26af3337262b8afb28fab8d215e9f8"
uuid = "b4f34e82-e78d-54a5-968a-f98e89d6e8f7"
version = "0.10.3"

[[Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[Distributions]]
deps = ["FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SparseArrays", "SpecialFunctions", "Statistics", "StatsBase", "StatsFuns"]
git-tree-sha1 = "3889f646423ce91dd1055a76317e9a1d3a23fff1"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.11"

[[DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "a32185f5428d3986f47c2ab78b1f216d5e6cc96f"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.8.5"

[[Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[EarCut_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "92d8f9f208637e8d2d28c664051a00569c01493d"
uuid = "5ae413db-bbd1-5e63-b57d-d24a61df00f5"
version = "2.1.5+1"

[[Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b3bfd02e98aedfa5cf885665493c5598c350cd2f"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.2.10+0"

[[FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "LibVPX_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "Pkg", "Zlib_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "3cc57ad0a213808473eafef4845a74766242e05f"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.3.1+4"

[[FFTViews]]
deps = ["CustomUnitRanges", "FFTW"]
git-tree-sha1 = "70a0cfd9b1c86b0209e38fbfe6d8231fd606eeaf"
uuid = "4f61f5a4-77b1-5117-aa51-3ab5ef4ef0cd"
version = "0.3.1"

[[FFTW]]
deps = ["AbstractFFTs", "FFTW_jll", "LinearAlgebra", "MKL_jll", "Preferences", "Reexport"]
git-tree-sha1 = "f985af3b9f4e278b1d24434cbb546d6092fca661"
uuid = "7a1cc6ca-52ef-59f5-83cd-3a7055c09341"
version = "1.4.3"

[[FFTW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3676abafff7e4ff07bbd2c42b3d8201f31653dcc"
uuid = "f5851436-0d7a-5f13-b9de-f02708fd171a"
version = "3.3.9+8"

[[FillArrays]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "Statistics"]
git-tree-sha1 = "8c8eac2af06ce35973c3eadb4ab3243076a408e7"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "0.12.1"

[[FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "35895cf184ceaab11fd778b4590144034a167a2f"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.1+14"

[[Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "cbd58c9deb1d304f5a245a0b7eb841a2560cfec6"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.10.1+5"

[[FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "aa31987c2ba8704e23c6c8ba8a4f769d5d7e4f91"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.10+0"

[[Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pkg", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "dba1e8614e98949abfa60480b13653813d8f0157"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.5+0"

[[GR]]
deps = ["Base64", "DelimitedFiles", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Printf", "Random", "Serialization", "Sockets", "Test", "UUIDs"]
git-tree-sha1 = "9f473cdf6e2eb360c576f9822e7c765dd9d26dbc"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.58.0"

[[GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Pkg", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "eaf96e05a880f3db5ded5a5a8a7817ecba3c7392"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.58.0+0"

[[GeometryBasics]]
deps = ["EarCut_jll", "IterTools", "LinearAlgebra", "StaticArrays", "StructArrays", "Tables"]
git-tree-sha1 = "58bcdf5ebc057b085e58d95c138725628dd7453c"
uuid = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
version = "0.4.1"

[[Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "7bf67e9a481712b3dbe9cb3dac852dc4b1162e02"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.68.3+0"

[[Graphics]]
deps = ["Colors", "LinearAlgebra", "NaNMath"]
git-tree-sha1 = "2c1cf4df419938ece72de17f368a021ee162762e"
uuid = "a2bd30eb-e257-5431-a919-1863eab51364"
version = "1.1.0"

[[Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[HTTP]]
deps = ["Base64", "Dates", "IniFile", "Logging", "MbedTLS", "NetworkOptions", "Sockets", "URIs"]
git-tree-sha1 = "44e3b40da000eab4ccb1aecdc4801c040026aeb5"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "0.9.13"

[[ImageCore]]
deps = ["AbstractFFTs", "ColorVectorSpace", "Colors", "FixedPointNumbers", "Graphics", "MappedArrays", "MosaicViews", "OffsetArrays", "PaddedViews", "Reexport"]
git-tree-sha1 = "75f7fea2b3601b58f24ee83617b528e57160cbfd"
uuid = "a09fc81d-aa75-5fe9-8630-4744c3626534"
version = "0.9.1"

[[ImageFiltering]]
deps = ["CatIndices", "ComputationalResources", "DataStructures", "FFTViews", "FFTW", "ImageCore", "LinearAlgebra", "OffsetArrays", "Requires", "SparseArrays", "StaticArrays", "Statistics", "TiledIteration"]
git-tree-sha1 = "79dac52336910325a5675813053b1eee3eb5dcc6"
uuid = "6a3955dd-da59-5b1f-98d4-e7296123deb5"
version = "0.6.22"

[[IniFile]]
deps = ["Test"]
git-tree-sha1 = "098e4d2c533924c921f9f9847274f2ad89e018b8"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.0"

[[IntelOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "d979e54b71da82f3a65b62553da4fc3d18c9004c"
uuid = "1d5cc7b8-4909-519e-a0f8-d0f5ad9712d0"
version = "2018.0.3+2"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[Interpolations]]
deps = ["AxisAlgorithms", "LinearAlgebra", "OffsetArrays", "Random", "Ratios", "SharedArrays", "SparseArrays", "StaticArrays", "WoodburyMatrices"]
git-tree-sha1 = "1e0e51692a3a77f1eeb51bf741bdd0439ed210e7"
uuid = "a98d9a8b-a2ab-59e6-89dd-64a1c18fca59"
version = "0.13.2"

[[InvertedIndices]]
deps = ["Test"]
git-tree-sha1 = "15732c475062348b0165684ffe28e85ea8396afc"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.0.0"

[[IterTools]]
git-tree-sha1 = "05110a2ab1fc5f932622ffea2a003221f4782c18"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.3.0"

[[IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "642a199af8b68253517b80bd3bfd17eb4e84df6e"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.3.0"

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "81690084b6198a2e1da36fcfda16eeca9f9f24e4"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.1"

[[JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "d735490ac75c5cb9f1b00d8b5509c11984dc6943"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "2.1.0+0"

[[KernelDensity]]
deps = ["Distributions", "DocStringExtensions", "FFTW", "Interpolations", "StatsBase"]
git-tree-sha1 = "591e8dc09ad18386189610acafb970032c519707"
uuid = "5ab0869b-81aa-558d-bb23-cbf5423bbe9b"
version = "0.6.3"

[[LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6250b16881adf048549549fba48b1161acdac8c"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.1+0"

[[LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e5b909bcf985c5e2605737d2ce278ed791b89be6"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.1+0"

[[LaTeXStrings]]
git-tree-sha1 = "c7f1c695e06c01b95a67f0cd1d34994f3e7db104"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.2.1"

[[Latexify]]
deps = ["Formatting", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "Printf", "Requires"]
git-tree-sha1 = "a4b12a1bd2ebade87891ab7e36fdbce582301a92"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.15.6"

[[LazyArtifacts]]
deps = ["Artifacts", "Pkg"]
uuid = "4af54fe1-eca0-43a8-85a7-787d91b784e3"

[[LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[LibVPX_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "12ee7e23fa4d18361e7c2cde8f8337d4c3101bc7"
uuid = "dd192d2f-8180-539f-9fb4-cc70b1dcf69a"
version = "1.10.0+0"

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "761a393aeccd6aa92ec3515e428c26bf99575b3b"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+0"

[[Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll", "Pkg"]
git-tree-sha1 = "64613c82a59c120435c067c2b809fc61cf5166ae"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.7+0"

[[Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "7739f837d6447403596a75d19ed01fd08d6f56bf"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.3.0+3"

[[Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c333716e46366857753e273ce6a69ee0945a6db9"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.42.0+0"

[[Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "42b62845d70a619f063a7da093d995ec8e15e778"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.16.1+1"

[[Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9c30530bf0effd46e15e0fdcf2b8636e78cbbd73"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.35.0+0"

[[Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Pkg", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "340e257aada13f95f98ee352d316c3bed37c8ab9"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.3.0+0"

[[Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7f3efec06033682db852f8b3bc3c1d2b0a0ab066"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.36.0+0"

[[LinearAlgebra]]
deps = ["Libdl"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[LogExpFunctions]]
deps = ["DocStringExtensions", "LinearAlgebra"]
git-tree-sha1 = "7bd5f6565d80b6bf753738d2bc40a5dfea072070"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.2.5"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[MKL_jll]]
deps = ["Artifacts", "IntelOpenMP_jll", "JLLWrappers", "LazyArtifacts", "Libdl", "Pkg"]
git-tree-sha1 = "c253236b0ed414624b083e6b72bfe891fbd2c7af"
uuid = "856f044c-d86e-5d09-b602-aeab76dc8ba7"
version = "2021.1.1+1"

[[MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "6a8a2a625ab0dea913aba95c11370589e0239ff0"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.6"

[[MappedArrays]]
git-tree-sha1 = "18d3584eebc861e311a552cbb67723af8edff5de"
uuid = "dbb5928d-eab1-5f90-85c2-b9b0edb7c900"
version = "0.4.0"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "Random", "Sockets"]
git-tree-sha1 = "1c38e51c3d08ef2278062ebceade0e46cefc96fe"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.0.3"

[[MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[Measures]]
git-tree-sha1 = "e498ddeee6f9fdb4551ce855a46f54dbd900245f"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.1"

[[Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "4ea90bd5d3985ae1f9a908bd4500ae88921c5ce7"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.0"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[MosaicViews]]
deps = ["MappedArrays", "OffsetArrays", "PaddedViews", "StackViews"]
git-tree-sha1 = "b34e3bc3ca7c94914418637cb10cc4d1d80d877d"
uuid = "e94cdb99-869f-56ef-bcf0-1ae2bcbe0389"
version = "0.3.3"

[[MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[MultivariateStats]]
deps = ["Arpack", "LinearAlgebra", "SparseArrays", "Statistics", "StatsBase"]
git-tree-sha1 = "8d958ff1854b166003238fe191ec34b9d592860a"
uuid = "6f286f6a-111f-5878-ab1e-185364afe411"
version = "0.8.0"

[[NaNMath]]
git-tree-sha1 = "bfe47e760d60b82b66b61d2d44128b62e3a369fb"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "0.3.5"

[[NearestNeighbors]]
deps = ["Distances", "StaticArrays"]
git-tree-sha1 = "16baacfdc8758bc374882566c9187e785e85c2f0"
uuid = "b8a86587-4115-5ab1-83bc-aa920d37bbce"
version = "0.4.9"

[[NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[Observables]]
git-tree-sha1 = "fe29afdef3d0c4a8286128d4e45cc50621b1e43d"
uuid = "510215fc-4207-5dde-b226-833fc4488ee2"
version = "0.4.0"

[[OffsetArrays]]
deps = ["Adapt"]
git-tree-sha1 = "4f825c6da64aebaa22cc058ecfceed1ab9af1c7e"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.10.3"

[[Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7937eda4681660b4d6aeeecc2f7e1c81c8ee4e2f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+0"

[[OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "15003dcb7d8db3c6c857fda14891a539a8f2705a"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.10+0"

[[OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51a08fb14ec28da2ec7a927c4337e4332c2a4720"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.2+0"

[[OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[PCRE_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b2a7af664e098055a7529ad1a900ded962bca488"
uuid = "2f80f16e-611a-54ab-bc61-aa92de5b98fc"
version = "8.44.0+0"

[[PDMats]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "4dd403333bcf0909341cfe57ec115152f937d7d8"
uuid = "90014a1f-27ba-587c-ab20-58faa44d9150"
version = "0.11.1"

[[PaddedViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "0fa5e78929aebc3f6b56e1a88cf505bb00a354c4"
uuid = "5432bcbf-9aad-5242-b902-cca2824c8663"
version = "0.5.8"

[[Parsers]]
deps = ["Dates"]
git-tree-sha1 = "94bf17e83a0e4b20c8d77f6af8ffe8cc3b386c0a"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "1.1.1"

[[Pixman_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b4f5d02549a10e20780a24fce72bea96b6329e29"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.40.1+0"

[[Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[PlotThemes]]
deps = ["PlotUtils", "Requires", "Statistics"]
git-tree-sha1 = "a3a964ce9dc7898193536002a6dd892b1b5a6f1d"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "2.0.1"

[[PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "Printf", "Random", "Reexport", "Statistics"]
git-tree-sha1 = "501c20a63a34ac1d015d5304da0e645f42d91c9f"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.0.11"

[[Plots]]
deps = ["Base64", "Contour", "Dates", "FFMPEG", "FixedPointNumbers", "GR", "GeometryBasics", "JSON", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "PlotThemes", "PlotUtils", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs"]
git-tree-sha1 = "1e72752052a3893d0f7103fbac728b60b934f5a5"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.19.4"

[[PlutoUI]]
deps = ["Base64", "Dates", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "Suppressor"]
git-tree-sha1 = "44e225d5837e2a2345e69a1d1e01ac2443ff9fcb"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.9"

[[PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "cde4ce9d6f33219465b55162811d8de8139c0414"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.2.1"

[[Preferences]]
deps = ["TOML"]
git-tree-sha1 = "00cfd92944ca9c760982747e9a1d0d5d86ab1e5a"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.2.2"

[[PrettyTables]]
deps = ["Crayons", "Formatting", "Markdown", "Reexport", "Tables"]
git-tree-sha1 = "0d1245a357cc61c8cd61934c07447aa569ff22e6"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "1.1.0"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[Qt5Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "xkbcommon_jll"]
git-tree-sha1 = "ad368663a5e20dbb8d6dc2fddeefe4dae0781ae8"
uuid = "ea2cea3b-5b76-57ae-a6ef-0a8af62496e1"
version = "5.15.3+0"

[[QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "12fbe86da16df6679be7521dfb39fbc861e1dc7b"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.4.1"

[[REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[Ratios]]
git-tree-sha1 = "37d210f612d70f3f7d57d488cb3b6eff56ad4e41"
uuid = "c84ed2f1-dad5-54f0-aa8e-dbefe2724439"
version = "0.4.0"

[[RecipesBase]]
git-tree-sha1 = "b3fb709f3c97bfc6e948be68beeecb55a0b340ae"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.1.1"

[[RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "RecipesBase"]
git-tree-sha1 = "2a7a2469ed5d94a98dea0e85c46fa653d76be0cd"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.3.4"

[[Reexport]]
git-tree-sha1 = "5f6c21241f0f655da3952fd60aa18477cf96c220"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.1.0"

[[Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "4036a3bd08ac7e968e27c203d45f5fff15020621"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.1.3"

[[Rmath]]
deps = ["Random", "Rmath_jll"]
git-tree-sha1 = "bf3188feca147ce108c76ad82c2792c57abe7b1f"
uuid = "79098fc4-a85e-5d69-aa6a-4863f24498fa"
version = "0.7.0"

[[Rmath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "68db32dff12bb6127bac73c209881191bf0efbb7"
uuid = "f50d1b31-88e8-58de-be2c-1cc44531875f"
version = "0.3.0+0"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[Scratch]]
deps = ["Dates"]
git-tree-sha1 = "0b4b7f1393cff97c33891da2a0bf69c6ed241fda"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.1.0"

[[SentinelArrays]]
deps = ["Dates", "Random"]
git-tree-sha1 = "35927c2c11da0a86bcd482464b93dadd09ce420f"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.3.5"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "b3363d7460f7d098ca0912c69b082f75625d7508"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.0.1"

[[SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[SpecialFunctions]]
deps = ["ChainRulesCore", "LogExpFunctions", "OpenSpecFun_jll"]
git-tree-sha1 = "508822dca004bf62e210609148511ad03ce8f1d8"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "1.6.0"

[[StackViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "46e589465204cd0c08b4bd97385e4fa79a0c770c"
uuid = "cae243ae-269e-4f55-b966-ac2d0dc13c15"
version = "0.1.1"

[[StaticArrays]]
deps = ["LinearAlgebra", "Random", "Statistics"]
git-tree-sha1 = "885838778bb6f0136f8317757d7803e0d81201e4"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.2.9"

[[Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[StatsAPI]]
git-tree-sha1 = "1958272568dc176a1d881acb797beb909c785510"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.0.0"

[[StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "fed1ec1e65749c4d96fc20dd13bea72b55457e62"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.9"

[[StatsFuns]]
deps = ["LogExpFunctions", "Rmath", "SpecialFunctions"]
git-tree-sha1 = "30cd8c360c54081f806b1ee14d2eecbef3c04c49"
uuid = "4c63d2b9-4356-54db-8cca-17b64c39e42c"
version = "0.9.8"

[[StatsPlots]]
deps = ["Clustering", "DataStructures", "DataValues", "Distributions", "Interpolations", "KernelDensity", "LinearAlgebra", "MultivariateStats", "Observables", "Plots", "RecipesBase", "RecipesPipeline", "Reexport", "StatsBase", "TableOperations", "Tables", "Widgets"]
git-tree-sha1 = "e7d1e79232310bd654c7cef46465c537562af4fe"
uuid = "f3b207a7-027a-5e70-b257-86293d7955fd"
version = "0.14.26"

[[StructArrays]]
deps = ["Adapt", "DataAPI", "StaticArrays", "Tables"]
git-tree-sha1 = "000e168f5cc9aded17b6999a560b7c11dda69095"
uuid = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
version = "0.6.0"

[[SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[Suppressor]]
git-tree-sha1 = "a819d77f31f83e5792a76081eee1ea6342ab8787"
uuid = "fd094767-a336-5f1f-9728-57cf17d0bbfb"
version = "0.2.0"

[[TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[TableOperations]]
deps = ["SentinelArrays", "Tables", "Test"]
git-tree-sha1 = "a7cf690d0ac3f5b53dd09b5d613540b230233647"
uuid = "ab02a1b2-a7df-11e8-156e-fb1833f50b87"
version = "1.0.0"

[[TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "TableTraits", "Test"]
git-tree-sha1 = "d0c690d37c73aeb5ca063056283fde5585a41710"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.5.0"

[[Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[TiledIteration]]
deps = ["OffsetArrays"]
git-tree-sha1 = "52c5f816857bfb3291c7d25420b1f4aca0a74d18"
uuid = "06e1c1a7-607b-532d-9fad-de7d9aa2abac"
version = "0.3.0"

[[URIs]]
git-tree-sha1 = "97bbe755a53fe859669cd907f2d96aee8d2c1355"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.3.0"

[[UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[Wayland_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "3e61f0b86f90dacb0bc0e73a0c5a83f6a8636e23"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.19.0+0"

[[Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll"]
git-tree-sha1 = "2839f1c1296940218e35df0bbb220f2a79686670"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.18.0+4"

[[Widgets]]
deps = ["Colors", "Dates", "Observables", "OrderedCollections"]
git-tree-sha1 = "eae2fbbc34a79ffd57fb4c972b08ce50b8f6a00d"
uuid = "cc8bc4a8-27d6-5769-a93b-9d913e69aa62"
version = "0.6.3"

[[WoodburyMatrices]]
deps = ["LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "59e2ad8fd1591ea019a5259bd012d7aee15f995c"
uuid = "efce3f68-66dc-5838-9240-27a6d6f5f9b6"
version = "0.5.3"

[[XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "1acf5bdf07aa0907e0a37d3718bb88d4b687b74a"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.9.12+0"

[[XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "5be649d550f3f4b95308bf0183b82e2582876527"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.6.9+4"

[[Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4e490d5c960c314f33885790ed410ff3a94ce67e"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.9+4"

[[Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fe47bd2247248125c428978740e18a681372dd4"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.3+4"

[[Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "b7c0aa8c376b31e4852b360222848637f481f8c3"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.4+4"

[[Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "0e0dc7431e7a0587559f9294aeec269471c991a4"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "5.0.3+4"

[[Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "89b52bc2160aadc84d707093930ef0bffa641246"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.7.10+4"

[[Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll"]
git-tree-sha1 = "26be8b1c342929259317d8b9f7b53bf2bb73b123"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.4+4"

[[Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "34cea83cb726fb58f325887bf0612c6b3fb17631"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.2+4"

[[Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "19560f30fd49f4d4efbe7002a1037f8c43d43b96"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.10+4"

[[Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "6783737e45d3c59a4a4c4091f5f88cdcf0908cbb"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.0+3"

[[Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "daf17f441228e7a3833846cd048892861cff16d6"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.13.0+3"

[[Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "926af861744212db0eb001d9e40b5d16292080b2"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.0+4"

[[Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "0fab0a40349ba1cba2c1da699243396ff8e94b97"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.0+1"

[[Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll"]
git-tree-sha1 = "e7fd7b2881fa2eaa72717420894d3938177862d1"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.0+1"

[[Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "d1151e2c45a544f32441a567d1690e701ec89b00"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.0+1"

[[Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "dfd7a8f38d4613b6a575253b3174dd991ca6183e"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.9+1"

[[Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "e78d10aab01a4a154142c5006ed44fd9e8e31b67"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.1+1"

[[Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "4bcbf660f6c2e714f87e960a171b119d06ee163b"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.2+4"

[[Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "5c8424f8a67c3f2209646d4425f3d415fee5931d"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.27.0+4"

[[Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "79c31e7844f6ecf779705fbc12146eb190b7d845"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.4.0+3"

[[Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "cc4bf3fdde8b7e3e9fa0351bdeedba1cf3b7f6e6"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.0+0"

[[libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "acc685bcf777b2202a904cdcb49ad34c2fa1880c"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.14.0+4"

[[libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7a5780a0d9c6864184b3a2eeeb833a0c871f00ab"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "0.1.6+4"

[[libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "94d180a6d2b5e55e447e2d27a29ed04fe79eb30c"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.38+0"

[[libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "c45f4e40e7aafe9d086379e5578947ec8b95a8fb"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+0"

[[nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"

[[x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "d713c1ce4deac133e3334ee12f4adff07f81778f"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2020.7.14+2"

[[x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "487da2f8f2f0c8ee0e83f39d13037d6bbf0a45ab"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.0.0+3"

[[xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "ece2350174195bb31de1a63bea3a41ae1aa593b6"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "0.9.1+5"
"""

# ╔═╡ Cell order:
# ╟─67245814-54f5-4aae-84c5-3bee84d553f3
# ╠═c89df96d-b0f3-40f0-948f-7c5be153bd09
# ╟─b1e5cf34-0e79-4068-b0b1-737ecdb9c627
# ╟─4a306fe9-7609-4702-ab87-6de99a759108
# ╠═28534928-5027-4a1a-bf40-62cb420b93d2
# ╟─73152cfe-bfb3-494f-922f-fd3b6ad77a37
# ╟─041cd8b3-f392-4d08-a8ce-7bee92de4733
# ╠═be3afea7-02db-4466-a784-5c2eadf446d0
# ╠═f9aeca95-86d6-41e7-8749-c6bb551a494f
# ╠═4db20192-4f4a-4202-886a-407c44b43960
# ╠═3c653f10-0ec9-4112-9ed8-6697f8fdbbf0
# ╠═d0d56761-922f-4ee6-8009-61fa9cd261e2
# ╠═ce420aae-4680-4326-a3ec-c1c2a2e8e700
# ╟─991cc221-2324-4a87-b1d7-750ccd7f2250
# ╠═d2bd9518-b846-4ea5-afec-610f2d6717ae
# ╠═3181238a-e280-4957-a31b-450c8c5d3d4f
# ╟─176f7203-7aad-49b7-91fc-864c429d5bec
# ╠═a4529396-c123-48ab-af5c-15de8d014c83
# ╠═a02f5965-5404-473e-8479-127627664ad3
# ╟─ceec4764-d92e-489a-863e-8338486b74a8
# ╠═b1b94509-e4fa-4d6d-ae3d-051b71ccec5b
# ╠═44512228-2984-410e-bc81-8bbfefbd630e
# ╠═24db5165-8d5f-4b77-be3d-1a6d0583416b
# ╠═90f4ef96-b623-48dd-a6b8-0ac5d0fd01d3
# ╟─329fa0ad-babf-4527-89ba-f901eae9f0b5
# ╠═6aec3798-960f-4ecb-a36f-5e95e1e87678
# ╠═a11bee10-ed50-46fd-8fa2-65a71fe4b26c
# ╟─f9530e85-de10-4e34-aefb-05730752bfbc
# ╠═27e8324a-2969-4cef-a8be-5416e39246fc
# ╠═c9cf61f0-00f4-4ca6-b50d-f1e2da50946f
# ╟─56f20095-b58a-48ac-8917-d306f7270f9e
# ╠═c93144b4-02dc-498a-bff5-bd38887d1227
# ╠═b05ab8aa-e621-4b12-b1ba-71d4c912a1c9
# ╟─c1a8b072-a6dd-45f9-b153-e3df918d4327
# ╠═6c1f60fa-07ec-4c89-9f55-e1282ea62fbd
# ╠═35fa4472-f1a9-40b0-ac83-385de5e72cbf
# ╟─f879bf9b-b684-4dfe-8e39-a633c1c80c22
# ╠═e83448e5-78fb-46e4-9746-055aed843167
# ╠═14443b0e-1c32-4f24-8bed-a913711819ae
# ╟─50abbb37-2552-46f1-ab00-3f56cbbe2ea5
# ╠═6323d028-dd43-4aa2-93bf-9f9860f2ffe1
# ╠═3c11c625-7652-4d73-a837-4f4f2d1ebdc4
# ╟─f9ea2917-d5f3-41dc-b82d-e7de15400f1a
# ╠═dbf3f367-8659-4db8-9ba0-052913faa1e5
# ╟─8dea4b6a-4473-445b-b13f-6efd17f18b9f
# ╠═8eec5c23-e12c-4cf0-afb0-f1f492c6c565
# ╠═b765d0da-280b-449a-acd2-f16bd05ead43
# ╠═36796cf3-c5e3-46a1-8d70-d77de780434e
# ╟─75a3c8a8-e936-4c4c-802b-b99c86dde52d
# ╟─7a740f12-f387-11eb-0f95-198dcf9498ef
# ╟─3be85f4f-fb8e-466b-99ce-5631e665d889
# ╠═aa0963d0-95f2-45ce-b735-3df64174540f
# ╟─9f53b02c-c945-4e54-bdaf-7f1fb7d0dd58
# ╟─7e7e7dd5-29aa-414b-83e5-1f0d648929c3
# ╟─fc11f081-ec2f-42d0-9bd6-1403f16f0df4
# ╟─8f38431d-ab8b-4daa-9227-101d473a4edc
# ╠═d6cbd41e-e2f4-489c-a05a-81aedb54e50d
# ╟─6e1fc96a-3927-4c9f-adb2-696879b91904
# ╟─afc262e6-54a4-4cc8-81fd-355ff8a50a35
# ╟─85523352-d006-4470-aec9-5f5177acd5ec
# ╟─f6cad4f2-0dc9-481a-bf76-c96c463097a0
# ╟─1317db33-ded1-4880-be60-aa93e91d5f18
# ╠═0a1e13c4-9d87-4718-9383-15a6be6eef61
# ╟─45ee1911-5863-453f-941c-dda44002c2a7
# ╟─02bdc833-abbb-4482-a5b6-c68c51c0140f
# ╠═a9d997bc-5099-4d68-b11d-eca32fcc24b2
# ╟─c9d7b733-465a-4d27-808a-127787a023de
# ╟─50494dac-e234-43f3-9a71-ff03fad98a38
# ╟─8adb5c36-a878-4883-a0e2-04379a9431f6
# ╠═3f9cbcb4-47f9-4a44-885b-262d51bb2c23
# ╟─0929878b-45d2-4ccf-859b-3ddf136c44a8
# ╟─108a83bc-2ca0-4d85-941a-cfb9500b062a
# ╠═00bf1cb8-432b-4048-bb02-ea0664e31504
# ╟─52fe2fad-4d4d-458c-b2bd-c48bc25ed90b
# ╟─833414c9-7905-4d2b-9377-3e1a2ce7eb8c
# ╠═b3c1fa94-1234-4699-9c88-999907e1b2b4
# ╟─9c332ac9-826f-48c0-8c98-bebc23f1664f
# ╠═2bf34da3-5892-44bd-9df3-5662a695deee
# ╟─898c4112-b22b-45f9-9a00-6cba26401c72
# ╠═290abf61-943b-46ce-8197-5a8173701c0b
# ╠═b125a2a8-1ba3-47e9-bebe-691923ff82fa
# ╟─f1434571-169d-4252-b6ed-2e0d25b7c529
# ╟─223bc6c5-d642-4efb-ad40-d6b0f392ebe4
# ╟─1ce7d8a0-1e56-44a1-a513-46a6de76ef87
# ╟─ab465a1e-2f1c-413f-a7b5-667974befafe
# ╟─1c27f580-2749-4b20-b558-10efaf0eb61b
# ╠═6e97b9f6-8a97-4533-ab05-97d10a6b5377
# ╠═8930984a-75e1-4672-be9f-900300ff4bbe
# ╟─ae5500bb-a5b4-486e-8cd2-46600e30ec31
# ╠═3e0c0798-4639-44d4-bfd8-6b97c01a36da
# ╟─7cf4d832-2696-450b-9925-4a570496b02f
# ╠═16599ebf-5a0a-4aec-b294-fc6557810fec
# ╟─41cf8342-01c8-4754-b2e9-a8a744848061
# ╠═7707af83-f951-4340-8f03-dff10ad8d4b8
# ╠═3bb1756f-d976-4821-bc72-6bdcc3e96e72
# ╟─f4b61973-7cdd-4461-ba89-6e8990cea4ee
# ╟─0835d3a8-ee0c-4dd6-ae17-7c1ab9c707b2
# ╠═4f63dc46-8bfc-4963-9fde-3c3018240c59
# ╠═df8d2ccb-e4a7-49ec-a5e1-22cb8f49aa55
# ╟─6280213f-147c-4559-8a80-d244745929ac
# ╠═cc1ad821-1093-4376-a14e-906a25ebeb36
# ╟─e1e91cfd-7c5f-452d-bb1a-16057ee6724e
# ╟─114e6a11-974e-46c3-9fc9-59befeb9f037
# ╟─c78b6af7-daf7-47e1-b4ac-86e3d5d9a814
# ╟─e38db4b3-b577-4a3c-b0ed-36ae9d1d3059
# ╠═a2429530-2457-4d0f-b094-2205f6e6cdbb
# ╟─c76b9356-3488-4417-93eb-8bb4d3c3596f
# ╟─da908b2f-b7d7-475e-8f61-f0224af84ac5
# ╠═25a1e5ac-55fd-484b-a382-4004f55672d9
# ╟─1e9361c6-d140-49e7-aa74-bd5c665c9fb9
# ╟─203fb251-3b5d-4351-b4e8-b9824beff593
# ╠═55e9dfdf-e2f1-4580-8af8-1262d13f3d81
# ╟─a1c3947b-be3b-4cdb-9fa9-ba636aac3b37
# ╟─593b28d2-c700-488d-9fd0-a0c00c68f763
# ╠═c17fe419-a8cd-4d8c-b713-2291c07e9029
# ╠═c1407c04-1254-403b-b413-3adce4295f35
# ╟─8c8e8706-3ee1-408e-a307-1d4c81876969
# ╟─f4ee314a-0b62-4a1f-86cf-1ae64f89ca63
# ╟─78697e6e-6a7e-4192-96a5-5c05067c01bf
# ╠═bc1205c9-80e6-420b-b954-e83572cbeb97
# ╠═9920e43b-c202-4d99-87db-77b0bcf3d419
# ╟─e0ad48dc-cf12-41bd-9a4e-611284fff24d
# ╠═5c60e077-2ef3-448d-a4d3-bb4a2d4c0138
# ╠═eb75f174-aff7-499e-b1d1-08932c3ca288
# ╠═d6da6908-3117-47fb-a24d-7113b1b171ef
# ╠═0022254c-bd64-439e-ab42-3b14c252131a
# ╠═29693460-f01a-4911-af4a-5bd9b9076414
# ╠═e136f4a4-04f6-410c-8a2d-b3b17cd92ca0
# ╟─597bc4d4-8b71-4dc1-9a21-6d6734fbb6b0
# ╠═5ebfb1e6-b90e-4f85-a06c-6725f26381b3
# ╟─d11af250-db23-4c99-9fc0-bc1cf2063580
# ╠═62a8d4d7-d112-4679-9958-e08111a92e37
# ╠═be012f99-f8b4-4400-a29b-082ae409f348
# ╠═ecc67ca2-6ddc-4ff3-91f1-9974df3bc76e
# ╠═c77e9b70-7b3b-4ebf-a793-400ff61b774c
# ╠═3d18f4c0-c0d7-4feb-a8ea-467bb5c05827
# ╠═21bef124-5657-4a63-9695-7a2737a544f3
# ╠═2f270372-c3a0-4e78-8e3d-6395b82d8f21
# ╠═34146626-c30a-4326-a808-673f632a85dc
# ╠═cc0b0931-5be3-444c-a75d-0abc3f51b365
# ╠═9b64338d-878d-4a42-ac6f-69324505b41f
# ╟─450423a5-e994-4f55-9d0e-0a90f66c087c
# ╟─961884ef-e691-4d6b-b0c7-fb2c1297caa5
# ╠═c1d6ba6b-4ce1-4e41-82f6-3752f9304e91
# ╟─45154675-0f0c-411d-8126-b507c2e5cb81
# ╟─e3c39898-a528-4fce-a304-a5577a0c8c99
# ╟─c29324cc-672d-4bbf-b8e4-d812a20c112b
# ╠═6ecf6b84-6e73-4a59-b65e-e838fb10f181
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
