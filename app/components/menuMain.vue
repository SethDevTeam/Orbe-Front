<script setup lang="ts">
import { ref } from 'vue'
import brandLogo from '~/assets/images/orbe.png'
import userLogo from '~/assets/images/orbeB.png'

import { uiStore } from '~/stores/uiLogic'

const ui = uiStore()

const mainItems = [
  {
    label: 'Dashboard',
    value: 'Dashboard',
    description: 'Overview and quick access to key metrics.',
    icon: 'material-symbols:dashboard'
  },
  {
    label: 'Invoicing',
    value: 'Invoicing',
    description: 'Manage invoicing and payment operations.',
    icon: 'material-symbols:receipt'
  },
  {
    label: 'CRM',
    value: 'CRM',
    description: 'Manage customer relationships and profiles.',
    icon: 'material-symbols:person-celebrate'
  },
  {
    label: 'Inventory',
    value: 'Inventory',
    description: 'Track and manage product inventory.',
    icon: 'material-symbols:inventory'
  },
  {
    label: 'Quotations',
    value: 'Quotations',
    description: 'Create and manage customer quotations.',
    icon: 'material-symbols:description'
  }
]

const adminItems = [
  {
    label: 'Payroll',
    value: 'Payroll',
    description: 'Handle employee payroll and compensation.',
    icon: 'material-symbols:payments'
  },
  {
    label: 'Team',
    value: 'Team',
    description: 'Manage team members and roles.',
    icon: 'material-symbols:group'
  },
  {
    label: 'Reports',
    value: 'Reports',
    description: 'Generate and review business reports.',
    icon: 'material-symbols:bar-chart'
  }
]

const miniMenu = ref(false)

function toggleMenu() {
  miniMenu.value = !miniMenu.value
}

const elem = ref(false);

function toggleFullScreen() {
  if (document.fullscreenElement) {
    document.exitFullscreen();
  } else {
    document.documentElement.requestFullscreen();
  }
  elem.value = !elem.value
}

</script>

<template>
  <div class="flex flex-col overflow-y-auto" :class="{ 'p-4 w-72': !miniMenu, 'p-2 w-16 content-center': miniMenu }">
    <div class="flex my-2" :class="{ 'flex-col gap-4': miniMenu }">
      <UAvatar v-if="miniMenu" class="m-auto w-10 h-10" name="ORBE" description="ERP Software" size="2xl"
        :src="brandLogo" />
      <UUser v-if="!miniMenu" class="my-6 w-5/6" name="ORBE ERP" description="ERP Software" size="2xl" :avatar="{
        src: brandLogo,
        icon: 'i-lucide-image'
      }" />
      <UButton class="hidden sm:block" :description="miniMenu ? 'Expand menu' : 'Collapse menu'"
        :icon="miniMenu ? 'material-symbols:keyboard-double-arrow-right' : 'material-symbols:keyboard-double-arrow-left'"
        @click="toggleMenu" variant="soft" size="xl" />
    </div>
    <p v-if="!miniMenu" class="text-sm mt-3">Main</p>
    <USeparator class="mb-2" />
    <UButton v-for="item in mainItems" :key="item.label" :label="item.label" :description="item.description"
      :icon="item.icon" class="mb-2 w-full" variant="soft" @click="ui.changeView(item.value)" size="xl" />
    <p v-if="!miniMenu" class="text-sm mt-3">Admin</p>
    <USeparator class="mb-2" />
    <UButton v-for="item in adminItems" :key="item.label" :label="item.label" :description="item.description"
      :icon="item.icon" class="mb-2 w-full" variant="soft" @click="ui.changeView(item.value)" size="xl" />
    <p v-if="!miniMenu" class="text-sm mt-3">Config</p>
    <USeparator class="mb-2" />
    <UUser v-if="!miniMenu" name="Leo" description="Asesor comercial" :avatar="{
      src: userLogo,
      icon: 'i-lucide-image'
    }" class="mb-2 w-full" />

    <div v-if="!miniMenu" class="flex items-center justify-evenly mt-3">
      <UColorModeSwitch />
      <UButton description="Configure system preferences and options." icon="material-symbols:settings" variant="soft"
        @click="ui.changeView('Settings')" size="xl" />
      <UButton description="Sign out of the application." icon="material-symbols:logout" variant="soft" size="xl" />
      <UButton description="Toggle full screen."
        :icon="elem ? 'material-symbols:fullscreen-exit' : 'material-symbols:fullscreen'" variant="soft" size="xl"
        @click="toggleFullScreen()" />
    </div>
    <UButton v-if="miniMenu" class="w-full" label="Configuration"
      description="Configure system preferences and options." icon="material-symbols:settings" variant="soft"
      @click="ui.changeView('Settings')" size="xl" />
  </div>

</template>
