<script setup lang="ts">
const items = ['cliente1']
const value = ref('Cliente')
</script>
<template>
    <div class="w-full h-full flex flex-col p-2 sm:p-4 gap-2">
        <h1 class="w-full text-center text-2xl mb-2">Billing # AAAXXX</h1>
        <label>Client</label>
        <div class=" flex gap-2">
            <USelectMenu class="flex-1" :items="items" placeholder="Select client"
                icon="material-symbols:person" size="xl" />
            <UModal>
                <UButton label="Add" color="neutral" variant="subtle" trailing-icon="material-symbols:person-add" />
                <template #content>
                    <Placeholder class="h-48 m-4" />
                </template>
            </UModal>
        </div>
        <label>Items</label>
        <UModal>
            <UButton class="text-center flex justify-center" label="Add" color="neutral" variant="subtle" trailing-icon="material-symbols:add-shopping-cart" size="xl"/>
            <template #content>
                <Placeholder class="h-48 m-4" />
            </template>
        </UModal>
        <UContainer class="flex flex-col flex-1 gap-2 bg-auto border border-neutral-500 rounded-lg">
        </UContainer>
        <div class="flex gap-2">
            <UButton class="flex-1 flex justify-center" label="Cancel" color="neutral" variant="subtle" size="xl" />
            <UButton class="flex-3 flex justify-center" label="Save" color="primary" variant="subtle" size="xl"/>
        </div>
    </div>
</template>