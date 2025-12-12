import { defineEventHandler } from 'h3'

export default defineEventHandler(async () => {
  try {
    const db = useDatabase('prototype')

    // Check if items table exists
    const { rows: tables } = await db.sql`
      SELECT name FROM sqlite_master WHERE type='table'
    `

    return {
      success: true,
      tables: tables.map((t: any) => t.name)
    }
  } catch (error) {
    return {
      success: false,
      error: String(error)
    }
  }
})
