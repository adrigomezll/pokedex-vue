<script setup>
defineProps({
    equipo: Array
})

const emit = defineEmits(['eliminar-del-equipo'])
</script>

<template>
<div class="pokemon-equipo">

    <h2>Mi equipo pokemon</h2>

    <p v-if="equipo.length === 0">
        No hay ningun Pokemon en el equipo.
    </p>

    <div
    v-for="pokemon in equipo"
    :key="pokemon.numero"
    class="pokemon-equipo-carta"
    >

    <img :src="pokemon.imagen" :alt="pokemon.nombre">

    <div>
        <h3>#{{ pokemon.numero }} {{ pokemon.nombre }}</h3>

        <button @click="emit('eliminar-del-equipo',pokemon)">Eliminar del equipo</button>

    </div>

    </div>

</div>

</template>