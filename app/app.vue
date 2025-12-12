<template>
  <UApp>
    <div class="h-dvh w-dvw flex flex-col sm:flex-row">
      <MenuMain class="hidden sm:block" />
      <div class="flex flex-1">
        <ViewMain class="w-full max-h-[calc(100dvh-48px)] sm:max-h-full sm:w-2/3" />
        <ViewAlt class="w-1/3 hidden sm:block" />
      </div>
      <NavBar class="sm:hidden" />
    </div>
  </UApp>
</template>
