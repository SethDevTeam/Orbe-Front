<script setup lang="ts">
const { item } = defineProps(['item'])
</script>

<template>
  <div class="flex flex-col border border-neutral-800 rounded-lg h-[250px] overflow-hidden">
    <img class="h-[100px] w-full object-cover rounded-t-lg" :srcset="item.picture + ', default.png'" :src="item.picture"
      alt="DefaultImage">
    <div class="flex bg-accented p-1 justify-end text-sm overflow-hidden px-2">
      {{ item.name }}
    </div>
    <div class="flex-1 flex flex-col px-2">
      <div class="flex justify-between">
        <p>{{ "Stock:" }}</p>
        <p class="text-neutral-400">
          {{ item.stock }}
        </p>
      </div>
      <div class="flex justify-between items-center ">
        <p>{{ "Price:" }}</p>
        <p class="text-sm text-neutral-400">
          {{ item.price }}
        </p>
      </div>
      <div class="">
        <UBadge v-if="item.category!==''">{{ item.category }}</UBadge>
        <UBadge v-if="item.iStatus!==''">{{ item.iStatus }}</UBadge>
      </div>
    </div>
  </div>
</template>
