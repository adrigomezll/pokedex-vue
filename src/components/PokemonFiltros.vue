<script setup>

defineProps({
    mostrarFavoritos: Boolean,
    tipoSeleccionado: String,
    numeroMinimo: Number,
    numeroMaximo: Number
})

const emit = defineEmits([
    'cambiar-mostrar-favoritos',
    'cambiar-tipo',
    'cambiar-numero-minimo',
    'cambiar-numero-maximo'
])

</script>

<template>
    <div class="pokemon-filtros">
        <h2>Filtros</h2>

        <label>

            <input 
            type="checkbox" 
            :checked="mostrarFavoritos"
            @change="emit('cambiar-mostrar-favoritos', $event.target.checked)">
            Mostrar solo faopritos
        </label>

        <br>

        <label>
            Tipo:
            <select 
            :value="tipoSeleccionado" 
            @change="emit('cambiar-tipo', $event.target.value)">
                <option value="">Todos</option>
                <option value="grass">Planta</option>
                <option value="fire">Fuego</option>
                <option value="water">Agua</option>
                <option value="electric">Eléctrico</option>
                <option value="normal">Normal</option>
                <option value="flying">Volador</option>
                <option value="poison">Veneno</option>
                <option value="bug">Bicho</option>
                <option value="ground">Tierra</option>
                <option value="rock">Roca</option>
                <option value="psychic">Psíquico</option>
                <option value="ice">Hielo</option>
                <option value="dragon">Dragón</option>
                <option value="ghost">Fantasma</option>
                <option value="fighting">Lucha</option>
                <option value="fairy">Hada</option>
            </select>
        </label>

        <br>

        <div>
            <p>Numero minimo: {{ numeroMinimo }}</p>
            <input 
            type="range"
            min="1"
            max="151"
            :value="numeroMinimo"
            @input="emit('cambiar-numero-minimo', Number($event.target.value))"
            >
        </div>

        <div>
             <p>Numero maximo: {{ numeroMaximo }}</p>
            <input 
            type="range"
            min="1"
            max="151"
            :value="numeroMaximo"
            @input="emit('cambiar-numero-maximo', Number($event.target.value))"
            >
        </div>
    </div>

</template>