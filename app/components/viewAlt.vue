<script setup lang="ts">
import altDashboard from '~/components/alt/altDashboard.vue'
import altInvoicing from '~/components/alt/altInvoicing.vue'
import altCRM from '~/components/alt/altCRM.vue'
import altInventory from '~/components/alt/altInventory.vue'
import altPayroll from '~/components/alt/altPayroll.vue'
import altProfile from '~/components/alt/altProfile.vue'
import altQuotations from '~/components/alt/altQuotations.vue'
import altReports from '~/components/alt/altReports.vue'
import altSettings from '~/components/alt/altSettings.vue'
import altTeam from '~/components/alt/altTeam.vue'

import { uiStore } from '~/stores/uiLogic'

const ui = uiStore()

const currentComponent = computed(() => ({
  Dashboard: altDashboard,
  Invoicing: altInvoicing,
  CRM: altCRM,
  Inventory: altInventory,
  Payroll: altPayroll,
  Profile: altProfile,
  Quotations: altQuotations,
  Reports: altReports,
  Settings: altSettings,
  Team: altTeam
}[ui.actualView]))

</script>

<template>
  <component :is="currentComponent" />
</template>
