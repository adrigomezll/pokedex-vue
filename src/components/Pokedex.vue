    <script setup>
    import { ref, onMounted, computed } from 'vue';
    import PokemonCarta from './PokemonCarta.vue';
    import PokemonEquipo from './PokemonEquipo.vue';
    import PokemonFiltros from './PokemonFiltros.vue';


    const listaPokemons = ref([]);
    const cargando = ref(false);
    const pokemonsFavoritos = ref([]);
    const equipoPokemon = ref([])
    const mostrarSoloFavoritos = ref(false)
    const tipoSeleccionado = ref('')
    const numeroMinimo = ref(1)
    const numeroMaximo = ref(151)


    const obtenerPokemons = async () => {
        cargando.value = true
        listaPokemons.value = []

        fetch('https://pokeapi.co/api/v2/pokemon?limit=151')
            .then((respuesta) => respuesta.json())
            .then((datos) => {
                datos.results.forEach(pokemon => {
                    fetch(pokemon.url)
                        .then((respuesta) => respuesta.json())
                        .then((datosPokemon) => {
                            listaPokemons.value.push({
                                numero: datosPokemon.id,
                                nombre: datosPokemon.name,
                                imagen: datosPokemon.sprites.front_default,
                                tipos: datosPokemon.types.map((tipoInfo) => tipoInfo.type.name)
                            })

                            listaPokemons.value.sort((a, b) => a.numero - b.numero)

                            if (listaPokemons.value.length === datos.results.length) {
                                cargando.value = false
                            }
                        })
                })
            })
            .catch((error) => {
                console.log('Error al obtener los pokemons:' + error.message)
                cargando.value = false
            })
    }

    const cambiarFavorito = (pokemon) => {
        const encontrado = pokemonsFavoritos.value.find((favorito) => favorito.numero === pokemon.numero)

        if (encontrado) {
            //Lo quitamos de favs
            pokemonsFavoritos.value = pokemonsFavoritos.value.filter((favorito) => favorito.numero !== pokemon.numero)
        } else {
            pokemonsFavoritos.value.push(pokemon)
        }
    }

    const eliminarDelEquipo = (pokemon) => {
        equipoPokemon.value = equipoPokemon.value.filter((pokemonEquipo) => pokemonEquipo.numero !== pokemon.numero)
    }

    const agregarAlEquipo = (pokemon) => {
        const encontrado = equipoPokemon.value.find((pokemonEquipo) => pokemonEquipo.numero === pokemon.numero)

        if (encontrado) {
            alert('Este Pokémon ya está en el equipo')
        } else {
            if (equipoPokemon.value.length < 6) {
                equipoPokemon.value.push(pokemon)
            } else {
                alert('El equipo ya está completo')
            }
        }
        }

    const pokemonsFiltrados = computed(() => {
        return listaPokemons.value.filter((pokemon) => {

            const cumpleFavorito = !mostrarSoloFavoritos.value || pokemonsFavoritos.value.some((favorito) => favorito.numero === pokemon.numero)

            const cumpleTipo = tipoSeleccionado.value === '' || pokemon.tipos.includes(tipoSeleccionado.value)

            const cumpleNumero = pokemon.numero >= numeroMinimo.value && pokemon.numero <= numeroMaximo.value

            return cumpleFavorito && cumpleTipo && cumpleNumero

            })

        })    

        onMounted(() => {
            obtenerPokemons()
        })
</script>

    <template>

        <div class="pokedex">

            <h1>POKEDEX VUE</h1>

            <p v-if="cargando">cargando...</p>

            <p> Total Pokemon: {{ listaPokemons.length }} </p>

            <p> Favoritos: {{ pokemonsFavoritos.length }}</p>

            <p>Equipo {{ equipoPokemon.length }}/6</p>

            <PokemonFiltros
            :mostrar-favoritos="mostrarSoloFavoritos"
            :tipo-seleccionado="tipoSeleccionado"
            :numero-minimo="numeroMinimo"
            :numero-maximo="numeroMaximo"
            @cambiar-mostrar-favoritos="mostrarSoloFavoritos = $event"
            @cambiar-tipo="tipoSeleccionado = $event"
            @cambiar-numero-minimo="numeroMinimo = $event"
            @cambiar-numero-maximo="numeroMaximo = $event"
            />

            <PokemonEquipo 
            :equipo="equipoPokemon" 
            @eliminar-del-equipo="eliminarDelEquipo" />

            <p v-if="mostrarSoloFavoritos && pokemonsFavoritos.length === 0">
                No tienes ningún Pokémon favorito.
            </p>

            <p v-if="pokemonsFiltrados.length === 0">
                No hay Pokémon que coincidan con los filtros.
            </p>

            <PokemonCarta 
            v-for="pokemon in pokemonsFiltrados" 
            :key="pokemon.numero"
            :pokemon="pokemon"
            :favorito="pokemonsFavoritos.some((favorito) => favorito.numero === pokemon.numero)"
            :en-equipo="equipoPokemon.some((pokemonEquipo) => pokemonEquipo.numero === pokemon.numero)"
            @cambiar-favorito="cambiarFavorito"
            @agregar-al-equipo="agregarAlEquipo"
            />

        </div>

    </template>