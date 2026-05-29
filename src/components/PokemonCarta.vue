<script setup>

    defineProps({
        pokemon: Object,
        favorito: Boolean,
        enEquipo: Boolean,
    })

    const emit = defineEmits(['cambiar-favorito', 'agregar-al-equipo'])

</script>

<template>
<div class="pokemon-carta">
    <img :src="pokemon.imagen" :alt="pokemon.nombre">

    <div>
        <h3>#{{ pokemon.numero }} {{ pokemon.nombre }}</h3>
    </div>

    <p>Tipo: 
        <span
        v-for="tipo in pokemon.tipos"
        :key="tipo"
        >
        {{ tipo }}
    </span>
    </p>

    <button @click="emit('cambiar-favorito', pokemon)">
        <span v-if="favorito">Quitar Favorito</span>
        <span v-else>Añadir favorito</span>
    </button>

    <button @click="emit('agregar-al-equipo', pokemon)">
        <span v-if="enEquipo"> En el equipo</span>
        <span v-else>Añadir al equipo</span>

    </button>


</div>
</template>