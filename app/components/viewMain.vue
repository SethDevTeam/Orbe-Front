<script setup lang="ts">
import mainDashboard from '~/components/main/mainDashboard.vue'
import mainInvoicing from '~/components/main/mainInvoicing.vue'
import mainCRM from '~/components/main/mainCRM.vue'
import mainInventory from '~/components/main/mainInventory.vue'
import mainPayroll from '~/components/main/mainPayroll.vue'
import mainProfile from '~/components/main/mainProfile.vue'
import mainQuotations from '~/components/main/mainQuotations.vue'
import mainReports from '~/components/main/mainReports.vue'
import mainSettings from '~/components/main/mainSettings.vue'
import mainTeam from '~/components/main/mainTeam.vue'

import { uiStore } from '~/stores/uiLogic'

const ui = uiStore()

const currentComponent = computed(() => ({
  Dashboard: mainDashboard,
  Invoicing: mainInvoicing,
  CRM: mainCRM,
  Inventory: mainInventory,
  Payroll: mainPayroll,
  Profile: mainProfile,
  Quotations: mainQuotations,
  Reports: mainReports,
  Settings: mainSettings,
  Team: mainTeam
}[ui.actualView]))

</script>

<template>
  <component :is="currentComponent" />
</template>
