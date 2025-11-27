<template>
  <div class="flex justify-around p-1 h-12 bg-primary">
    <UDrawer direction="left" >
      <UButton icon="material-symbols:menu-rounded" class="bg-transparent"></UButton>
      <template #content>
        <MenuMain/>
      </template>
    </UDrawer>
    <UDrawer inset>
      <UButton icon="material-symbols:square-dot-rounded" class="bg-transparent"></UButton>
      <template #content>
        <MenuTabs />
      </template>
    </UDrawer>
    <UDrawer direction="right" inset>
      <UButton icon="material-symbols:dock-to-left" class="bg-transparent"></UButton>
      <template #content>
        <ViewAlt class="w-sm"/>
      </template>
    </UDrawer>
  </div>
</template>