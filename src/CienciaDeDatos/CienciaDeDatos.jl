### A Pluto.jl notebook ###
# v0.15.1

using Markdown
using InteractiveUtils

# ╔═╡ b107d7f9-90c3-4a9f-9b55-0e1dc323ee56
using PlutoUI

# ╔═╡ ad6469ef-68a5-4819-bf98-85d06d37b960
using CSV

# ╔═╡ f31b4062-c763-4647-84ef-b3db25406fc8
using HTTP

# ╔═╡ 6cab610d-e713-4b08-8a5b-5eab8820732f
using DataFrames

# ╔═╡ 6fc301b3-18f2-44e8-91d2-268e10c3a0e6
using BenchmarkTools

# ╔═╡ 6b4a8fd1-60f5-4760-a453-86a75a201a5f
md"""# Notebok sobre Ciencia de Datos

	- Oscar Alejando Esquivel Flores
	- Óscar Anuar Alvarado Morán
	- Mario Horacio Garrido Czacki
"""

# ╔═╡ ef6340c4-f4f7-11eb-30f9-599dcebb98be
PlutoUI.TableOfContents(title="🔬 Ciencia de datos 🔭")

# ╔═╡ d24051dc-5efa-48c8-b65b-c756ba43b864
md"# Manejo de datos"

# ╔═╡ b1a67905-09f3-41aa-9a87-362d051fc69f
md"## CSV.jl
- [GitHub](https://github.com/JuliaData/CSV.jl)
- [JuliaData](https://csv.juliadata.org/stable/)"

# ╔═╡ 6069ba43-4a4d-4c59-a465-098385eb6e80
md"### Leyendo csv
Usemos la función `CSV.File` para leer archivos `.csv`. Podemos hacerlo desde archivos locales:"

# ╔═╡ a3c21e5d-a030-4cf3-aed3-e7100a885d37
hotel = CSV.File("Julia-IIMAS-v1.0/datos/hotel_bookings.csv")

# ╔═╡ 6baca64d-6dcb-44d7-b03d-69c0322631fe
md"O también podemos leer desde una página con la paquetería `HTTP.jl`"

# ╔═╡ e32d05c9-5896-4435-8f4c-15f887d6b256
begin
	url = "https://raw.githubusercontent.com/OscarAlvaradoM/Pokemon/master/datos/Disp8_completo.csv"
	pokemon = CSV.File(HTTP.get(url).body)
end

# ╔═╡ bf9cd655-eafe-41d2-ab06-f0a53cde9455
pokemon.names

# ╔═╡ f653a134-d37a-4959-bf81-40c2d20d4a87
pokemon.cols

# ╔═╡ 7ea3c9a3-a369-4ee9-908d-ed8b7d1ae3cb
md"### Delimitador"

# ╔═╡ 36b56e8b-dde9-4fcb-a3f9-a93fb3101cdf
md"""
	col1::col2
	1::2
	3::4
```Julia
CSV.File(file; delim="::")
```
"""

# ╔═╡ fcd2724d-aa29-4e7b-8d39-818463e7ceb5
md"### Sin encabezado"

# ╔═╡ 6165b59f-2c9c-44d8-b914-a307f99a5a48
md"""
	1,2,3
	4,5,6
	7,8,9
```Julia
CSV.File(file; header=false)
CSV.File(file; header=["col1", "col2", "col3"])
CSV.File(file; header=[:col1, :col2, :col3])
```
"""

# ╔═╡ c36c1741-21fe-4758-a82d-dbf3439830cd
md"### Datarow"

# ╔═╡ 51e1ee64-9541-4ee2-9499-748811dacac9
md"""
	col1,col2,col3
	metadata1,metadata2,metadata3
	extra1,extra2,extra3
	1,2,3
	4,5,6
	7,8,9

```Julia
CSV.File(file; datarow=4)
CSV.File(file; skipto=4)
```
"""

# ╔═╡ e2da47f5-d1bf-4060-8113-5fa2a7de56ff
md"### Leyendo lotes"

# ╔═╡ 4ece0521-051e-475c-bec9-10f38beb009d
md"""
	col1,col2,col3
	1,2,3
	4,5,6
	7,8,9
	10,11,12
	13,14,15
	16,17,18
	19,20,21

```Julia
CSV.File(file; limit=3)
CSV.File(file; skipto=4, limit=1)
CSV.File(file; skipto=7, footerskip=1)
```
"""

# ╔═╡ 236f6a7d-86a5-4bbc-a0d8-49f06e1714bf
md"### Reenglones comentados"

# ╔═╡ 66e15e9e-f283-487d-8e73-ae5ec23edb54
md"""
	col1,col2,col3
	# this row is commented and we'd like to ignore it while parsing
	1,2,3
	4,5,6

```Julia
CSV.File(file; comment="#")
CSV.File(file; datarow=3)
```
"""

# ╔═╡ 72e80a6f-8d30-4a85-a154-d2fbfc653421
md"### Valores nulos"

# ╔═╡ 0b5f90c0-7b51-484a-a023-0f533167bf7b
md"""
	code,age,score
	0,21,3.42
	1,42,6.55
	-999,81,NA
	-999,83,NA

```Julia
CSV.File(file; missingstring="-999")
CSV.File(file; missingstrings=["-999", "NA"])
```
"""

# ╔═╡ 720f5fe8-0616-4480-be24-b81764c4361f
md"### Fechas"

# ╔═╡ 7cbe09ae-5dcc-4c42-b824-bd401ed7f18b
md"""
	code,date
	0,2019/01/01
	1,2019/01/02

```Julia
CSV.File(file; dateformat="yyyy/mm/dd")
```
"""

# ╔═╡ 6b8336a6-fac6-4042-84e5-2cf4a0bf83b7
md"### Asignando tipos"

# ╔═╡ 9d3653a3-a617-4694-bc87-72d2606245c9
md"""
	col1,col2,col3
	1,2,3
	4,5,invalid
	6,7,8

```Julia
CSV.File(file; types=Dict(3 => Int))
CSV.File(file; types=Dict(:col3 => Int))
CSV.File(file; types=Dict("col3" => Int))
CSV.File(file; types=[Int, Int, Int])
CSV.File(file; types=[Int, Int, Int], silencewarnings=true)
CSV.File(file; types=[Int, Int, Int], strict=true)
```
"""

# ╔═╡ 7f43e8c7-7ac8-4aa2-acae-87e0c3814da1
md"### Seleccionar o eliminar columnas de un archivo"

# ╔═╡ ffb89c6b-cdd1-4a64-8ad7-b512373dfa1a
md"""
	a,b,c
	1,2,3
	4,5,6
	7,8,9

```Julia
# select
CSV.File(file; select=[1, 3])
CSV.File(file; select=[:a, :c])
CSV.File(file; select=["a", "c"])
CSV.File(file; select=[true, false, true])
CSV.File(file; select=(i, nm) -> i in (1, 3))
# drop
CSV.File(file; drop=[2])
CSV.File(file; drop=[:b])
CSV.File(file; drop=["b"])
CSV.File(file; drop=[false, true, false])
CSV.File(file; drop=(i, nm) -> i == 2)
```
"""

# ╔═╡ acf3fc88-d7cd-4bf9-ba4b-dd166984d7aa
md"## DataFrames.jl
- [GitHub](https://github.com/JuliaData/DataFrames.jl)
- [JuliaData](https://dataframes.juliadata.org/stable/#)"

# ╔═╡ 92056bbd-8dde-4b38-8780-02e248c6cfd3
md"### Transformando de un CSV.File a DataFrame"

# ╔═╡ fdbd56bb-4a02-436a-9ee3-552b373547c7
df_poke = CSV.read(HTTP.get("https://raw.githubusercontent.com/OscarAlvaradoM/Pokemon/master/datos/Disp8_completo.csv").body, DataFrame)

# ╔═╡ ccd0662b-455d-453f-be8c-d0a998910a7f
df_pokemon = DataFrame(pokemon)

# ╔═╡ 97d67ce7-cfb5-47fd-9ea3-272ded84e9fd
methodswith(typeof(df_pokemon))

# ╔═╡ 21f1d7dd-a865-4e8b-ab03-cd81b91f5f29
names(df_pokemon)

# ╔═╡ 6dc1461e-ad0e-4020-825a-a696de245ca8
nrow(df_pokemon)

# ╔═╡ 7dd8b809-0870-4945-97d2-2a655d0fcc63
md"### Creando DataFrames desde 0"

# ╔═╡ fd76cca7-48c0-474a-b826-3be1d7c54c14
DataFrame(A=1:3, B=5:7, fixed=1)

# ╔═╡ a5f4bad2-2919-4241-9178-e944e42d69a5
DataFrame("Edad" => ["?", 23, 24], "Nombre" => ["Oscar", "Mario", "Anuar"])

# ╔═╡ b2fbf649-32b6-4dd8-894c-9ca2e2fa1e9c
begin
	dict_edades1 = Dict("Edad" => ["?", 23, 24], "Nombre" => ["Oscar", "Mario", "Anuar"])
	DataFrame(dict_edades1)
end

# ╔═╡ 8b1d8c99-7fa1-4054-ae7d-52b01a97b0b3
begin
	dict_edades2 = Dict(:Edad => ["?", 23, 24], :Nombre => ["Oscar", "Mario", "Anuar"])
	DataFrame(dict_edades2)
end

# ╔═╡ 76dbe6fa-7426-4ef1-874a-7463602e6c7c
DataFrame((a=[1, 2], b=[3, 4]))

# ╔═╡ bbae294a-01f4-47a3-9cfb-99e8e0978796
DataFrame([(a=1, b=0), (a=2, b=0)])

# ╔═╡ 064bea34-0890-4d27-8c5c-63d7f66e10ac
DataFrame([1 0; 2 0], ["A", "B"])

# ╔═╡ 35fef6ab-eaf7-4e39-8424-1e77ef29a4f1
DataFrame([1 0; 2 0], :auto)

# ╔═╡ e13caf23-fe50-456a-a7f0-1df74580e6c6
md"### Operaciones básicas sobre DataFrames"

# ╔═╡ 2d0dd71a-d577-4d56-bf42-31ce47d0bebe
names(df_pokemon)

# ╔═╡ 41424723-6627-4462-9e31-36ef20933230
md"Esto no es una copia"

# ╔═╡ 816b06b0-82b9-45ce-8cbb-22061363c936
df_pokemon.Nombre

# ╔═╡ 8784abe2-688d-401f-bce0-0ad02b4b7e76
md"Esto es una copia:"

# ╔═╡ efca9fcb-2378-49ad-b82b-a528674944da
df_pokemon[:, :Nombre]

# ╔═╡ 0cd53836-8853-46da-86f4-2a11bee5bed8
md"Y esto ¿qué es?"

# ╔═╡ 0eb90afd-4e1c-4bf2-b8a4-b7241ed7d042
df_pokemon[!, :Nombre]

# ╔═╡ 7c787df1-3f7e-4057-91e2-db9b0a42b11f
df_pokemon.Nombre === df_pokemon[!, :Nombre]

# ╔═╡ e426364d-dc2d-45a7-8e3f-a7d63424433e
df_pokemon.Nombre === df_pokemon[:, :Nombre]

# ╔═╡ d96f14f8-dc5c-4adf-899e-5e9497e9bba1
eltype.(eachcol(df_pokemon))

# ╔═╡ 79bf46e7-96c3-488d-9ced-e35798d6ed09
size(df_pokemon)

# ╔═╡ d6b8b7f2-2eff-4201-b53f-c10848942f9b
nrow(df_pokemon)

# ╔═╡ dfe4c5c0-d51d-4aae-abe7-604619a16e17
ncol(df_pokemon)

# ╔═╡ 22b933e1-9763-4922-b72d-a9f59477aaaf
describe(df_pokemon, cols=1:10)

# ╔═╡ 4e6a6592-72dd-4e59-9cb8-e4aa75b82c3f
mapcols(Altura_m -> Altura_m.^2, df_pokemon)

# ╔═╡ dc16d155-379f-4d2a-8e01-825c384c117c
df_pokemon.Altura_m

# ╔═╡ f413974c-b210-4d9e-bc3f-c5b0d3f28e69
first(df_pokemon, 8)

# ╔═╡ 5f96e230-7e61-4a1e-962f-8ca5f0d0be60
last(df_pokemon, 5)

# ╔═╡ 466e107d-1c7a-4a15-a08b-c9120b84a917
df_pokemon[1:5, [:Nombre, :Clasificación]]

# ╔═╡ b7935362-ac6b-47a8-9106-cc2beaac70a8
df_pokemon[[1, 6, end], :]

# ╔═╡ 8d0b9978-b04a-436d-bf13-6946b043e48d
@view df_pokemon[end:-1:1, [:Nombre, :Generación]]

# ╔═╡ 38452d24-76bd-4d75-9f9b-39d5d0d2dae8
@btime @view $df_pokemon[1:end-1, 1:end-1]

# ╔═╡ 68733a99-4d7e-4256-a168-2032de50ab80
@btime $df_pokemon[1:end-1, 1:end-1];

# ╔═╡ e0968f67-1995-45d1-81e5-f6fb875312d5
df_pokemon.Contra_acero .= 1.

# ╔═╡ e51c2334-fd90-4847-9877-05ed2390d45a
insertcols!(df_pokemon, 1, :Juego => "Pokemon")

# ╔═╡ 432e6d0a-7671-4b3c-a8c4-0508a418cee7
df_pokemon[:, Not(:Evolución)]

# ╔═╡ 7e693874-9155-4c2f-8b4c-3543454fbb56
df_pokemon[:, Between(:Juego, :Generación)]

# ╔═╡ 7cc17b78-8f2a-49de-a7a6-99ab6d89b0e0
df_pokemon[:, Cols(:Altura_m, Between(:Juego, :Generación))]

# ╔═╡ ab72fb5f-90ac-446c-88d6-938852f3816e
md"Haciendo algunos joins"

# ╔═╡ 9c851f5a-4c8f-4388-86a1-ff6a3d83c8fe
people = DataFrame(ID = [20, 40], Name = ["John Doe", "Jane Doe"])

# ╔═╡ 6f6459c8-8242-4340-a588-0512eff5d5c3
jobs = DataFrame(ID = [20, 60], Job = ["Lawyer", "Doctor"])

# ╔═╡ db565011-1563-41cc-84d0-e14c8237aa8a
innerjoin(people, jobs, on = :ID)

# ╔═╡ f518b097-a6f4-4bf5-ba36-0088f5fc6b94
leftjoin(people, jobs, on = :ID)

# ╔═╡ 98693a39-71de-4e60-bf66-42e30618e254
rightjoin(people, jobs, on = :ID)

# ╔═╡ f1ea0441-6910-4704-906a-3e6cf05b4105
df = DataFrame(i = 1:5,x = [missing, 4, missing, 2, 1],y = [missing, missing, "c", "d", "e"])

# ╔═╡ a0d7c872-8c54-4eed-9a01-1ca92c2d6a28
dropmissing(df)

# ╔═╡ 65729744-b221-488d-b1ad-85981489916c
dropmissing(df, :x)

# ╔═╡ c0b3f6a7-341c-435a-b528-3a190f5c500c
md"Una buena comparación con Pandas y R:

[DataFrames (JuliaData)](https://dataframes.juliadata.org/stable/man/comparisons/)"

# ╔═╡ 185015b8-d252-4beb-96f0-4d2483f79344
md"# Tarea
Buscar un conjunto de datos de tu interés con el cuál trabajar para aprendizaje automatizado, leerlo y analizarlo con julia"

# ╔═╡ e9fcbd2a-6c9b-4e07-bcae-b990ebc1a3da
md"# Aprendizaje Automatizado"

# ╔═╡ 042c51dc-80d8-4c19-9c87-4e3e83de5e19
md"## MLJ.jl
- [GitHub](https://github.com/alan-turing-institute/MLJ.jl)
- [Alan Turing Institute](https://alan-turing-institute.github.io/MLJ.jl/dev/)"

# ╔═╡ 44899540-8148-4b83-a88a-9b8b4d73ce82


# ╔═╡ 18624127-8d76-4b10-ab15-5e7cd4caea79
md"## ScikitLearn.jl
- [Docs](https://scikitlearnjl.readthedocs.io/en/latest/)"

# ╔═╡ caa805f8-7ece-429b-b63b-0542dbe159c1


# ╔═╡ 4247ed0b-7722-4ea9-a243-a48644bc65ee
md"# Aprendizaje profundo"

# ╔═╡ b0bc0de6-a0ab-49c6-a425-6df330e877d4
md"## Flux.jl
- [GitHub](https://github.com/FluxML/Flux.jl)
- [fluxml](https://fluxml.ai/)"

# ╔═╡ 798ee25d-3767-462d-b7d8-522f20754f78


# ╔═╡ 4ec0cfec-f200-4063-9cf0-5979cd369af9
md"# Big Data"

# ╔═╡ 03a434ee-d037-4607-b346-94b31e5a0fa5
md"## Spark.jl
- [GitHub](https://github.com/dfdx/Spark.jl)"

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
BenchmarkTools = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
CSV = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
HTTP = "cd3eb016-35fb-5094-929b-558a96fad6f3"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
BenchmarkTools = "~1.1.1"
CSV = "~0.8.5"
DataFrames = "~1.2.2"
HTTP = "~0.9.13"
PlutoUI = "~0.7.9"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[BenchmarkTools]]
deps = ["JSON", "Logging", "Printf", "Statistics", "UUIDs"]
git-tree-sha1 = "c31ebabde28d102b602bada60ce8922c266d205b"
uuid = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
version = "1.1.1"

[[CSV]]
deps = ["Dates", "Mmap", "Parsers", "PooledArrays", "SentinelArrays", "Tables", "Unicode"]
git-tree-sha1 = "b83aa3f513be680454437a0eee21001607e5d983"
uuid = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
version = "0.8.5"

[[Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "344f143fa0ec67e47917848795ab19c6a455f32c"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.32.0"

[[Crayons]]
git-tree-sha1 = "3f71217b538d7aaee0b69ab47d9b7724ca8afa0d"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.0.4"

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

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[HTTP]]
deps = ["Base64", "Dates", "IniFile", "Logging", "MbedTLS", "NetworkOptions", "Sockets", "URIs"]
git-tree-sha1 = "44e3b40da000eab4ccb1aecdc4801c040026aeb5"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "0.9.13"

[[IniFile]]
deps = ["Test"]
git-tree-sha1 = "098e4d2c533924c921f9f9847274f2ad89e018b8"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.0"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[InvertedIndices]]
deps = ["Test"]
git-tree-sha1 = "15732c475062348b0165684ffe28e85ea8396afc"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.0.0"

[[IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "81690084b6198a2e1da36fcfda16eeca9f9f24e4"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.1"

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

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[LinearAlgebra]]
deps = ["Libdl"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

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

[[Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "4ea90bd5d3985ae1f9a908bd4500ae88921c5ce7"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.0"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[Parsers]]
deps = ["Dates"]
git-tree-sha1 = "bfd7d8c7fd87f04543810d9cbd3995972236ba1b"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "1.1.2"

[[Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

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

[[PrettyTables]]
deps = ["Crayons", "Formatting", "Markdown", "Reexport", "Tables"]
git-tree-sha1 = "0d1245a357cc61c8cd61934c07447aa569ff22e6"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "1.1.0"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[Reexport]]
git-tree-sha1 = "5f6c21241f0f655da3952fd60aa18477cf96c220"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.1.0"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[SentinelArrays]]
deps = ["Dates", "Random"]
git-tree-sha1 = "a3a337914a035b2d59c9cbe7f1a38aaba1265b02"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.3.6"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

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

[[Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[Suppressor]]
git-tree-sha1 = "a819d77f31f83e5792a76081eee1ea6342ab8787"
uuid = "fd094767-a336-5f1f-9728-57cf17d0bbfb"
version = "0.2.0"

[[TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

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

[[Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[URIs]]
git-tree-sha1 = "97bbe755a53fe859669cd907f2d96aee8d2c1355"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.3.0"

[[UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╟─6b4a8fd1-60f5-4760-a453-86a75a201a5f
# ╠═b107d7f9-90c3-4a9f-9b55-0e1dc323ee56
# ╠═ef6340c4-f4f7-11eb-30f9-599dcebb98be
# ╟─d24051dc-5efa-48c8-b65b-c756ba43b864
# ╟─b1a67905-09f3-41aa-9a87-362d051fc69f
# ╠═ad6469ef-68a5-4819-bf98-85d06d37b960
# ╟─6069ba43-4a4d-4c59-a465-098385eb6e80
# ╠═a3c21e5d-a030-4cf3-aed3-e7100a885d37
# ╟─6baca64d-6dcb-44d7-b03d-69c0322631fe
# ╠═f31b4062-c763-4647-84ef-b3db25406fc8
# ╠═e32d05c9-5896-4435-8f4c-15f887d6b256
# ╠═bf9cd655-eafe-41d2-ab06-f0a53cde9455
# ╠═f653a134-d37a-4959-bf81-40c2d20d4a87
# ╟─7ea3c9a3-a369-4ee9-908d-ed8b7d1ae3cb
# ╟─36b56e8b-dde9-4fcb-a3f9-a93fb3101cdf
# ╟─fcd2724d-aa29-4e7b-8d39-818463e7ceb5
# ╟─6165b59f-2c9c-44d8-b914-a307f99a5a48
# ╟─c36c1741-21fe-4758-a82d-dbf3439830cd
# ╟─51e1ee64-9541-4ee2-9499-748811dacac9
# ╟─e2da47f5-d1bf-4060-8113-5fa2a7de56ff
# ╟─4ece0521-051e-475c-bec9-10f38beb009d
# ╟─236f6a7d-86a5-4bbc-a0d8-49f06e1714bf
# ╟─66e15e9e-f283-487d-8e73-ae5ec23edb54
# ╟─72e80a6f-8d30-4a85-a154-d2fbfc653421
# ╟─0b5f90c0-7b51-484a-a023-0f533167bf7b
# ╟─720f5fe8-0616-4480-be24-b81764c4361f
# ╟─7cbe09ae-5dcc-4c42-b824-bd401ed7f18b
# ╟─6b8336a6-fac6-4042-84e5-2cf4a0bf83b7
# ╟─9d3653a3-a617-4694-bc87-72d2606245c9
# ╟─7f43e8c7-7ac8-4aa2-acae-87e0c3814da1
# ╟─ffb89c6b-cdd1-4a64-8ad7-b512373dfa1a
# ╟─acf3fc88-d7cd-4bf9-ba4b-dd166984d7aa
# ╠═6cab610d-e713-4b08-8a5b-5eab8820732f
# ╟─92056bbd-8dde-4b38-8780-02e248c6cfd3
# ╠═fdbd56bb-4a02-436a-9ee3-552b373547c7
# ╠═ccd0662b-455d-453f-be8c-d0a998910a7f
# ╠═97d67ce7-cfb5-47fd-9ea3-272ded84e9fd
# ╠═21f1d7dd-a865-4e8b-ab03-cd81b91f5f29
# ╠═6dc1461e-ad0e-4020-825a-a696de245ca8
# ╟─7dd8b809-0870-4945-97d2-2a655d0fcc63
# ╠═fd76cca7-48c0-474a-b826-3be1d7c54c14
# ╠═a5f4bad2-2919-4241-9178-e944e42d69a5
# ╠═b2fbf649-32b6-4dd8-894c-9ca2e2fa1e9c
# ╠═8b1d8c99-7fa1-4054-ae7d-52b01a97b0b3
# ╠═76dbe6fa-7426-4ef1-874a-7463602e6c7c
# ╠═bbae294a-01f4-47a3-9cfb-99e8e0978796
# ╠═064bea34-0890-4d27-8c5c-63d7f66e10ac
# ╠═35fef6ab-eaf7-4e39-8424-1e77ef29a4f1
# ╟─e13caf23-fe50-456a-a7f0-1df74580e6c6
# ╠═2d0dd71a-d577-4d56-bf42-31ce47d0bebe
# ╟─41424723-6627-4462-9e31-36ef20933230
# ╠═816b06b0-82b9-45ce-8cbb-22061363c936
# ╟─8784abe2-688d-401f-bce0-0ad02b4b7e76
# ╠═efca9fcb-2378-49ad-b82b-a528674944da
# ╟─0cd53836-8853-46da-86f4-2a11bee5bed8
# ╠═0eb90afd-4e1c-4bf2-b8a4-b7241ed7d042
# ╠═7c787df1-3f7e-4057-91e2-db9b0a42b11f
# ╠═e426364d-dc2d-45a7-8e3f-a7d63424433e
# ╠═d96f14f8-dc5c-4adf-899e-5e9497e9bba1
# ╠═79bf46e7-96c3-488d-9ced-e35798d6ed09
# ╠═d6b8b7f2-2eff-4201-b53f-c10848942f9b
# ╠═dfe4c5c0-d51d-4aae-abe7-604619a16e17
# ╠═22b933e1-9763-4922-b72d-a9f59477aaaf
# ╠═4e6a6592-72dd-4e59-9cb8-e4aa75b82c3f
# ╠═dc16d155-379f-4d2a-8e01-825c384c117c
# ╠═f413974c-b210-4d9e-bc3f-c5b0d3f28e69
# ╠═5f96e230-7e61-4a1e-962f-8ca5f0d0be60
# ╠═466e107d-1c7a-4a15-a08b-c9120b84a917
# ╠═b7935362-ac6b-47a8-9106-cc2beaac70a8
# ╠═8d0b9978-b04a-436d-bf13-6946b043e48d
# ╠═6fc301b3-18f2-44e8-91d2-268e10c3a0e6
# ╠═38452d24-76bd-4d75-9f9b-39d5d0d2dae8
# ╠═68733a99-4d7e-4256-a168-2032de50ab80
# ╠═e0968f67-1995-45d1-81e5-f6fb875312d5
# ╠═e51c2334-fd90-4847-9877-05ed2390d45a
# ╠═432e6d0a-7671-4b3c-a8c4-0508a418cee7
# ╠═7e693874-9155-4c2f-8b4c-3543454fbb56
# ╠═7cc17b78-8f2a-49de-a7a6-99ab6d89b0e0
# ╟─ab72fb5f-90ac-446c-88d6-938852f3816e
# ╠═9c851f5a-4c8f-4388-86a1-ff6a3d83c8fe
# ╠═6f6459c8-8242-4340-a588-0512eff5d5c3
# ╠═db565011-1563-41cc-84d0-e14c8237aa8a
# ╠═f518b097-a6f4-4bf5-ba36-0088f5fc6b94
# ╠═98693a39-71de-4e60-bf66-42e30618e254
# ╠═f1ea0441-6910-4704-906a-3e6cf05b4105
# ╠═a0d7c872-8c54-4eed-9a01-1ca92c2d6a28
# ╠═65729744-b221-488d-b1ad-85981489916c
# ╟─c0b3f6a7-341c-435a-b528-3a190f5c500c
# ╟─185015b8-d252-4beb-96f0-4d2483f79344
# ╟─e9fcbd2a-6c9b-4e07-bcae-b990ebc1a3da
# ╟─042c51dc-80d8-4c19-9c87-4e3e83de5e19
# ╠═44899540-8148-4b83-a88a-9b8b4d73ce82
# ╟─18624127-8d76-4b10-ab15-5e7cd4caea79
# ╠═caa805f8-7ece-429b-b63b-0542dbe159c1
# ╟─4247ed0b-7722-4ea9-a243-a48644bc65ee
# ╟─b0bc0de6-a0ab-49c6-a425-6df330e877d4
# ╠═798ee25d-3767-462d-b7d8-522f20754f78
# ╟─4ec0cfec-f200-4063-9cf0-5979cd369af9
# ╟─03a434ee-d037-4607-b346-94b31e5a0fa5
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
