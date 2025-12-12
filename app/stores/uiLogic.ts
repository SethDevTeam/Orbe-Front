// app/composables/uiLogic.ts
import { defineStore } from 'pinia';

export const uiStore = defineStore('ui', {
  state: () => ({
    actualView: 'Dashboard',
    tabsList: ['tab0'],
  }),
  actions: {
    changeView(newView: string) {
      this.actualView = newView
    },
    addTab() {
      this.tabsList.push('tab' + this.tabsList.length)
    },
    removeTab() {
      this.tabsList.pop()
    }
  }
})

